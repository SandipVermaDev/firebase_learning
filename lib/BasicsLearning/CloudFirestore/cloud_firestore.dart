import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloudFirestore extends StatefulWidget {
  const CloudFirestore({super.key});

  @override
  State<CloudFirestore> createState() => _CloudFirestoreState();
}

class _CloudFirestoreState extends State<CloudFirestore> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CloudFirestore"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 100,),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  suffixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Description",
                  suffixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
              SizedBox(height: 80,),
              FilledButton(onPressed: (){
                uploadData(titleController.text.toString(), descriptionController.text.toString());
                titleController.clear();
                descriptionController.clear();
              }, child: Text("Add Data")),
              SizedBox(height: 20,),
        
              SizedBox(
                height: 250,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("CloudFirestore").snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }else{
                        final data=snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(data[index]["Title"]),
                              subtitle: Text(data[index]["Description"]),
                            ),
                          );
                        },);
                      }
                    },),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadData(String title,String description){
    if(title.isEmpty && description.isEmpty){
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Fields should not be empty."),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Ok"))
          ],
        );
      },);
    }else{
      FirebaseFirestore.instance.collection("CloudFirestore").doc(title).set(
          {
            "Title":title,
            "Description":description,
          }).then((onValue){
            log("Data Inserted");
      });
    }
  }
}
