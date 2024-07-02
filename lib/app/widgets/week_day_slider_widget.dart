import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekSlider extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const WeekSlider({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  _WeekSliderState createState() => _WeekSliderState();
}

class _WeekSliderState extends State<WeekSlider> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  List<DateTime> _getWeekDates(DateTime currentDate) {
    final startOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates(selectedDate);

    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekDates.length,
        itemBuilder: (context, index) {
          final date = weekDates[index];
          final isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
              widget.onDateSelected(date);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.E().format(date), // Day name
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    date.day.toString(), // Day number
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
