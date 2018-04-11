import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:datetimepickerdemo/customcalendar.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));

    if (picked != null && picked != _date) {
      print('Date Selected${picked.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectedTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      print('Time Selected${picked.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  void handleNewDate(date) {
    print(date);
  }

  void test(BuildContext context, DateTime time) {
    //print(time);
  }

  _launchURL() async {
    const url = 'tel:+95';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Calendar'),
        ),
        body: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          /*child: new Calendar(
            onDateSelected: (date) =>handleNewDate(date),
            showCalendarPickerIcon: false,
            isExpandable: false,
            showChevronsToChangeRange: false,
            showTodayAction: false,
          ),*/
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Text('The Default Calendar:'),
              new Calendar(
                onDateSelected: (date) => handleNewDate(date),
              ),
              new Divider(
                height: 50.0,
              ),
              new Text('The Expanded Calendar:'),
              new Calendar(
                isExpandable: true,
              ),
              new Divider(
                height: 50.0,
              ),
              new Text('A Custom Weekly Calendar:'),
              new Calendar(
                onSelectedRangeChange: (range) => print(range),
                isExpandable: true,
                dayBuilder: (BuildContext context, DateTime day) {
                  return new InkWell(
                    onTap: () => print(day),
                    child: new Container(
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black38)),
                      child: new Text(
                        day.day.toString(),
                      ),
                    ),
                  );
                },
              ),
              new CustomCalendar(
                //onDateSelected: (date) => handleNewDate(date),
                isExpandable: true,
              ),
              new Center(
                child: new RaisedButton(
                  onPressed: () {
                    _launchURL();
                  },
                  child: new Text('Go To'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
