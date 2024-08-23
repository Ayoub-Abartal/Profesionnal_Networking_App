import 'package:flutter/material.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';

class DegreeData extends StatelessWidget {
  const DegreeData({Key? key, required this.data}) : super(key: key);

  /// The records of the Degree
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (data.isEmpty)
          SizedBox(
            height: aHeight(3.5, context),
            child: AText(
              text: "Not defined yet",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        if (data.isNotEmpty)
          data.entries
              .map((entry) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${entry.value["Title"]}, ${entry.value["Where"]}",
                        style: Theme.of(context).textTheme.bodyText1,
                        softWrap: true,
                      ),
                    ],
                  ))
              .toList()
              .last,
      ],
    );
  }
}
