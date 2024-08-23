import 'package:flutter/material.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';

class NonMenuButtons extends StatelessWidget {
  const NonMenuButtons({
    Key? key,
    required this.buttonsList,
  }) : super(key: key);

  /// The list of the selected choices
  final List<String> buttonsList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 7,
        children: [
          SizedBox(
            height: 30,
            width: aWidth(65, context),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: buttonsList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Text(
                      buttonsList[index],
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
