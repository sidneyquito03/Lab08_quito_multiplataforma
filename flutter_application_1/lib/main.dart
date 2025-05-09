import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _calendarHeader(context),
                const SizedBox(height: 4.0),
                calendarWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _calendarHeader(BuildContext context) {
    const Color rojoAnaranjado = Color(0xFFFF4500);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "juin 2019",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text("lun.", style: TextStyle(color: rojoAnaranjado)),
            Text("mar.", style: TextStyle(color: rojoAnaranjado)),
            Text("mer.", style: TextStyle(color: rojoAnaranjado)),
            Text("jeu.", style: TextStyle(color: rojoAnaranjado)),
            Text("ven.", style: TextStyle(color: rojoAnaranjado)),
            Text("sam.", style: TextStyle(color: rojoAnaranjado)),
            Text("dim.", style: TextStyle(color: rojoAnaranjado)),
          ],
        ),
        const Divider(thickness: 0.5),
      ],
    );
  }

  Widget calendarWidget(BuildContext context) {
    const double size02 = 16.0;
    const double daySpacing = 0.5;

    List<int> daysInMonth = List.generate(30, (index) => index + 1);

    int emptyDaysBefore = 5;

    List<Widget> calendarDays = List.generate(emptyDaysBefore, (index) {
      return const SizedBox.shrink();
    });

    calendarDays.addAll(daysInMonth.map((day) {
      bool isSelectedDay = day == 28;
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: isSelectedDay ? Colors.grey[300] : Colors.blueGrey[50],
            shape: isSelectedDay ? BoxShape.circle : BoxShape.rectangle,
            border: isSelectedDay
                ? Border.all(color: Colors.black87, width: 1.5)
                : null,
            borderRadius: isSelectedDay ? null : BorderRadius.circular(4),
            boxShadow: [
              if (!isSelectedDay)
                BoxShadow(
                  color: Color(0xFFFF4500),
                  spreadRadius: 0.5,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
            ],
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: size02,
                fontWeight: isSelectedDay ? FontWeight.bold : FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      );
    }));

    List<Widget> leadingDays = List.generate(
        5,
        (index) => _buildAdjacentDay(
            27 + index, size02, daySpacing, Colors.grey[400]!));
    List<Widget> trailingDays = List.generate(
        7,
        (index) => _buildAdjacentDay(
            1 + index, size02, daySpacing, Colors.grey[400]!));

    List<Widget> allCalendarItems = [
      ...leadingDays,
      ...calendarDays,
      ...trailingDays
    ];

    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          crossAxisSpacing: 0.5,
          mainAxisSpacing: 0.5,
        ),
        itemCount: allCalendarItems.length,
        itemBuilder: (context, index) {
          return allCalendarItems[index];
        },
      ),
    );
  }

  Widget _buildAdjacentDay(
      int day, double fontSize, double spacing, Color color) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          '$day',
          style: TextStyle(
            fontSize: fontSize,
            color: color,
          ),
        ),
      ),
    );
  }
}
