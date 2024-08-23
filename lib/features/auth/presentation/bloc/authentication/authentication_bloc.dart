import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/use_case/use_case.dart';
import 'package:metin/features/auth/data/models/profile_model.dart';
import 'package:metin/features/auth/data/models/user_model.dart';
import 'package:metin/features/auth/domain/use_cases/get_user_profile.dart';
import 'package:metin/features/auth/domain/use_cases/login_email.dart';
import 'package:metin/features/auth/domain/use_cases/login_facebook.dart';
import 'package:metin/features/auth/domain/use_cases/login_google.dart';
import 'package:metin/features/auth/domain/use_cases/login_linked_in.dart';
import 'package:metin/features/auth/domain/use_cases/register_email.dart';
import 'package:metin/features/auth/domain/use_cases/register_full_name.dart';
import 'package:metin/features/auth/domain/use_cases/register_phone.dart';
import 'package:metin/features/auth/domain/use_cases/register_profile.dart';
import 'package:metin/features/auth/domain/use_cases/update_profile.dart';
import 'package:metin/features/auth/domain/use_cases/verify_existence_email.dart';
import 'package:metin/features/auth/domain/use_cases/verify_sign_in.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

const String serverFailureMessage = 'Server failure';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // ----------- use cases -------------
  final EmailLogin emailLogin;
  final GoogleLogin googleLogin;
  final FacebookLogin facebookLogin;
  final LinkedInLogin linkedInLogin;
  final RegisterEmail registerEmail;
  final VerifySignIn verifySignIn;
  final RegisterPhone registerPhone;
  final VerifyUserExistenceEmail verifyUserExistenceEmail;
  final RegisterFullName registerFullName;
  final RegisterProfile registerProfile;
  final GetUserProfile getUserProfile;
  final UpdateProfile updateUserProfile;
  // ------------------------------------

  AuthenticationBloc({
    required this.emailLogin,
    required this.googleLogin,
    required this.facebookLogin,
    required this.linkedInLogin,
    required this.registerEmail,
    required this.verifySignIn,
    required this.registerPhone,
    required this.verifyUserExistenceEmail,
    required this.registerFullName,
    required this.registerProfile,
    required this.getUserProfile,
    required this.updateUserProfile,
  }) : super(
          const AuthenticationStateInitial(),
        ) {
    on<EmailRegistrationEvent>((event, emit) async {
      emit(const AuthenticationLoading(loginType: LoginType.email));

      final failureORUser = await registerEmail(event.user);

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (user) {
            event.onSuccess();
            return const AuthenticationVerification(loginType: LoginType.email);
          },
        ),
      );
    });

    on<PhoneRegistrationEvent>((event, emit) async {
      emit(const AuthenticationLoading(loginType: LoginType.phone));

      final failureORUser = await registerPhone(event.user);

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (res) {
            event.onSuccess(res);
            return const AuthenticationVerification(loginType: LoginType.phone);
          },
        ),
      );
    });

    on<EmailExistenceCheckEvent>((event, emit) async {
      emit(const AuthenticationLoading(loginType: LoginType.email));

      final failureORUser = await verifyUserExistenceEmail(event.email);

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (response) {
            event.onSuccess(response);
            return const AuthenticationVerification(loginType: LoginType.email);
          },
        ),
      );
    });

    on<SignInVerificationEvent>((event, emit) async {
      emit(AuthenticationLoading(loginType: event.loginType));

      final failureORUser = await verifySignIn(event.user);

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationVerification(loginType: event.loginType);
          },
          (user) {
            event.onSuccess(user);
            return const AuthenticationEnded();
          },
        ),
      );
    });

    on<EmailLoginEvent>((event, emit) async {
      emit(const AuthenticationLoading(loginType: LoginType.email));

      final failureORUser = await emailLogin(event.user);

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (user) {
            event.onSuccess();
            return const AuthenticationEnded();
          },
        ),
      );
    });

    on<GoogleLoginEvent>((event, emit) async {
      emit(const AuthenticationLoading(loginType: LoginType.google));

      final failureORUser = await googleLogin(const NoParams());

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (user) {
            event.onSuccess(user);
            return const AuthenticationEnded();
          },
        ),
      );
    });

    on<FacebookLoginEvent>((event, emit) async {
      emit(const AuthenticationLoading(loginType: LoginType.facebook));

      final failureORUser = await facebookLogin(const NoParams());

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (user) {
            event.onSuccess(user);
            return const AuthenticationEnded();
          },
        ),
      );
    });

    on<LinkedInLoginEvent>((event, emit) async {
      emit(const AuthenticationLoading(loginType: LoginType.linkedIn));

      final failureORUser = await linkedInLogin(event.token);

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (user) {
            event.onSuccess(user);
            return const AuthenticationEnded();
          },
        ),
      );
    });

    on<RegisterFullNameEvent>((event, emit) async {
      final failureORUser = await registerFullName(event.fullName);

      emit(
        failureORUser.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (user) {
            event.onSuccess();
            return const AuthenticationEnded();
          },
        ),
      );
    });

    on<RegisterProfileEvent>((event, emit) async {
      final failureORProfile = await registerProfile(const NoParams());

      emit(
        failureORProfile.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (profile) {
            event.onSuccess();
            return const AuthenticationEnded();
          },
        ),
      );

      // This code below is a solution to getting the user's location based on gps

      // bool serviceEnabled;
      // LocationPermission permission;
      // // --------------- Getting user's location permission -----------------
      // serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      //   return Future.error('Location services are disabled.');
      // }
      //
      // permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      //   if (permission == LocationPermission.denied) {
      //     return Future.error('Location permissions are denied');
      //   }
      // }
      //
      // if (permission == LocationPermission.deniedForever) {
      //   // Permissions are denied forever, handle appropriately.
      //   return Future.error(
      //       'Location permissions are permanently denied, we cannot request permissions.');
      // }
      // // --------------------------------------------------------------
      // print("all good");
      //
      // await Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.best)
      //     .then((position) async {
      //   try {
      //     await GeocodingPlatform.instance
      //         .placemarkFromCoordinates(
      //       position.latitude,
      //       position.longitude,
      //     )
      //         .then((address) async {
      //       print(address.first.locality);
      //       Map data = {
      //         "birthday": event.profile["birthday"],
      //         "bio": event.profile['bio'],
      //         "location": address.first.locality,
      //         "years_of_experience": 1
      //       };
      //       print(data);
      //       String body = json.encode(data);
      //       final response = await http.post(
      //           Uri.parse("http://10.0.2.2:8989/profile/"),
      //           body: body,
      //           headers: {
      //             "Content-Type": "application/json",
      //             "accept": "application/json",
      //           });
      //       print(response.statusCode);
      //       var decodedResponse =
      //           jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      //       if (response.statusCode == 200) {
      //         event.onSuccess();
      //         print(decodedResponse);
      //       } else if (response.statusCode == 403) {
      //         event.onError(decodedResponse["detail"]);
      //         print(decodedResponse);
      //       }
      //     });
      //   } catch (err) {
      //     print(err);
      //   }
      // });
    });

    on<UpdateProfileEvent>((event, emit) async {
      final failureORProfile = await updateUserProfile(event.profile);

      emit(
        failureORProfile.fold(
          (failure) {
            event.onError(failure.msg);
            return AuthenticationError(message: failure.msg);
          },
          (user) {
            event.onSuccess();
            return const AuthenticationEnded();
          },
        ),
      );
    });

    on<GetUserProfileEvent>((event, emit) async {
      final failureORProfile = await getUserProfile(const NoParams());

      emit(
        failureORProfile.fold(
          (failure) {
            event.onNotFound(failure.msg);
            return const CreatingUserProfile();
          },
          (profile) {
            event.onSuccess(profile);
            return const AuthenticationEnded();
          },
        ),
      );
    });
  }
}
