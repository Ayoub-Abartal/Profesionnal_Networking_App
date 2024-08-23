import 'package:flutter/material.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_skip_button.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage(
      {Key? key,
      required this.permissionImage,
      required this.permissionTitle,
      required this.permissionDescription,
      required this.nextPageNamedRoute,
      //required this.onPressed,
      required this.permission})
      : super(key: key);

  /// The Image that will appear on the top of the screen
  final String permissionImage;

  /// The next page that the page will lead into
  final String nextPageNamedRoute;

  /// The name of the permission
  final String permissionTitle;

  /// The description of the permission
  final String permissionDescription;

  //final VoidCallback onPressed;

  /// The type of the permission
  final Permissions permission;

  Future<void> getPermission() async {
    switch (permission) {
      case Permissions.contacts:
        if (!(await Permission.contacts.request().isGranted)) {
          return;
        }
        break;
      case Permissions.notifications:
        if (!(await Permission.notification.request().isGranted)) {
          return;
        }
        break;
      case Permissions.location:
        if (!(await Permission.location.request().isGranted)) {
          return;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 1,
                right: 1,
                child: MetinSkipButton(
                  onPressed: () {
                    Navigator.pushNamed(context, nextPageNamedRoute);
                  },
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: aHeight(12, context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image(
                    image: AssetImage(permissionImage),
                  ),
                  Text(
                    permissionTitle,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      permissionDescription,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MetinButton(
                    color: Theme.of(context).primaryColor,
                    text: "Give permission",
                    textStyle: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                    isBorder: false,
                    onPressed: () {
                      getPermission();
                      Navigator.pushNamed(context, nextPageNamedRoute);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
