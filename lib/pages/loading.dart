// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  getData() async {
    Response receivedDataFromAPI = await get(
        Uri.parse('http://worldtimeapi.org/api/timezone/Africa/Cairo'));
    Map receivedData = jsonDecode(receivedDataFromAPI.body);

    DateTime datetime = DateTime.parse(receivedData["utc_datetime"]);
    print(datetime);

    int offset = int.parse(receivedData["utc_offset"].substring(0, 3));
    print(offset);

    DateTime realTime = datetime.add(Duration(hours: offset));
    print(DateFormat('hh:mm a').format(realTime));

    print(receivedData["timezone"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SpinKitFadingCircle(
            //   color: Color.fromARGB(146, 12, 16, 49),
            //   size: 160.0,
            // )

            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: Text(
                "click here",
                style: TextStyle(fontSize: 22),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 46, 75, 156)),
                padding: MaterialStateProperty.all(EdgeInsets.all(18)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
