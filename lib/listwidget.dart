import 'package:flutter/material.dart';
import 'package:screens_navigation_list_app/sheet2.dart';
import '/listmodel.dart';
import 'dbhelper.dart';

class listwidget extends StatefulWidget {
  listwidget(
      {super.key,
      required this.nameslist,
      required this.getdelete,
      required this.addhere,
      required this.passqueryall});

  final List<listmodel> nameslist;
  final void Function(int index) getdelete;
  final void Function(listmodel listmode) addhere;
  final VoidCallback passqueryall;

  @override
  State<listwidget> createState() => _listwidgetState();
}

var isloading = true;

class _listwidgetState extends State<listwidget> {
  ////////////////////////////////////////////////////
  void updateui() {
    setState(() {
      isloading = false;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isloading = true;
        print("set state worked");
      });
    });
  }
//////////////////////////////////////////////////

  final dbhelp = dbhelper.instance;

  void deletedata(int index) async {
    var allrows = await dbhelp.queryall();
    var rows = allrows.elementAt(index);
    var id = await dbhelp.deletedata(rows["id"]);
    print(id);
  }

//////////////////////////////////////////////////
  String sendtitle = "";

  int sendindex = 1;

/////////////////////////////////////////////////
  ///
  void getdata(index) async {
    final dbhelp = dbhelper.instance;
    var allrows = await dbhelp.queryall();
    var rows = allrows.elementAt(index);
    //////////////////////////////
    sendtitle = rows["names"];
    sendindex = index;
    ////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? ListView.builder(
            itemCount: widget.nameslist.length,
            itemBuilder: (context, index) => Dismissible(
              onDismissed: (direction) {
                deletedata(index);
                widget.getdelete(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("data deleted"),
                  ),
                );
              },
              key: UniqueKey(),
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.lightBlue),
                child: ListTile(
                    onLongPress: () {
                      getdata(index);
                      showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          builder: (context) => sheet2(
                                getupdateui: updateui,
                                getlistsheet2: widget.nameslist,
                                getindex: sendindex,
                                gettitle: sendtitle,
                              ));
                    },
                    title: Text(widget.nameslist[index].name)),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
