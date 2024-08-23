import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_app_bar.dart';
import 'package:metin/core/common/widgets/metin_back_button.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_error_snack_bar.dart';
import 'package:metin/core/common/widgets/metin_skip_button.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/common/widgets/multi_select_dialog.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/metin_picker_button.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/non_menu_buttons.dart';
import 'package:metin/features/user/profile%20details/presentation/widgets/tiles_content.dart';

enum ProfileTiles { industry, education }

class MoreProfileDetailsScreen extends StatelessWidget {
  const MoreProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthenticationBloc>();
    final profileBloc = context.read<ProfileBloc>();
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: const MetinAppBar(
              leading: MetinBackButton(),
              actions: MetinSkipButton(),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AText(
                        textSpaceHeight: aHeight(6.5, context),
                        text: 'Profile details',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: aHeight(0.3, context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 6.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: MetinTextField(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  onChanged: (value) {
                                    profileBloc
                                        .add(ProfileBioChanged(bio: value));
                                  },
                                  maxLines: 5,
                                  minLines: 2,
                                  hintText:
                                      "Don't be shy we would like to here about you :)",
                                  labelText: "Bio",
                                ),
                              ),
                            ),
                            MetinPickButton(
                              buttonTitle: Center(
                                child: Text(
                                  state.education.toString(),
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
                                          profileBloc.add(
                                              ProfileEducationChanged(
                                                  education: e));
                                        },
                                      ),
                                    ),
                                  ),
                                );
                                // metinBottomSheet(
                                //   context,
                                //   BlocProvider.value(
                                //     value: _profileBloc,
                                //     child: TilesContent(
                                //       data: educationDegrees,
                                //       type: ProfileTiles.education,
                                //       title: "Education",
                                //       onPressed: (e) {
                                //         _profileBloc.add(
                                //             ProfileEducationChanged(
                                //                 education: e));
                                //       },
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                            MetinPickButton(
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
                                        value: profileBloc,
                                        child: TilesContent(
                                          data: industries,
                                          type: ProfileTiles.industry,
                                          title: 'Industry',
                                          onPressed: (e) {
                                            profileBloc.add(
                                                ProfileIndustryChanged(
                                                    industry: e));
                                          },
                                        ),
                                      ),
                                    ));
                                // metinBottomSheet(
                                //   context,
                                //   BlocProvider.value(
                                //     value: _profileBloc,
                                //     child: TilesContent(
                                //       data: industries,
                                //       type: ProfileTiles.industry,
                                //       title: 'Industry',
                                //       onPressed: (e) {
                                //         _profileBloc.add(ProfileIndustryChanged(
                                //             industry: e));
                                //       },
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                            MetinPickButton(
                              buttonTitle: state.languages.isEmpty
                                  ? Center(
                                      child: Text(
                                        'Languages',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    )
                                  : NonMenuButtons(
                                      buttonsList: state.languages),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MetinBottomSheet(
                                      content: BlocProvider.value(
                                        value: profileBloc,
                                        child: BlocBuilder<ProfileBloc,
                                            ProfileState>(
                                          builder: (context, state) {
                                            return MultiSelectDialog(
                                              title: 'Languages',
                                              data: languages,
                                              previousSelects: state.languages,
                                              onSelect: (e) {
                                                profileBloc.add(
                                                    ProfileLanguageSelected(
                                                        language: e));
                                              },
                                              onDeselect: (e) {
                                                profileBloc.add(
                                                    ProfileLanguageDeselected(
                                                        language: e));
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ));
                                // metinBottomSheet(
                                //   context,
                                //   BlocProvider.value(
                                //     value: _profileBloc,
                                //     child:
                                //         BlocBuilder<ProfileBloc, ProfileState>(
                                //       builder: (context, state) {
                                //         return MultiSelectDialog(
                                //           title: 'Languages',
                                //           data: languages,
                                //           previousSelects: state.languages,
                                //           onSelect: (e) {
                                //             _profileBloc.add(
                                //                 ProfileLanguageSelected(
                                //                     language: e));
                                //           },
                                //           onDeselect: (e) {
                                //             _profileBloc.add(
                                //                 ProfileLanguageDeselected(
                                //                     language: e));
                                //           },
                                //         );
                                //       },
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                            MetinPickButton(
                              buttonTitle: Center(
                                child: state.skills.isEmpty
                                    ? Center(
                                        child: Text(
                                          'Skills',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      )
                                    : NonMenuButtons(buttonsList: state.skills),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MetinBottomSheet(
                                      content: BlocProvider.value(
                                        value: profileBloc,
                                        child: BlocBuilder<ProfileBloc,
                                            ProfileState>(
                                          builder: (context, state) {
                                            return MultiSelectDialog(
                                              title: "Skills",
                                              data: skills,
                                              previousSelects: state.skills,
                                              onSelect: (e) {
                                                profileBloc.add(
                                                    ProfileSkillSelected(
                                                        skill: e));
                                              },
                                              onDeselect: (e) {
                                                profileBloc.add(
                                                    ProfileSkillDeselected(
                                                        skill: e));
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ));
                                // metinBottomSheet(
                                //   context,
                                //   BlocProvider.value(
                                //     value: _profileBloc,
                                //     child:
                                //         BlocBuilder<ProfileBloc, ProfileState>(
                                //       builder: (context, state) {
                                //         return MultiSelectDialog(
                                //           title: "Skills",
                                //           data: skills,
                                //           previousSelects: state.skills,
                                //           onSelect: (e) {
                                //             _profileBloc.add(
                                //                 ProfileSkillSelected(skill: e));
                                //           },
                                //           onDeselect: (e) {
                                //             _profileBloc.add(
                                //                 ProfileSkillDeselected(
                                //                     skill: e));
                                //           },
                                //         );
                                //       },
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: aHeight(4, context),
                      ),
                      Center(
                        child: MetinButton(
                          text: 'Confirm',
                          isBorder: false,
                          onPressed: () {
                            Map info = {
                              "birthday":
                                  state.birthday.toString().split(" ")[0],
                              "bio": state.bio,
                              "industry": state.industry,
                              "gender": state.gender.toLowerCase()
                            };
                            if (profileBloc.state.bio.isNotEmpty &&
                                profileBloc.state.industry.isNotEmpty) {
                              authBloc.add(
                                UpdateProfileEvent(
                                  profile: info,
                                  onSuccess: () {
                                    Navigator.pushNamed(
                                        context, '/work-edu-page');
                                  },
                                  onError: (msg) {
                                    showErrorMessage(context, msg);
                                  },
                                ),
                              );
                            } else {
                              showErrorMessage(context,
                                  "Please don't be shy, tell us about your self");
                            }
                            // Navigator.of(context).pushNamed('/work-edu-page');
                          },
                          color: Theme.of(context).primaryColor,
                          textStyle: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
