import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';

class AddLink extends StatefulWidget {
  const AddLink({Key? key}) : super(key: key);

  @override
  State<AddLink> createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  String link = '';
  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add a link",
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.link,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: aWidth(70, context),
                        child: MetinTextField(
                          onChanged: ((e) {
                            setState(() {
                              link = e;
                            });
                          }),
                          hintText: "Type your link",
                        ),
                      ),
                    ],
                  ),
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
                    profileBloc.add(ProfileLinkAdded(link: link));
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
