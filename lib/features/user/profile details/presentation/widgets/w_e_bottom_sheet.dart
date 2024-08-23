import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/core/utils/time_interval.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/screens/profileDetails/profile_details.dart';
import 'package:metin/features/user/profile%20details/presentation/screens/profileDetails/work_education_profile_details.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/metin_picker_button.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/tiles_content.dart';

import 'from_to_picker.dart';

class WorkEducationBottomSheet extends StatefulWidget {
  const WorkEducationBottomSheet({
    Key? key,
    required this.title,
    required this.category,
    this.isEdit = false,
    this.mKey,
  }) : super(key: key);

  /// The title of the sheet
  final String title;

  /// The category of the sheet
  final WorkEduCategory category;

  /// Is the sheet for adding or for modifying a record
  final bool isEdit;

  /// The key that identify the record on the map of records
  final String? mKey;

  @override
  State<WorkEducationBottomSheet> createState() =>
      _WorkEducationBottomSheetState();
}

class _WorkEducationBottomSheetState extends State<WorkEducationBottomSheet> {
  final double padding = 3;
  final TimeInterval _timeInterval = TimeInterval();
  String title = '', where = '';

  /// If the user still working in this role;
  bool isCurrentlyWorking = false;

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: aHeight(4, context), horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: MetinTextField(
              labelText: "Title",
              hintText: widget.category == WorkEduCategory.work
                  ? "ex: Software developer"
                  : "ex: Computer science",
              onChanged: (e) {
                setState(() {
                  title = e;
                });
              },
            ),
          ),
          if (widget.category != WorkEduCategory.work)
            Padding(
              padding: EdgeInsets.all(padding),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return MetinPickButton(
                    buttonTitle: Center(
                      child: Text(
                        state.education.toString() != "Education"
                            ? state.education.toString()
                            : "Degree",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MetinBottomSheet(
                          content: BlocProvider.value(
                            value: profileBloc,
                            child: TilesContent(
                              data: educationDegrees,
                              type: ProfileTiles.education,
                              title: "Education",
                              onPressed: (e) {
                                profileBloc
                                    .add(ProfileEducationChanged(education: e));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: MetinTextField(
              labelText: widget.category == WorkEduCategory.work
                  ? "Company"
                  : "University",
              hintText: widget.category == WorkEduCategory.work
                  ? "ex: Google"
                  : "ex: University of Cambridge, England",
              onChanged: (e) {
                setState(() {
                  where = e;
                });
              },
            ),
          ),
          MetinPickButton(
            showRightButtonArrow: false,
            buttonTitle: Row(
              children: [
                Text(
                  "From : ",
                  style: Theme.of(context).textTheme.button,
                ),
                FromToPicker(
                  onSelectMonth: (e) {
                    _timeInterval.fromMonth = e.toString();
                  },
                  onSelectYear: (e) {
                    _timeInterval.fromYear = e;
                  },
                  isEnabled: true,
                )
              ],
            ),
            onPressed: () {},
          ),
          if (widget.category == WorkEduCategory.work)
            CheckboxListTile(
              title: AText(
                text: "I am currently working in this role",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: isCurrentlyWorking,
              onChanged: (e) {
                setState(() {
                  isCurrentlyWorking = e!;
                  if (isCurrentlyWorking) {
                    _timeInterval.toMonth = "000";
                    _timeInterval.toYear = 0;
                  }
                });
              },
            ),
          MetinPickButton(
            showRightButtonArrow: false,
            buttonTitle: Row(
              children: [
                Text(
                  "To : ",
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: isCurrentlyWorking ? Colors.grey : null),
                ),
                FromToPicker(
                  onSelectMonth: (e) {
                    _timeInterval.toMonth = e.toString();
                  },
                  onSelectYear: (e) {
                    _timeInterval.toYear = e;
                  },
                  isEnabled: !isCurrentlyWorking,
                )
              ],
            ),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: MetinButton(
                text: 'Save',
                isBorder: false,
                onPressed: () {
                  if (widget.isEdit) {
                    switch (widget.category) {
                      case WorkEduCategory.work:
                        profileBloc.add(
                          ProfileWorkExpEdited(
                            we: {
                              "${widget.mKey}": {
                                "Title": title,
                                "Where": where,
                                "From": _timeInterval.getFromDate(),
                                "To": _timeInterval.getToDate(),
                              }
                            },
                          ),
                        );
                        break;
                      case WorkEduCategory.university:
                        profileBloc.add(
                          ProfileUniversityEdited(
                            university: {
                              "${widget.mKey}": {
                                "Title": title,
                                "Where": where,
                                "Degree": profileBloc.state.education,
                                "From": _timeInterval.getFromDate(),
                                "To": _timeInterval.getToDate(),
                              }
                            },
                          ),
                        );
                        break;
                    }
                  } else if (widget.isEdit == false) {
                    switch (widget.category) {
                      case WorkEduCategory.work:
                        DateTime newKey = DateTime.now();
                        profileBloc.add(
                          ProfileWorkExpAdded(
                            we: {
                              "$newKey": {
                                "Title": title,
                                "Where": where,
                                "From": _timeInterval.getFromDate(),
                                "To": _timeInterval.getToDate(),
                              }
                            },
                          ),
                        );
                        break;
                      case WorkEduCategory.university:
                        DateTime newKey = DateTime.now();
                        profileBloc.add(
                          ProfileUniversityAdded(
                            university: {
                              "$newKey": {
                                "Title": title,
                                "Where": where,
                                "Degree": profileBloc.state.education,
                                "From": _timeInterval.getFromDate(),
                                "To": _timeInterval.getToDate(),
                              }
                            },
                          ),
                        );
                        break;
                    }
                  }
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).primaryColor,
                textStyle: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
