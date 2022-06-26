import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data = "";
  List<String> list = ["Go Home", "Study AI", "CODE THE PROJECT"];
  List<bool> checkedOrNot = [false, false, false];

  TextEditingController? txtEdit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My TodoList"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Container(
                      width: 330,
                      height: 180,
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Enter Task Title",
                                hintStyle: TextStyle(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: EdgeInsets.all(10)),
                            style: TextStyle(fontSize: 20),
                            controller: txtEdit,
                            onChanged: (val) {
                              data = val;
                            },
                            onSubmitted: (val) {
                              setState(() {
                                list.add(val);
                                checkedOrNot.add(false);
                                Navigator.pop(context);
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            child: MaterialButton(
                                height: 50,
                                minWidth: 250,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                color: Colors.blue,
                                onPressed: () {
                                  setState(() {
                                    list.add(data);
                                    checkedOrNot.add(false);
                                    data = "";
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                          )
                        ],
                      )),
                );
              });
        },
      ),
      body: Column(children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TASKS (${list.length})",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(
            color: Colors.lightBlue.shade300,
            thickness: 2.5,
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                          value: checkedOrNot[index],
                          onChanged: (val) {
                            setState(() {
                              checkedOrNot[index] = val!;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onLongPress: () {
                          setState(() {
                            list.removeAt(index); 
                          });
                        },
                        child: Text(
                          list[index],
                          style: TextStyle(
                              fontSize: 26,
                              decoration: checkedOrNot[index]
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                      ),
                    ],
                  );
                }))
      ]),
    );
  }
}
