import 'package:flutter/material.dart';

import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogoutTap;

  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
      ),
      backgroundColor: Colors.grey[900],
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(color: Colors.transparent),
              ),
              child: const DrawerHeader(
                child: Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
            MyListTile(
              text: "H O M E",
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            MyListTile(
              text: "P R O F I L E",
              icon: Icons.account_circle,
              onTap: onProfileTap,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: MyListTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: onLogoutTap,
          ),
        ),
      ]),
    );
  }
}
