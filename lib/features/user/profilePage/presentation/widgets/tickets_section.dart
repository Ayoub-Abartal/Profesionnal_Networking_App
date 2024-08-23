import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/common/widgets/multi_select_dialog.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';
import 'package:metin/features/user/profilePage/presentation/widgets/tickets.dart';

import 'metin_plus_button.dart';

class TicketsSection extends StatelessWidget {
  const TicketsSection({
    Key? key,
    required this.isCurrentUser,
    required this.blocVariable,
    required this.bottomSheetTitle,
    required this.bottomSheetData,
    required this.previousSelects,
    required this.onSelect,
    required this.onDeselect,
  }) : super(key: key);

  /// Is it the current logged user
  final bool isCurrentUser;

  /// The entries of the section
  final List<String> blocVariable;

  /// The title of the bottom sheet
  final String bottomSheetTitle;

  /// The data of the bottom sheet
  final List<String> bottomSheetData;

  /// The previously selected options
  final List<String> previousSelects;

  /// What happens when the option is selected
  final void Function(String) onSelect;

  /// What happens when the option is deselected
  final void Function(String) onDeselect;

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    return Wrap(
      runSpacing: 2,
      spacing: 7,
      direction: Axis.horizontal,
      children: List.generate(
        isCurrentUser ? blocVariable.length + 1 : blocVariable.length,
        (index) {
          if (isCurrentUser && index == blocVariable.length) {
            return MetinPlusButton(
              isTicket: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MetinBottomSheet(
                    content: BlocProvider.value(
                      value: profileBloc,
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return MultiSelectDialog(
                            title: bottomSheetTitle,
                            data: bottomSheetData,
                            previousSelects: previousSelects,
                            onSelect: onSelect,
                            onDeselect: onDeselect,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Ticket(
            text: blocVariable[index],
          );
        },
      ),
    );
  }
}
