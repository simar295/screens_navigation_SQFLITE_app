import 'package:flutter/material.dart';
import '/listmodel.dart';
import 'dbhelper.dart';

class sheet extends StatefulWidget {
  const sheet({super.key, required this.getsavefunction});
  final void Function(listmodel listmodehere) getsavefunction;

  @override
  State<sheet> createState() => _sheetState();
}

class _sheetState extends State<sheet> {
  final dbhelp = dbhelper.instance;

  void insertdata() async {
    Map<String, dynamic> rowhere = {
      dbhelper.columnname: titlecontroller.text,
      dbhelper.columnage: 17,
    };
    final id = await dbhelp.insert(rowhere);
    print("id is");
    print(id);
  }

  void queryall() async {
    var allrows = await dbhelp.queryall();
    allrows.forEach(
      (element) {
        print(element);
      },
    );
  }

  ///////////////////////////////////////////////////////
  final titlecontroller = TextEditingController();
  @override
  void dispose() {
    titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        TextField(
          decoration: InputDecoration(labelText: "enter text"),
          controller: titlecontroller,
        ),
        TextButton.icon(
            onPressed: () {
              widget.getsavefunction(listmodel(titlecontroller.text));
              insertdata();
              Navigator.pop(context);
              titlecontroller.clear();
            },
            icon: Icon(Icons.align_vertical_center),
            label: Text("save")),

//////////////////////////////////////////////////////////
      ],
    );
  }
}
