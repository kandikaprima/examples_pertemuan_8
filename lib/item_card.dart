import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final int age;
  //// Pointer to Update Function
  final Function? onUpdate;
  //// Pointer to Delete Function
  final Function? onDelete;

  ItemCard(this.name, this.age, {this.onUpdate, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Text("$age Tahun")
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Colors.green[900],
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_upward),
                  ),
                  onPressed: (){
                    if (onUpdate != null) onUpdate!();
                  },
                ),
              ),
              SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Colors.red,
                  ),
                  child: Center(
                    child: Icon(Icons.delete),
                  ),
                  onPressed: (){
                    if (onDelete != null) onDelete!();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
