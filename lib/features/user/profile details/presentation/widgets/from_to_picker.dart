import 'package:flutter/material.dart';
import 'package:metin/core/constants.dart';

class FromToPicker extends StatefulWidget {
  const FromToPicker(
      {Key? key,
      required this.onSelectMonth,
      required this.onSelectYear,
      required this.isEnabled})
      : super(key: key);

  /// What happen when the month is selected
  final void Function(dynamic) onSelectMonth;

  /// What happen when the year is selected
  final void Function(dynamic) onSelectYear;

  /// Is the user have the ability to tap it
  final bool isEnabled;

  @override
  State<FromToPicker> createState() => _FromToPickerState();
}

class _FromToPickerState extends State<FromToPicker> {
  int year = DateTime.now().year;
  String month = "January";

  final List<int> years =
      List<int>.generate(100, (int index) => (DateTime.now().year - index) + 5);
  @override
  Widget build(BuildContext context) {
    Color textColor =
        widget.isEnabled ? Theme.of(context).primaryColor : Colors.grey;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: PopupMenuButton(
            enabled: widget.isEnabled,
            initialValue: "January",
            child: Row(
              children: [
                Text(
                  month.substring(0, 3),
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: textColor),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey,
                )
              ],
            ),
            itemBuilder: (context) {
              return List.generate(
                monthNames.length,
                (index) => PopupMenuItem(
                  onTap: () {
                    setState(() {
                      month = monthNames[index];
                    });
                    widget.onSelectMonth(monthNames[index]);
                  },
                  child: Text(
                    monthNames[index],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: PopupMenuButton(
            enabled: widget.isEnabled,
            initialValue: DateTime.now().year,
            child: Row(
              children: [
                Text(
                  year.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: textColor),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey,
                )
              ],
            ),
            itemBuilder: (context) {
              return List.generate(
                years.length,
                (index) => PopupMenuItem(
                  onTap: () {
                    setState(() {
                      year = years[index];
                    });
                    widget.onSelectYear(years[index]);
                  },
                  child: Text(
                    years[index].toString(),
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
