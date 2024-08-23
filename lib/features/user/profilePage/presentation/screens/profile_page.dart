import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/common/widgets/metin_icon_button.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/add_link.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/artwork_image.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/degree_data.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/distance_ticket.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/expandable_text.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/metin_plus_button.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/profile_text_title.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/tickets_section.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  final String name = 'Jessica Parker',
      title = 'Software engineer',
      location = 'Chicago, IL United States';
  final int age = 23;

  /// Is the profile for the connected user or just browsing
  final bool isCurrentUser = true;

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: aHeight(80, context),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/onBoarding/3.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: aHeight(100, context),
              child: DraggableScrollableSheet(
                minChildSize: 0.5,
                builder: (context, scrollController) {
                  return Stack(
                    children: [
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification:
                            (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowIndicator();
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 80,
                                    bottom: 50,
                                    left: 30,
                                    right: 30,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: aHeight(6.5, context),
                                        child: AText(
                                          text: "$name, $age",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: aHeight(4, context),
                                        child: Text(
                                          title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          softWrap: true,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const TitleText(
                                                text: "Location",
                                              ),
                                              Text(
                                                location,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                                softWrap: true,
                                              )
                                            ],
                                          ),

                                          /// If it the current user no need to show the distance
                                          isCurrentUser
                                              ? const SizedBox()
                                              : const DistanceTicket(
                                                  distance: 1)
                                        ],
                                      ),
                                      TitleText(
                                        text: "Bio",
                                        showEditButton: isCurrentUser,
                                        onEditPressed: () {
                                          Navigator.pushNamed(
                                              context, "/more-profile-details");
                                        },
                                      ),
                                      if (profileBloc.state.bio.isEmpty)
                                        SizedBox(
                                          height: aHeight(3.5, context),
                                          child: AText(
                                            text: "Not defined yet",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ExpandableText(
                                        text: profileBloc.state.bio,
                                      ),
                                      TitleText(
                                        text: "University",
                                        showEditButton: isCurrentUser,
                                        onEditPressed: () {
                                          Navigator.pushNamed(
                                              context, "/more-profile-details");
                                        },
                                      ),
                                      DegreeData(
                                          data:
                                              profileBloc.state.universities),
                                      TitleText(
                                        text: "Experience",
                                        showEditButton: isCurrentUser,
                                        onEditPressed: () {
                                          Navigator.pushNamed(
                                              context, "/work-edu-page");
                                        },
                                      ),
                                      DegreeData(
                                          data: profileBloc
                                              .state.workExperiences),
                                      const TitleText(
                                        text: "Interested by",
                                      ),
                                      BlocBuilder<ProfileBloc, ProfileState>(
                                        builder: (context, state) {
                                          return TicketsSection(
                                              isCurrentUser: isCurrentUser,
                                              blocVariable:
                                                  profileBloc.state.interests,
                                              bottomSheetTitle: "Interests",
                                              bottomSheetData: interests,
                                              previousSelects:
                                                  profileBloc.state.interests,
                                              onSelect: (e) {
                                                profileBloc.add(
                                                    ProfileInterestSelected(
                                                        interest: e));
                                              },
                                              onDeselect: (e) {
                                                profileBloc.add(
                                                    ProfileInterestDeselected(
                                                        interest: e));
                                              });
                                        },
                                      ),
                                      const TitleText(
                                        text: "Skills",
                                      ),
                                      BlocBuilder<ProfileBloc, ProfileState>(
                                        builder: (context, state) {
                                          return TicketsSection(
                                            isCurrentUser: isCurrentUser,
                                            blocVariable:
                                                profileBloc.state.skills,
                                            bottomSheetTitle: "Skills",
                                            bottomSheetData: skills,
                                            previousSelects:
                                                profileBloc.state.skills,
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
                                      TitleText(
                                        text: "Art work",
                                        seeAll: true,
                                        showEditButton: isCurrentUser,
                                        isPlusIcon: true,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: aHeight(26, context),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                ArtWorkImage(
                                                  image:
                                                      "assets/images/artWork/1.png",
                                                ),
                                                ArtWorkImage(
                                                  image:
                                                      "assets/images/artWork/2.png",
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: aHeight(18, context),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                ArtWorkImage(
                                                  image:
                                                      "assets/images/onBoarding/1.png",
                                                ),
                                                ArtWorkImage(
                                                  image:
                                                      "assets/images/onBoarding/2.png",
                                                ),
                                                ArtWorkImage(
                                                  image:
                                                      "assets/images/onBoarding/3.png",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const TitleText(
                                        text: "Links",
                                      ),
                                      BlocBuilder<ProfileBloc, ProfileState>(
                                        builder: (context, state) {
                                          return Wrap(
                                            spacing: 7,
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                isCurrentUser
                                                    ? profileBloc.state.links
                                                            .length +
                                                        1
                                                    : profileBloc.state.links
                                                        .length, (index) {
                                              if (isCurrentUser &&
                                                  index ==
                                                      profileBloc
                                                          .state.links.length) {
                                                return MetinPlusButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MetinBottomSheet(
                                                        content:
                                                            BlocProvider.value(
                                                          value: profileBloc,
                                                          child:
                                                              const AddLink(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                              return MetinIconButton(
                                                horizontalPadding: 0,
                                                color: Colors.black,
                                                icon: getIconFromLink(
                                                  profileBloc
                                                      .state.links[index],
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                      Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 160.0),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Report",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 1,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.black26.withOpacity(0.25)),
                                  elevation: MaterialStateProperty.all(30),
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(30)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.white), // <-- Button color
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.red.withOpacity(0.3)),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.xmark,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Returns an icon based on the url entered
  IconData getIconFromLink(String theLink) {
    String link = theLink.toLowerCase();
    if (link.contains("google")) {
      return FontAwesomeIcons.google;
    } else if (link.contains("facebook")) {
      return FontAwesomeIcons.facebook;
    } else if (link.contains("git")) {
      return FontAwesomeIcons.github;
    } else if (link.contains("linkedin")) {
      return FontAwesomeIcons.linkedin;
    } else if (link.contains("instagram")) {
      return FontAwesomeIcons.instagram;
    } else {
      return FontAwesomeIcons.globe;
    }
  }
}
