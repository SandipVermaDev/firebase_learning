import 'package:firebase/BasicsLearning/demo/Pages/pets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../functions/cloud_database.dart';

class DatabseOptions extends StatefulWidget {
  const DatabseOptions({super.key});

  @override
  State<DatabseOptions> createState() => _DatabseOptionsState();
}

class _DatabseOptionsState extends State<DatabseOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Database options',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              // create();
              create('pets', 'kitty', 'Jerry', 'Cat', 5);
            }, child: const Text('Create')),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              update('pets', 'kitty', 'age', 8);
            }, child: const Text('Update')),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PetsList(),));
            }, child: const Text('Retrive')),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              delete('pets', 'kitty');
            }, child: const Text('Delete'))
          ],
        ),
      ),
    );
  }
}
