import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_slider.dart';
import 'package:metin/core/common/widgets/multi_select_dialog.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/swipe/presentation/bloc/filter/filter_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/screens/profileDetails/profile_details.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/metin_picker_button.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/non_menu_buttons.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/tiles_content.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  /// The space around the track
  final double horizontalPaddingOfTrack = 35;

  @override
  Widget build(BuildContext context) {
    var filterBloc = context.read<FilterBloc>();

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: aHeight(5, context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Looking for",
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPaddingOfTrack),
            child: Column(
              children: [
                BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    return MetinPickButton(
                      buttonTitle: Center(
                        child: state.interests.isEmpty
                            ? Center(
                                child: Text(
                                  'Looking for',
                                  style: Theme.of(context).textTheme.button,
                                ),
                              )
                            : NonMenuButtons(buttonsList: state.interests),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MetinBottomSheet(
                            content: BlocProvider.value(
                              value: filterBloc,
                              child: BlocBuilder<FilterBloc, FilterState>(
                                builder: (context, state) {
                                  return MultiSelectDialog(
                                    title: 'Looking for:',
                                    data: interests,
                                    previousSelects: state.interests,
                                    onSelect: (e) {
                                      filterBloc.add(
                                          FilterInterestSelected(interest: e));
                                    },
                                    onDeselect: (e) {
                                      filterBloc.add(FilterInterestDeselected(
                                          interest: e));
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                MetinSlider(
                  horizontalPaddingOfTrack: horizontalPaddingOfTrack,
                  leadingText: "Distance",
                  minValue: 0,
                  maxValue: 200,
                  defaultValue: filterBloc.state.distance,
                  unit: "km",
                  onChanged: (e) {
                    filterBloc.add(FilterDistanceChanged(distance: e));
                  },
                ),
                MetinSlider(
                  horizontalPaddingOfTrack: horizontalPaddingOfTrack,
                  leadingText: "Age",
                  minValue: 16,
                  maxValue: 100,
                  defaultValue: filterBloc.state.age,
                  unit: "yo",
                  onChanged: (e) {
                    filterBloc.add(FilterAgeChanged(age: e));
                  },
                ),
                BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    return MetinPickButton(
                      buttonTitle: Center(
                        child: Text(
                          state.industry.toString(),
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MetinBottomSheet(
                            content: BlocProvider.value(
                              value: filterBloc,
                              child: TilesContent(
                                onPressed: (e) {
                                  filterBloc
                                      .add(FilterIndustryChanged(industry: e));
                                },
                                data: industries,
                                type: ProfileTiles.industry,
                                title: 'Industry',
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    return MetinPickButton(
                      buttonTitle: Center(
                        child: state.skills.isEmpty
                            ? Center(
                                child: Text(
                                  'Skills',
                                  style: Theme.of(context).textTheme.button,
                                ),
                              )
                            : NonMenuButtons(buttonsList: state.skills),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MetinBottomSheet(
                            content: BlocProvider.value(
                              value: filterBloc,
                              child: BlocBuilder<FilterBloc, FilterState>(
                                builder: (context, state) {
                                  return MultiSelectDialog(
                                    title: "Skills",
                                    data: skills,
                                    previousSelects: state.skills,
                                    onSelect: (e) {
                                      filterBloc
                                          .add(FilterSkillSelected(skill: e));
                                    },
                                    onDeselect: (e) {
                                      filterBloc
                                          .add(FilterSkillDeselected(skill: e));
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
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
