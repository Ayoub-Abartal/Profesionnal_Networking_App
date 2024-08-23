import 'package:flutter/material.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/features/global/presentation/screens/accessibilities/permissions_page.dart';

class LocationPermission extends PermissionsPage {
  const LocationPermission({Key? key})
      : super(
          key: key,
          permission: Permissions.location,
          permissionDescription:
              'Potential matches will be presented based on your location.',
          permissionTitle: 'Meet people nearby',
          permissionImage: 'assets/images/permissions/Location.png',
          nextPageNamedRoute: '/notifications-permission',
          //onPressed: (){}
        );
}
