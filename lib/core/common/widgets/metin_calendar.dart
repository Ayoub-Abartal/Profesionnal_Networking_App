import 'package:flutter/material.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/calendar/calendar.dart';
import 'package:metin/core/utils/calendar/custom_calendar.dart';

import 'metin_button.dart';

typedef DateToVoidFunc = void Function(DateTime);

/// Creates a Calendar with the app design to use on desired pages.
/// The calender depends on Custom Calendar class that handles the dats calculation and management.
class MetinCalendar extends StatefulWidget {
  const MetinCalendar(
      {Key? key, required this.onSelect, required this.initialDate})
      : super(key: key);

  /// What will happen when the user selects a date
  final DateToVoidFunc onSelect;

  /// The initial date that will be selected for the user
  final DateTime initialDate;

  @override
  State<MetinCalendar> createState() => _MetinCalendarState();
}

class _MetinCalendarState extends State<MetinCalendar> {
  @override
  void initState() {
    super.initState();
    final date = widget.initialDate;
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
    midYear = _selectedDateTime.year;
  }

  void _getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
        _currentDateTime.month, _currentDateTime.year,
        startWeekDay: StartWeekDay.monday);
  }

  // get next month calendar
  void _getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    _getCalendar();
  }

  // get previous month calendar
  void _getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    _getCalendar();
  }

  /// The dates of the month that the user actually sees
  CalendarViews _currentView = CalendarViews.dates;

  /// The initial date and the date that will appear first
  late DateTime _currentDateTime;

  /// The newly selected date
  late DateTime _selectedDateTime;

  /// The dates depending on the month and the year
  List<Calendar> _sequentialDates = [];

  /// The year that will be focused on on the years select view
  late int midYear;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: aHeight(60, context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),

        // The view that the user is currently seeing
        child: (_currentView == CalendarViews.dates)
            ? _datesView()
            : (_currentView == CalendarViews.months)
                ? _showMonthsList()
                : _yearsView(midYear));
  }

  /// Returns the dates view (toggle between + dates + save button)
  Widget _datesView() {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              children: <Widget>[
                // prev month button
                _toggleBtn(false),
                // month and year
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        setState(() => _currentView = CalendarViews.months),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Birthday",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            "${_currentDateTime.year}",
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          Text(
                            monthNames[_currentDateTime.month - 1],
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _toggleBtn(true),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _calendarBody(),
          ],
        ),
        Positioned(
          bottom: 1,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: MetinButton(
              text: 'Save',
              isBorder: false,
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: const Color.fromARGB(255, 38, 131, 224),
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  /// Returns the toggle between buttons on the head of the calendar
  Widget _toggleBtn(bool next) {
    return InkWell(
      // Change the current month/year view next or previous
      onTap: () {
        if (_currentView == CalendarViews.dates) {
          setState(() => (next) ? _getNextMonth() : _getPrevMonth());
        } else if (_currentView == CalendarViews.year) {
          if (next) {
            midYear = midYear + 9;
          } else {
            midYear = midYear - 9;
          }
          setState(() {});
        }
      },
      child: Icon(
        (next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
        color: Colors.black,
      ),
    );
  } // calendar body

  /// Returns the calendar body which includes dates
  Widget _calendarBody() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _sequentialDates.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisCount: 7,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        if (_sequentialDates[index].date == _selectedDateTime) {
          return _selector(_sequentialDates[index]);
        }
        return _calendarDates(_sequentialDates[index]);
      },
    );
  } // calendar element

  /// Returns the actual dates
  Widget _calendarDates(Calendar calendarDate) {
    return InkWell(
      onTap: () {
        if (_selectedDateTime != calendarDate.date) {
          if (calendarDate.nextMonth) {
            _getNextMonth();
          } else if (calendarDate.prevMonth) {
            _getPrevMonth();
          }

          setState(() => _selectedDateTime = calendarDate.date);
          widget.onSelect(_selectedDateTime);
        }
      },
      child: Center(
          child: Text(
        '${calendarDate.date.day}',
        style: TextStyle(
          color: (calendarDate.thisMonth)
              ? (calendarDate.date.weekday == DateTime.sunday)
                  ? Theme.of(context).primaryColor
                  : Colors.black
              : (calendarDate.date.weekday == DateTime.sunday)
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
        ),
      )),
    );
  } // date selector

  /// Returns the circle selector when the user interacts with a date
  Widget _selector(Calendar calendarDate) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Theme.of(context).primaryColor, width: 4),
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.1), Colors.white],
          stops: const [0.1, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            '${calendarDate.date.day}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  /// Returns the months list
  Widget _showMonthsList() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              //switch to years views
              _currentView = CalendarViews.year;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '${_currentDateTime.year}',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: monthNames.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  // change month of currentDateTime
                  _currentDateTime = DateTime(_currentDateTime.year, index + 1);
                  _getCalendar();
                  // switch back to dates view
                  setState(() => _currentView = CalendarViews.dates);
                },
                title: Center(
                  child: Text(
                    monthNames[index],
                    style: TextStyle(
                        fontSize: 18,
                        color: (index == _currentDateTime.month - 1)
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Returns the years list views
  Widget _yearsView(int midYear) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            _toggleBtn(false),
            const Spacer(),
            _toggleBtn(true),
          ],
        ),
        Expanded(
          child: GridView.builder(
              padding: const EdgeInsets.only(left: 18, top: 40),
              shrinkWrap: true,
              itemCount: 15,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                int thisYear;
                if (index < 4) {
                  thisYear = midYear - (4 - index);
                } else if (index > 4) {
                  thisYear = midYear + (index - 4);
                } else {
                  thisYear = midYear;
                }
                return ListTile(
                  onTap: () {
                    // change year of currentDateTime
                    _currentDateTime =
                        DateTime(thisYear, _currentDateTime.month);
                    _getCalendar();
                    // switch back to months view
                    setState(() => _currentView = CalendarViews.months);
                  },
                  title: Text(
                    '$thisYear',
                    style: TextStyle(
                        fontSize: 18,
                        color: (thisYear == _currentDateTime.year)
                            ? Theme.of(context).primaryColor
                            : Colors.black),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
