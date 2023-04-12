import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examples_pertemuan_8/item_card.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStore Demo"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: users.snapshots(),
                builder: (_, snapshot) {
                  return (snapshot.hasData)
                      ? Column(
                        children: snapshot.data!.docs.map((e) => ItemCard(
                          e.get('name'),
                          e.get('age'),
                          onUpdate: (){
                            users.doc(e.id).update({
                              'name' : nameController.text,
                              'age' : int.tryParse(ageController.text) ??0,
                            });
                            nameController.text = "";
                            ageController.text = "";
                          },
                          onDelete: (){
                            users.doc(e.id).delete();
                          },
                        ),).toList(),
                      )
                      : Center(
                          child: Text("loading"),
                      );
                },
              ),
              SizedBox(height: 150,),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 130,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(-5, 0),
                    blurRadius: 15,
                    spreadRadius: 3)
              ]),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(hintText: "Name"),
                        ),
                        TextField(
                          controller: ageController,
                          decoration: InputDecoration(hintText: "Age"),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 130,
                    padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: ElevatedButton(
                      child: Text("Add Data"),
                      onPressed: () {
                        users.add({
                          'name' : nameController.text,
                          'age' : int.tryParse(ageController.text),
                        });
                        nameController.text = "";
                        ageController.text = "";
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
