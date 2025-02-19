import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiasAtendimentoPage extends StatefulWidget {
  @override
  _DiasAtendimentoPageState createState() => _DiasAtendimentoPageState();
}

class _DiasAtendimentoPageState extends State<DiasAtendimentoPage> {
  int selectedYear = 2025;
  int selectedMonth = DateTime.now().month;

  final List<String> months = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez'
  ];

  void _changeMonth(int monthIndex) {
    setState(() {
      selectedMonth = monthIndex + 1;
    });
  }

  void _navigateToDayDetails(DateTime date) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Dias de Atendimento'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () => setState(() => selectedYear--),
                ),
                Text(
                  '$selectedYear',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () => setState(() => selectedYear++),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: List.generate(months.length, (index) {
              return ElevatedButton(
                onPressed: () => _changeMonth(index),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  backgroundColor: selectedMonth == index + 1
                      ? Colors.blue
                      : Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  months[index],
                  style: TextStyle(
                    fontSize: 18,
                    color: selectedMonth == index + 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          Expanded(
            child: CalendarWidget(
              year: selectedYear,
              month: selectedMonth,
              onDateSelected: _navigateToDayDetails,
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  final int year;
  final int month;
  final Function(DateTime) onDateSelected;

  CalendarWidget(
      {required this.year, required this.month, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<String> weekDays = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

    return Column(
      children: [
        Text(
          '${DateFormat.MMMM().format(DateTime(year, month))} $year',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: weekDays
              .map((day) => Center(
                  child:
                      Text(day, style: TextStyle(fontWeight: FontWeight.bold))))
              .toList(),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemCount: daysInMonth,
            itemBuilder: (context, index) {
              DateTime currentDate = DateTime(year, month, index + 1);
              return GestureDetector(
                onTap: () => onDateSelected(currentDate),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
