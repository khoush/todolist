import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditTask extends StatelessWidget {
  final DocumentSnapshot task;
  final TextEditingController numController = TextEditingController();

  final TextEditingController nomController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heureController = TextEditingController();
  final TextEditingController cautionController = TextEditingController();
  final TextEditingController objectifController = TextEditingController();
  final TextEditingController observationController = TextEditingController();

  EditTask({required this.task}) {
    numController.text = task['num'];
    nomController.text = task['nom'];
    dateController.text = task['date'];
    heureController.text = task['heure'];
    cautionController.text = task['caution'];
    objectifController.text = task['objectif'];
    observationController.text = task['observation'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
        title: const Text(
          'Modifier offre',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                FirebaseFirestore.instance
                    .collection('tasks')
                    .doc(task.id)
                    .update({
                  'num': numController.text,
                  'nom': nomController.text,
                  'date': dateController.text,
                  'heure': heureController.text,
                  'caution': cautionController.text,
                  'objectif': objectifController.text,
                  'observation': observationController.text,
                }).then((value) {
                  Navigator.pop(context);
                }).catchError((error) {
                  print("Failed to update task: $error");
                });
              },
              child: Center(child: Text('Enregistrer')),
            ),
          ],
        ),
      ),
    );
  }
}
