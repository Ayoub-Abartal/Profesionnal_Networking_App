import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';

class GenderRadioButton extends StatelessWidget {
  /// The value of the button that will be selected
  final String value;

  const GenderRadioButton({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        bool isSelected = state.gender == value;
        return Container(
          height: aHeight(7, context),
          width: aWidth(37, context),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            border: Border.all(
                width: 2.0,
                color:
                    isSelected ? Colors.blueAccent : const Color(0xffF3F2EF)),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Center(
            child: Text(value,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 14.0)),
          ),
        );
      },
    );
  }
}
