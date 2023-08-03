import 'package:flutter/material.dart';
import '/listmodel.dart';
import 'dbhelper.dart';

class sheet2 extends StatefulWidget {
  const sheet2(
      {super.key,
    
      required this.gettitle,
      required this.getindex,
      required this.getlistsheet2,
      required this.getupdateui});

  final String gettitle;
  final int getindex;
  final List<listmodel> getlistsheet2;
  final VoidCallback getupdateui;

  @override
  State<sheet2> createState() => _sheetState();
}

class _sheetState extends State<sheet2> {
  final dbhelp = dbhelper.instance;

  void updates(int index, String name) async {
    var allrows = await dbhelp.queryall();
    var rows = allrows.elementAt(index);
    int mainid = rows["id"];
    print(mainid);
    print(name);
    var id = await dbhelp.update(mainid, name);
    print(id);
  }

  void queryall2() {
    widget.getlistsheet2.removeAt(widget.getindex);
    widget.getlistsheet2.add(listmodel(titlecontroller.text));
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
    titlecontroller.text = widget.gettitle;
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
              updates(widget.getindex, titlecontroller.text);
              queryall2();
              titlecontroller.clear();
              Navigator.pop(context);
              widget.getupdateui();
            },
            icon: Icon(Icons.align_vertical_center),
            label: Text("save")),

//////////////////////////////////////////////////////////
      ],
    );
  }
}
