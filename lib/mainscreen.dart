import 'package:flutter/material.dart';
import '/listmodel.dart';
import 'listwidget.dart';
import 'sheet.dart';
import 'dbhelper.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  //////////////////////////////////////////////

  final dbhelp = dbhelper.instance;

  @override
  void initState() {
    queryall();
    super.initState();
  }

  void queryall() async {
    var allrows = await dbhelp.queryall();
    setState(() {
      allrows.forEach(
        (element) {
          /*      places.removeRange(0, places.length); */
          places.add(listmodel(element.values.elementAt(1)));
          print(element.values.elementAt(1));
        },
      );
    });
  }

  ////////////////////////////////////////////////////////////////////////////////

  List<listmodel> places = [
  ];

  /////////////////////////////////////////////

  void add(listmodel listmode) {
    //parameter chahiye / milenge from next screen
    setState(() {
      places.add(listmode);
    });
  }

  /////////////////////////////////////////////////



  void delete(index) {
    setState(() {
      ScaffoldMessenger(child: SnackBar(content: Text("data deleted")));
      places.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("database concepts"),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (context) => sheet(
                            getsavefunction: add,
                          ));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: listwidget(
          addhere: add,
          passqueryall: queryall, ///////////////////////////
          nameslist: places,
          getdelete: (index) {
            delete(index);
          },
        ));
  }
}
