import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // var data = await fileRead();
  // if (data != null) {
  //   String readData = await fileRead();
  //   print(readData);
  // }
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _savedData = "";
  @override
  void initState() {
    super.initState();
    _loadSaveData();
  }

  _loadSaveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.getString('data').isNotEmpty &&
          preferences.getString('data') != null) {
        _savedData = preferences.getString('data');
      } else {
        _savedData = "Empty Data";
      }
    });
  }

  _saveMs(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message);
  }

  var _enterData = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Testing I/O"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),

      //
      body: new Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _enterData,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(labelText: "Write Something..."),
          ),
          subtitle: new FlatButton(
            onPressed: () {
              // writeData(_enterData.text);
              _saveMs(_enterData.text.toString());
            },
            child: new Column(
              children: [
                new Text("Save Data"),
                new Padding(padding: new EdgeInsets.all(14.5)),
                // new FutureBuilder(
                //     future: fileRead(),
                //     builder:
                //         (BuildContext context, AsyncSnapshot<String> data) {
                //       if (data.hasData != null) {
                //         return new Text(data.data.toString(),
                //             style: new TextStyle(color: Colors.blueAccent));
                //       } else {
                //         return new Text("No Data Save");
                //       }
                //     }),

                new Text(
                  _savedData,
                  style: new TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> get _loclPath async {
  final dictory = await getApplicationDocumentsDirectory();
  return dictory.path;
}

Future<File> get _localFile async {
  final path = await _loclPath;
  return new File("$path/data.ext");
}

Future<File> writeData(String ms) async {
  final file = await _localFile;
  return file.writeAsString('$ms');
}

Future<String> fileRead() async {
  try {
    final file = await _localFile;
    String rdata = await file.readAsString();
    return rdata;
  } catch (e) {
    return "Noting Save Yet.";
  }
}
