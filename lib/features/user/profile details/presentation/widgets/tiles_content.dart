import 'package:flutter/material.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/user/profile%20details/presentation/screens/profileDetails/profile_details.dart';

class TilesContent extends StatefulWidget {
  /// The data that the user will be able the select from
  final List<String>? data;

  /// What happens when the user select an option
  final void Function(String) onPressed;

  /// The type of tiles

  final ProfileTiles type;

  /// The title of sheet
  final String title;

  const TilesContent({
    Key? key,
    required this.data,
    required this.onPressed,
    required this.type,
    required this.title,
  }) : super(key: key);

  @override
  State<TilesContent> createState() => _TilesContentState();
}

class _TilesContentState extends State<TilesContent> {
  TextEditingController search = TextEditingController();
  late List<String> labels;
  late List<String> results;

  @override
  void initState() {
    labels = widget.data!.toList();
    results = widget.data!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AText(
            textSpaceHeight: aHeight(5, context),
            text: widget.title,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Colors.blue,
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: aWidth(70, context),
                  child: MetinTextField(
                    controller: search,
                    onChanged: ((e) {
                      setState(() {
                        labels = widget.data!
                            .where((element) =>
                                element.toLowerCase().contains(e.toLowerCase()))
                            .toList();
                        results = labels;
                        if (results.isEmpty &&
                            widget.type == ProfileTiles.industry) {
                          // making it jeut for industry because the education is const and not meant to be changed
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
            child: Column(
              children: [
                SizedBox(
                  height: aHeight(40, context),
                  width: double.infinity,
                  child: Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: results.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.9,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (results[index] == "Add a new value") {
                                widget.data!.insert(0, search.text);
                                widget.onPressed(search.text);
                              } else {
                                widget.onPressed(results[index]);
                              }

                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: AText(
                                  textSpaceHeight: aHeight(5.5, context),
                                  text: results[index],
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
