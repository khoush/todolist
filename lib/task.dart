import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/edit.dart';
import 'package:todolist/firebase_options.dart';
import 'package:table_calendar/table_calendar.dart'; // Importez le package
import 'package:flutter_local_notifications/flutter_local_notifications.dart';






void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskList(),
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Accueil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
           
          
           
            SizedBox(height: 10,),
           TableCalendar( // Ajoutez le widget TableCalendar
            focusedDay: DateTime.now(),
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
          ),
        
          SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    final Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

                    return Card(
                      color: color,
                      child: ListTile(
                        title: Text(document['nom'], style: TextStyle(color: Colors.white)),
                        subtitle: Text('Date: ${document['date']}, Heure: ${document['heure']}', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TaskDetail(task: document)),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

}

class TaskDetail extends StatelessWidget {
  final DocumentSnapshot task;

  TaskDetail({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(task['nom'], style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Numéro: ${task['num']}'),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text('Date: ${task['date']}'),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text('Heure: ${task['heure']}'),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text('Caution: ${task['caution']}'),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text('Objectif: ${task['objectif']}'),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text('Observation: ${task['observation']}'),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
     floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditTask(task: task)),
              );
            },
            child: Icon(Icons.edit),
          ),
          SizedBox(height: 10),
         FloatingActionButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Voulez-vous vraiment supprimer cette offre ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme la boîte de dialogue
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                // Supprimer la tâche
                FirebaseFirestore.instance.collection('tasks').doc(task.id).delete().then((value) {
                  Navigator.pop(context); // Ferme la boîte de dialogue
                  Navigator.pop(context); // Retourne à la page précédente
                }).catchError((error) {
                  print("Failed to delete task: $error");
                });
              },
              child: Text("Supprimer"),
            ),
          ],
        );
      },
    );
  },
  child: Icon(Icons.delete),
),

        ],
      ),
      
    );
  }
}

class AddTask extends StatelessWidget {
  final TextEditingController numController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heureController = TextEditingController();
  final TextEditingController cautionController = TextEditingController();
  final TextEditingController objectifController = TextEditingController();
  final TextEditingController observationController = TextEditingController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Ajouter offre',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 40),
          TextField(
            controller: numController,
            decoration: InputDecoration(labelText: 'Num'),
          ),
          TextField(
            controller: nomController,
            decoration: InputDecoration(labelText: 'Nom'),
          ),
          TextField(
            controller: dateController,
            decoration: InputDecoration(labelText: 'Date'),
          ),
          TextField(
            controller: heureController,
            decoration: InputDecoration(labelText: 'Heure'),
          ),
          TextField(
            controller: cautionController,
            decoration: InputDecoration(labelText: 'Caution'),
          ),
          TextField(
            controller: objectifController,
            decoration: InputDecoration(labelText: 'Objectif'),
          ),
          TextField(
            controller: observationController,
            decoration: InputDecoration(labelText: 'Observation'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('tasks').add({
                'num' : numController.text,
                'nom': nomController.text,
                'date': dateController.text,
                'heure': heureController.text,
                'caution': cautionController.text,
                'objectif': objectifController.text,
                'observation': observationController.text,
              }).then((value) {
                _showNotification();
                Navigator.pop(context);
              }).catchError((error) {
                print("Failed to add task: $error");
              });
            },
            child: Center(child: Text('Ajouter')),
          ),
        ],
      ),
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, 'Tâche ajoutée', 'Votre tâche a été ajoutée avec succès.', platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
