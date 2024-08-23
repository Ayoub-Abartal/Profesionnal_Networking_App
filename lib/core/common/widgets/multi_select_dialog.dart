import 'package:flutter/material.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';

typedef StringToVoidFunc = void Function(String);

/// Creates an interface that has a title, a search bar, the data as buttons that the user will select from
/// an a button to save user changes and pops up back to the page where he was.
class MultiSelectDialog extends StatefulWidget {
  /// The dialog data which the user will select from
  final List<String>? data;

  /// The previously selected options
  final List<String> previousSelects;

  /// The title of the dialog
  final String title;

  /// What happens when the user selects
  final StringToVoidFunc onSelect;

  /// The happens when the user deselects
  final StringToVoidFunc onDeselect;

  const MultiSelectDialog({
    Key? key,
    required this.previousSelects,
    required this.data,
    required this.onSelect,
    required this.onDeselect,
    required this.title,
  }) : super(key: key);

  @override
  State<MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  TextEditingController search = TextEditingController();

  /// The labels that the user will select or deselect
  late List<String> labels;

  /// The search results
  late List<String> results;

  /// The user selected choices
  List<String> userChoices = [];

  @override
  void initState() {
    userChoices = widget.previousSelects.toList();
    labels = widget.data!.toList();
    results = widget.data!;
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: aHeight(5, context),
            child: AText(
              text: widget.title,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: aWidth(70, context),
                  child: MetinTextField(
                    controller: search,
                    onChanged: ((e) {
                      setState(() {
                        labels = widget.data!
                            .where((element) => element
                                .toLowerCase()
                                .contains(search.text.toLowerCase()))
                            .toList();
                        results = labels;
                        if (results.isEmpty) {
                          // for if the user didn't find what he was looking for.
                          results.add("Add a new value");
                        }
                      });
                    }),
                    hintText: "Search",
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: aHeight(25, context),
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 7,
                  children: List.generate(
                    results.length,
                    (index) => TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            userChoices.contains(results[index])
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (results[index] == "Add a new value") {
                          // if non found add the entered user choice
                          widget.data!.insert(0, search.text);
                          widget.onSelect(search.text);

                          search.clear();
                          results = widget.data!;
                          userChoices.add(results[0]);
                        } else {
                          if (!userChoices.contains(results[index])) {
                            userChoices.add(results[index]);
                            widget.onSelect(results[index]);
                          } else {
                            userChoices.remove(results[index]);
                            widget.onDeselect(results[index]);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: AText(
                          text: results[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: (userChoices.contains(results[index]))
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: MetinButton(
                  text: 'Save',
                  isBorder: false,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).primaryColor,
                  textStyle: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
