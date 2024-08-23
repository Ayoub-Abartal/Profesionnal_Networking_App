import 'package:flutter/material.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/features/global/presentation/screens/accessibilities/permissions_page.dart';

class ContactsPermission extends PermissionsPage {
  const ContactsPermission({Key? key})
      : super(
          key: key,
          permission: Permissions.contacts,
          //onPressed: () {},
          nextPageNamedRoute: "/location-permission",
          permissionTitle: "Search friends",
          permissionDescription:
              "You can find friends from your contacts list to connect easily",
          permissionImage: "assets/images/permissions/Contacts.png",
        );
}
