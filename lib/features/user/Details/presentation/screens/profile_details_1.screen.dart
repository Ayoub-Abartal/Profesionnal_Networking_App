import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_app_bar.dart';
import 'package:metin/core/common/widgets/metin_back_button.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_calendar.dart';
import 'package:metin/core/common/widgets/metin_error_snack_bar.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:metin/features/user/Details/presentation/bloc/imagePicker/image_picker_bloc.dart';
import 'package:metin/features/user/Details/presentation/widgets/gender_select_buttons.dart';
import 'package:metin/features/user/Details/presentation/widgets/my_image_picker.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';

class MainProfileDetailScreen extends StatelessWidget {
  const MainProfileDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc(),
      child: ProfileDetailsView(),
    );
  }
}

class ProfileDetailsView extends StatelessWidget {
  ProfileDetailsView({Key? key}) : super(key: key);
  final DateTime today = DateTime.now();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var authBloc = context.read<AuthenticationBloc>();

    // Calculating the sizes depending on the screen width
    final double smallImagePickerSize = aWidth(20, context);
    final double bigImagePickerSize = aWidth(40, context);
    final double imagePickerIconContainerSize = aWidth(12, context);

    return Scaffold(
        appBar: const MetinAppBar(
          leading: MetinBackButton(),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: aHeight(1.2, context)),
                //Login with email Text
                AText(
                  textSpaceHeight: aHeight(6.5, context),
                  text: 'Profile details',
                  style: Theme.of(context).textTheme.headline2,
                ),

                SizedBox(height: aHeight(2.2, context)),

                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyImagePicker(
                        index: 0,
                        photoContainerSize:
                            Size(bigImagePickerSize, bigImagePickerSize),
                        iconButtonSize: 20.0,
                        iconContainerSize: Size(imagePickerIconContainerSize,
                            imagePickerIconContainerSize),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyImagePicker(
                            index: 1,
                            photoContainerSize: Size(
                                smallImagePickerSize, smallImagePickerSize),
                            iconButtonSize: 15.0,
                            iconContainerSize: Size(
                                imagePickerIconContainerSize - 8,
                                imagePickerIconContainerSize - 8),
                          ),
                          MyImagePicker(
                            index: 2,
                            photoContainerSize: Size(
                                smallImagePickerSize, smallImagePickerSize),
                            iconButtonSize: 15.0,
                            iconContainerSize: Size(
                                imagePickerIconContainerSize - 8,
                                imagePickerIconContainerSize - 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: MetinTextField(
                        controller: firstName,
                        hintText: 'david',
                        labelText: 'First name',
                        isObscure: false,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: MetinTextField(
                      controller: lastName,
                      labelText: 'Last name',
                      hintText: 'posto',
                      isObscure: false,
                    ),
                  ),
                ]),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          profileBloc
                              .add(const ProfileGenderChanged(gender: "Women"));
                        },
                        child: const GenderRadioButton(
                          value: 'Women',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          profileBloc
                              .add(const ProfileGenderChanged(gender: "Man"));
                        },
                        child: const GenderRadioButton(
                          value: 'Man',
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: MetinButton(
                        // if the date is set will show it if not the string will be shown
                        text: state.birthday != DateTime(0000, 00, 00)
                            ? '${state.birthday.year}/${state.birthday.month}/${state.birthday.day}'
                            : 'Choose birthday Date',
                        isBorder: false,
                        icon: FontAwesomeIcons.calendar,
                        iconColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MetinBottomSheet(
                              content: MetinCalendar(
                                onSelect: (date) {
                                  profileBloc.add(
                                      ProfileBirthdayChanged(birthday: date));
                                },
                                initialDate:
                                    state.birthday != DateTime(0000, 00, 00)
                                        ? state.birthday
                                        : DateTime(
                                            today.year - 15,
                                            today.month,
                                            today.day,
                                          ),
                              ),
                            ),
                          );
                        },
                        color: const Color.fromARGB(40, 46, 142, 238),
                        textStyle: const TextStyle(
                          color: Color(0xff2E8EEE),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: aHeight(3, context),
                ),
                MetinButton(
                  text: 'Confirm',
                  isBorder: false,
                  onPressed: () {
                    if (firstName.text.isNotEmpty &&
                        lastName.text.isNotEmpty &&
                        profileBloc.state.birthday != DateTime(0000, 00, 00) &&
                        profileBloc.state.gender != "Not defined") {
                      profileBloc.add(ProfileFullNameChanged(
                          fullName: "${firstName.text} ${lastName.text}"));
                      authBloc.add(RegisterFullNameEvent(
                          onSuccess: () {
                            Navigator.pushNamed(
                                context, "/more-profile-details");
                          },
                          onError: (msg) {
                            showErrorMessage(context, msg);
                          },
                          fullName: {
                            "id": profileBloc.state.id,
                            "first_name": firstName.text,
                            "last_name": lastName.text
                          }));
                    } else {
                      showErrorMessage(context, "Please fill all fields");
                    }
                  },
                  color: const Color.fromARGB(255, 38, 131, 224),
                  textStyle: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ));
  }
}
