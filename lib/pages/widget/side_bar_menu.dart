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
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/scaleindia.appspot.com/o/menu_home.png?alt=media&token=aa8bf3f7-2902-4b52-b906-45a71abc732f",
              press: () {},
            ),
            DrawerListTile(
              title: "Onboarding",
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/scaleindia.appspot.com/o/menu_onboarding.png?alt=media&token=57f481d1-1b47-4ef8-b88f-6d5ec0901e1c",
              press: () {},
            ),
            DrawerListTile(
              title: "Reports",
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/scaleindia.appspot.com/o/menu_report.png?alt=media&token=c6822da3-48e5-4588-b671-f0a81fb007f0",
              press: () {},
            ),
            DrawerListTile(
              title: "Calendar",
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/scaleindia.appspot.com/o/menu_calendar.png?alt=media&token=b03c688a-553d-4a9e-b815-5c3fff2d7f94",
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/scaleindia.appspot.com/o/menu_settings.png?alt=media&token=1ab7b550-46a8-4a24-bbd6-cc9ceceebdc4",
              press: () {},
            ),
            Spacer(),
            Image.network(
                "https://firebasestorage.googleapis.com/v0/b/scaleindia.appspot.com/o/sidebar_image.png?alt=media&token=7664be44-f6a4-4cad-8427-17f35b309410")
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
      leading: Image.network(
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
