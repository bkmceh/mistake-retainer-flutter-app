import 'dart:convert';

import 'package:add_names/data/MistakeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AllMistakes extends StatefulWidget {
  @override
  _AllMistakesState createState() => _AllMistakesState();
}

class _AllMistakesState extends State<AllMistakes> {
  final String _url = "http://10.0.2.2:8080/api/mistake-memory/mistakes";

  @override
  void initState() {
    parseMistakesList().then((value) {
      setState(() {
        MistakeStore.mistakeData = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      "ИМЯ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      "КАК ПРОВИНИЛСЯ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      "ДАТА",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                  ),
                ),
              ],
            ),
            MistakeStore.mistakeData.isEmpty
                ? Center(
                    child: Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 7,
                    ),
                  ))
                : Expanded(
                  child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  itemCount: MistakeStore.mistakeData.length,
                  itemBuilder: (context, int index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Center(
                              child: Text(
                                "${MistakeStore.mistakeData[index].causer}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Card(
                            color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${MistakeStore.mistakeData[index].mistake}",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Center(
                              child: Text(
                                "${MistakeStore.mistakeData[index].date}",
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic),
                              )),
                        ),
                      ],
                    );
                  }

                  ),
                )
          ],
        ),
      ),
    );
  }

  Future<List<Mistake>> parseMistakesList() async {
    final data = await http.get(_url);

    List<dynamic> decodeJson = jsonDecode(utf8.decode(data.bodyBytes));

    MistakeList mistakes = MistakeList.fromMappedJson(decodeJson);

    return mistakes.mistakes;
  }
}
