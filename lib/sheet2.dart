import 'package:flutter/material.dart';
import 'package:screens_navigation_list_app/listwidget.dart';
import '/listmodel.dart';
import 'dbhelper.dart';

class sheet2 extends StatefulWidget {
  const sheet2(
      {super.key,
      required this.getsavefunction,
      required this.gettitle,
      required this.getindex,
      required this.getqueryall,
      required this.getlistsheet2,
      required this.getlistwidget,
      required this.getupdateui});

  final void Function(listmodel listmodehere) getsavefunction;
  final String gettitle;
  final int getindex;
  final VoidCallback getqueryall;
  final listwidget getlistwidget;
  final List<listmodel> getlistsheet2;
  final VoidCallback getupdateui;

  @override
  State<sheet2> createState() => _sheetState();
}

class _sheetState extends State<sheet2> {
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

  void queryspecific() async {
    var allrows = await dbhelp.queryspecific(18);
    print(allrows);
  }

  void deletedata() async {
    var id = await dbhelp.deletedata(7);
    print(id);
  }

  void update() async {
    //  var rows = await dbhelp.update(1);
    //  print(rows);
  }

  //////////////////////////////////////////////////////

  void updates(int index, String name) async {
    var allrows = await dbhelp.queryall();
    var rows = allrows.elementAt(index);
    int mainid = rows["id"];
    print(mainid);
    print(name);
    var id = await dbhelp.update(mainid, name);
    print(id);
  }

  /*  void updateview() {
    widget.getqueryall;
    widget.getlistsheet2[widget.getindex] = listmodel(titlecontroller.text);
  } */

  void queryall2() {
    widget.getlistsheet2.removeAt(widget.getindex);
    widget.getlistsheet2.add(listmodel(titlecontroller.text));
/* 
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        print("set state worked");
      });
    });
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pop(context);
    }); */
  }

  ///////////////////////////////////////////////////////

/*   void queryall2() async {
    var allrows = await dbhelp.queryall();
    setState(() { 
    allrows.forEach(
      (element) {
        places.add(listmodel(element.values.elementAt(1)));
        print(element.values.elementAt(1));
      },
    );
    });
  }
 */
  /////////////////////////////////////////////////////
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
              //   widget.getsavefunction(listmodel(titlecontroller.text));
              updates(widget.getindex, titlecontroller.text);
              queryall2();
              titlecontroller.clear();
              Navigator.pop(context);
              widget.getupdateui();
            },
            icon: Icon(Icons.align_vertical_center),
            label: Text("save")),

//////////////////////////////////////////////////////////

        SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: insertdata,
          child: Text("insert"),
          style: ButtonStyle(),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: queryall,
          child: Text("query"),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: queryspecific,
          child: Text("query specific"),
        ),
        SizedBox(
          height: 0,
        ),
        ElevatedButton(
          onPressed: update,
          child: Text("update"),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: deletedata,
          child: Text("delete"),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
