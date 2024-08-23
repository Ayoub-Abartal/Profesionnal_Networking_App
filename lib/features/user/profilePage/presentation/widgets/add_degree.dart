import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/screens/profileDetails/work_education_profile_details.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/w_e_bottom_sheet.dart';

class AddDegree extends StatelessWidget {
  const AddDegree(
      {Key? key,
      required this.title,
      required this.blocEntries,
      required this.category})
      : super(key: key);

  /// The degree title
  final String title;

  /// The selected entries
  final Map blocEntries;

  /// The category of entries
  final WorkEduCategory category;

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: blocEntries.entries
                  .map((entry) {
                    List<String> from =
                        entry.value["From"].toString().split(" ");
                    List<String> to = entry.value["To"].toString().split(" ");

                    String fromM = from[0].substring(0, 3),
                        toM = to[0].substring(0, 3),
                        fromY = from[1],
                        toY = to[1],
                        where = entry.value["Where"];

                    if (int.parse(toY) == 0) {
                      toM = "Present";
                      toY = "";
                    }
                    return Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category == WorkEduCategory.university
                                        ? "${entry.value["Degree"]} - ${entry.value["Title"]}"
                                        : "${entry.value["Title"]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                        "$fromM $fromY : $toM $toY - $where"),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 1,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MetinBottomSheet(
                                          content: BlocProvider.value(
                                            value: profileBloc,
                                            child: WorkEducationBottomSheet(
                                              mKey: "${entry.key}",
                                              isEdit: true,
                                              title: title.split(" ")[0],
                                              category: category,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      switch (category) {
                                        case WorkEduCategory.work:
                                          profileBloc.add(
                                              ProfileWorkExpRemoved(
                                                  we: entry.key));
                                          break;
                                        case WorkEduCategory.university:
                                          profileBloc.add(
                                              ProfileUniversityRemoved(
                                                  university: entry.key));
                                          break;
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        )
                      ],
                    );
                  })
                  .toList()
                  .reversed
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: aWidth(25, context),
                child: const Divider(
                  color: Colors.grey,
                  thickness: 0.6,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MetinBottomSheet(
                      content: BlocProvider.value(
                        value: profileBloc,
                        child: WorkEducationBottomSheet(
                          title: title.split(" ")[0],
                          category: category,
                        ),
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(
                    Colors.black26.withOpacity(
                      0.25,
                    ),
                  ),
                  elevation: MaterialStateProperty.all(
                    30,
                  ),
                  shape: MaterialStateProperty.all(
                    const CircleBorder(),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(15),
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(
                width: aWidth(25, context),
                child: const Divider(
                  color: Colors.grey,
                  thickness: 0.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
