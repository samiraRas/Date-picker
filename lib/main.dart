import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DateTimePicker(),
    );
  }
}

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key? key}) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Date & Time",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final date = await pickDate();

                      if (date == null) return;

                      setState(() {
                        dateTime = date;
                      });
                    },
                    child: Text(
                        "${dateTime.year}/${dateTime.month}/${dateTime.day}"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final time = await pickTime();

                        if (time == null) return;
                        final newDateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            time.hour,
                            time.minute);
                        setState(() {
                          dateTime = newDateTime;
                        });
                      },
                      child: Text("${dateTime.hour}:${dateTime.minute}"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1990),
      lastDate: DateTime(2060));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
