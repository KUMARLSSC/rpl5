import 'package:flutter/material.dart';
import 'package:rpl5/common/app_colors.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.bgSideMenu,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "ASSESSOR",
                style: TextStyle(
                  color: AppColor.yellow,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerListTile(
              title: "Dashboard",
              icon: "images/menu_home.png",
              press: () {},
            ),
            DrawerListTile(
              title: "Onboarding",
              icon: "images/menu_onboarding.png",
              press: () {},
            ),
            DrawerListTile(
              title: "Reports",
              icon: "images/menu_report.png",
              press: () {},
            ),
            DrawerListTile(
              title: "Calendar",
              icon: "images/menu_calendar.png",
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              icon: "images/menu_settings.png",
              press: () {},
            ),
            Spacer(),
            Image.asset("images/sidebar_image.png")
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String? title, icon;
  final VoidCallback? press;

  const DrawerListTile({Key? key, this.title, this.icon, this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        icon!,
        color: AppColor.white,
        height: 16,
      ),
      title: Text(
        title!,
        style: TextStyle(color: AppColor.white),
      ),
    );
  }
}
