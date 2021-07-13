import 'package:add_names/AllMistakes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  var url = Uri.parse('http://10.0.2.2:8080/api/mistake-memory/new');
  String _chosenValue;
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  "Фиксатор ошибок",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          hintText: "Напиши ошибку",
                          fillColor: Colors.black12,
                          filled: true)),
                ),
              ),
              DropdownButton<String>(
                value: _chosenValue,
                style: TextStyle(color: Colors.black),
                items: <String>['Абузяр', 'Данила', 'Захар', 'Ильсур', 'Санжар']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "выбери виновного",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (String value) {
                  setState(() {
                    _chosenValue = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: FlatButton(
                  height: 70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "       добавить       ",
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    if (_controller.text.isNotEmpty && _chosenValue != null) {
                      DateTime now = new DateTime.now();
                      var currentTime = DateTime(now.year, now.month, now.day);
                      String date = "${currentTime.day}-${currentTime.month}-${currentTime.year}";
                      http.post(url, body: {
                        'causer': _chosenValue,
                        'mistake': _controller.text,
                        'date': date});
                      print(_controller.text);
                      print(date);
                      _controller.clear();
                    }
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FlatButton(
                  height: 70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "       показать все       ",
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllMistakes()));
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
