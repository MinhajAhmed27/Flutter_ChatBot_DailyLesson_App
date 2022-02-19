import 'package:flutter/material.dart';
import 'package:slsupport/screens/home_screen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class DailLessonScreen extends StatefulWidget {
  const DailLessonScreen({Key? key}) : super(key: key);

  @override
  _DailLessonScreenState createState() => _DailLessonScreenState();
}

class _DailLessonScreenState extends State<DailLessonScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }
            ),
            title: Text(
              "Daily Lesson",
            ),
          ),
            body:
            SfCalendar(
              view: CalendarView.schedule,
              dataSource: MeetingDataSource(_getDataSource()),
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        )
        )
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime startTime1 =
    DateTime(today.year, today.month, today.day + 5, 9, 0, 0);
    final DateTime startTime2 =
    DateTime(today.year, today.month, today.day + 2, 9, 0, 0);

    final DateTime endTime1 = startTime.add(const Duration(hours: 2));
    final DateTime endTime2 = startTime.add(const Duration(hours: 1));
    meetings.add(
        Meeting('Greetings Lesson', startTime1, endTime1, const Color(0xFF0F8644), false));
    meetings.add(
        Meeting('Thanking Lesson', startTime2, endTime2, const Color(0xFF0F8644), false));
    meetings.add(
        Meeting('Gesture Lesson', startTime, endTime1, const Color(0xFF0F8644), false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}