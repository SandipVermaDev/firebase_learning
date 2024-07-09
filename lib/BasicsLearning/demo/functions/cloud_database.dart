import 'package:cloud_firestore/cloud_firestore.dart';

// create() async {
//   await FirebaseFirestore.instance.collection('pets').doc('tom').set({
//     'name':'Tom',
//     'animal':'Dog',
//     'age':12
//   });
//   print('database Created');
// }

create(String collName,docName,name,animal,int age) async{
  await FirebaseFirestore.instance
      .collection(collName)
      .doc(docName)
      .set({'name':name,'animal':animal,'age':age});
  print('database created');
}

update(String collName,docName,field,var newFieldValue)async{
  await FirebaseFirestore.instance
      .collection(collName)
      .doc(docName)
      .update({field:newFieldValue});
  print('Field Updated');
}

delete(String collName,docName)async{
  await FirebaseFirestore.instance
      .collection(collName)
      .doc(docName)
      .delete();
  print('Document Deleted');
}