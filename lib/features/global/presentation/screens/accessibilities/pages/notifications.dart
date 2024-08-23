import 'package:flutter/material.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/features/global/presentation/screens/accessibilities/permissions_page.dart';

class NotificationsPermission extends PermissionsPage {
  const NotificationsPermission({Key? key})
      : super(
          key: key,
          permission: Permissions.notifications,
          permissionDescription:
              'Get push-notification when you get the match or receive a message',
          permissionTitle: 'Enable notifications',
          permissionImage: 'assets/images/permissions/Notifications.png',
          nextPageNamedRoute: '/login',
          //onPressed: (){}
        );
}
