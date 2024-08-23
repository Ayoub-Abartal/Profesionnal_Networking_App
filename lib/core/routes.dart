import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/dependency_injection.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:metin/features/auth/presentation/screens/login/auth_verification_screen.dart';
import 'package:metin/features/auth/presentation/screens/login/emailLogin/email_login_screen.dart';
import 'package:metin/features/auth/presentation/screens/login/login_screen.dart';
import 'package:metin/features/auth/presentation/screens/login/new_login_screen.dart';
import 'package:metin/features/auth/presentation/screens/login/phoneLogin/phone_login_screen.dart';
import 'package:metin/features/auth/presentation/screens/onBoarding/onboarding_screen.dart';
import 'package:metin/features/global/presentation/screens/accessibilities/pages/contacts.dart';
import 'package:metin/features/global/presentation/screens/accessibilities/pages/location.dart';
import 'package:metin/features/global/presentation/screens/accessibilities/pages/notifications.dart';
import 'package:metin/features/swipe/presentation/bloc/swipe/swipe_bloc.dart';
import 'package:metin/features/swipe/presentation/screens/home_screen.dart';
import 'package:metin/features/swipe/presentation/screens/main_swipe.dart';
import 'package:metin/features/swipe/presentation/screens/match_screen.dart';
import 'package:metin/features/user/Details/presentation/screens/profile_details_1.screen.dart';
import 'package:metin/features/user/messages/presentation/bloc/broadcast/broadcast_bloc.dart';
import 'package:metin/features/user/messages/presentation/bloc/messaging/messaging_bloc.dart';
import 'package:metin/features/user/messages/presentation/screens/image_editor_sceen.dart';
import 'package:metin/features/user/messages/presentation/screens/messages_screen.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/screens/profileDetails/profile_details.dart';
import 'package:metin/features/user/profile%20details/presentation/screens/profileDetails/work_education_profile_details.dart';
import 'package:metin/features/user/profilePage/presentation/screens/profile_page.dart';

import '../features/user/messages/presentation/screens/add_broadcast_screen.dart';
import '../features/user/messages/presentation/screens/media_preview.dart';
import '../features/user/messages/presentation/widgets/media_picker.dart';

class AppRouter {
  // Added this to make pushNamed navigation easier with BLoC
  final _profileBloc = ProfileBloc();
  final _swipeBloc = SwipeBloc();
  final _authBloc = sl<AuthenticationBloc>();
  final _broadcastBloc = BroadcastBloc();
  final _messagingBloc = MessagingBloc();

  Route onGenerateRoute(RouteSettings routeSettings) {
    //print('this is route ${routeSettings.name}');

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case '/login':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _profileBloc),
              BlocProvider.value(value: _authBloc),
            ],
            child: const LoginScreen(),
          ),
        );
      case '/email-login':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _profileBloc),
              BlocProvider.value(value: _authBloc),
            ],
            child: const EmailLoginScreen(),
          ),
        );
      case '/phone-login':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _authBloc),
                    BlocProvider.value(value: _profileBloc),
                  ],
                  child: const PhoneLoginScreen(),
                ));
      case '/sign-in-verification':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _authBloc),
                    BlocProvider.value(value: _profileBloc),
                  ],
                  child: const SignInVerificationScreen(),
                ));
      case '/contacts-permission':
        return MaterialPageRoute(builder: (_) => const ContactsPermission());
      case '/notifications-permission':
        return MaterialPageRoute(
            builder: (_) => const NotificationsPermission());
      case '/location-permission':
        return MaterialPageRoute(builder: (_) => const LocationPermission());
      case '/main-swipe-screen':
        return MaterialPageRoute(builder: (_) => MainSwipeScreen());

      case '/profile-page':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileBloc,
            child: const ProfilePageScreen(),
          ),
        );

      case '/main-profile-details':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _profileBloc,
              ),
              BlocProvider.value(
                value: _authBloc,
              ),
            ],
            child: const MainProfileDetailScreen(),
          ),
        );
      case '/more-profile-details':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _profileBloc),
              BlocProvider.value(value: _authBloc),
            ],
            child: const MoreProfileDetailsScreen(),
          ),
        );
      case '/work-edu-page':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileBloc,
            child: const WorkEducationScreen(),
          ),
        );
      case '/home-screen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _swipeBloc),
              BlocProvider.value(value: _broadcastBloc),
              BlocProvider.value(value: _messagingBloc),
            ],
            child: const HomeScreen(),
          ),
        );
      case '/match-screen':
        return MaterialPageRoute(
          builder: (_) => const MatchingScreen(),
        );

      case '/media-picker':
        return MaterialPageRoute(builder: (_) => const MediaPicker());
      case "/add-broadcast-screen":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _broadcastBloc,
            child: const AddBroadcastScreen(),
          ),
        );
      case '/image-editor':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _broadcastBloc,
            child: const ImageEditor(),
          ),
        );
      case '/media-preview':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _broadcastBloc,
            child: const MediaPreview(),
          ),
        );
      case '/messages':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _broadcastBloc),
              BlocProvider.value(value: _messagingBloc),
            ],
            child: const MessagesScreen(),
          ),
        );
      case '/new':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _authBloc),
              BlocProvider.value(value: _profileBloc),
            ],
            child: const NewLoginScreen(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
      ),
    );
  }
}
