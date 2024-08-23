import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_app_bar.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/common/widgets/metin_icon_button.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/swipe/presentation/bloc/filter/filter_bloc.dart';
import 'package:metin/features/swipe/presentation/bloc/swipe/swipe_bloc.dart';
import 'package:metin/features/swipe/presentation/widgets/filter_options.dart';
import 'package:metin/features/swipe/presentation/widgets/profile_card.dart';

class MainSwipeScreen extends StatelessWidget {
  MainSwipeScreen({Key? key}) : super(key: key);
  final _filterBloc = FilterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetinAppBar(
        leading: SizedBox(
          width: aWidth(16, context),
        ),
        title: Text(
          "Metin",
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: MetinIconButton(
            icon: FontAwesomeIcons.sliders,
            iconColor: Theme.of(context).primaryColor,
            horizontalPadding: 0,
            height: aHeight(7, context),
            onPressed: () {
              Navigator.push(
                context,
                MetinBottomSheet(
                  content: BlocProvider.value(
                    value: _filterBloc,
                    child: const FilterPage(),
                  ),
                ),
              );
              // oldMetinBottomSheet(
              //   context,
              //   BlocProvider.value(
              //     value: _filterBloc,
              //     child: const FilterPage(),
              //   ),
              // );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<SwipeBloc, SwipeState>(
            builder: (context, state) {
              return Stack(
                children: state.profiles.map(
                  (e) {
                    bool isFront = state.profiles.last == e;
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      bottom: isFront ? 0 : aHeight(3, context),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: isFront
                              ? aWidth(10, context)
                              : aWidth(15, context),
                          bottom: aHeight(100, context) >= 600
                              ? aHeight(4, context)
                              : aHeight(0.5, context),
                        ),
                        child: ProfileCard(
                          isFront: isFront,
                          profile: e,
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
