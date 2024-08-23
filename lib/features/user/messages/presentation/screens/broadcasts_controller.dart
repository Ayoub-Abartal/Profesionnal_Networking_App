import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/features/user/messages/presentation/bloc/broadcast/broadcast_bloc.dart';
import 'package:metin/features/user/messages/presentation/screens/broadcast_screen.dart';

/// The page that handles showing and scrolling between the broadcasts
class BroadcastController extends StatefulWidget {
  final int selectedBroadIndex;

  const BroadcastController({
    Key? key,
    required this.selectedBroadIndex,
  }) : super(key: key);

  @override
  State<BroadcastController> createState() => _BroadcastControllerState();
}

class _BroadcastControllerState extends State<BroadcastController> {
  /// The page controller to control a broadcast on a given screen
  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final broadcastBloc = context.read<BroadcastBloc>();
    _pageController = broadcastBloc.state.controller;
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: contacts.reversed
            .toList()
            .map((e) => BlocProvider.value(
                  value: broadcastBloc,
                  child: BroadcastScreen(profile: e),
                ))
            .toList(),
      ),
    );
  }
}
