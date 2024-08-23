import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_app_bar.dart';
import 'package:metin/core/common/widgets/metin_back_button.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_skip_button.dart';
import 'package:metin/core/common/widgets/multi_select_dialog.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/metin_picker_button.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/non_menu_buttons.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/add_degree.dart';

enum WorkEduCategory { work, university }

class WorkEducationScreen extends StatelessWidget {
  const WorkEducationScreen({Key? key}) : super(key: key);

//entry.key, entry.value
  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      appBar: const MetinAppBar(
        leading: MetinBackButton(),
        actions: MetinSkipButton(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: aHeight(100, context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: aHeight(6.5, context),
                            child: AText(
                              text: 'Profile details',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          SizedBox(
                            height: aHeight(3, context),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Column(
                              children: [
                                if (profileBloc.state.education != "Education")
                                  AddDegree(
                                    blocEntries:
                                        profileBloc.state.universities,
                                    category: WorkEduCategory.university,
                                    title: 'University :',
                                  ),
                                AddDegree(
                                  blocEntries:
                                      profileBloc.state.workExperiences,
                                  category: WorkEduCategory.work,
                                  title: 'Experience :',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Looking for :",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: MetinPickButton(
                                          buttonTitle: state.interests.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    'Choose an option (s)',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button,
                                                  ),
                                                )
                                              : NonMenuButtons(
                                                  buttonsList: state.interests),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MetinBottomSheet(
                                                content: BlocProvider.value(
                                                  value: profileBloc,
                                                  child: BlocBuilder<
                                                      ProfileBloc,
                                                      ProfileState>(
                                                    builder: (context, state) {
                                                      return MultiSelectDialog(
                                                        title: 'Looking for:',
                                                        data: interests,
                                                        previousSelects:
                                                            state.interests,
                                                        onSelect: (e) {
                                                          profileBloc.add(
                                                              ProfileInterestSelected(
                                                                  interest: e));
                                                        },
                                                        onDeselect: (e) {
                                                          profileBloc.add(
                                                              ProfileInterestDeselected(
                                                                  interest: e));
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
                child: MetinButton(
                  text: 'Confirm',
                  isBorder: false,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home-screen');
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
      ),
    );
  }
}
