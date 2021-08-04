import 'package:flutter/material.dart';
import 'package:rpl5/common/app_colors.dart';

class NotificationCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.yellow, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 16, color: AppColor.black),
                  children: [
                    TextSpan(text: "Good Morning "),
                    TextSpan(
                      text: "Assessor Name!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Today you have Assessment.\nTiming 10 AM to 1 PM Date - 02/08/2021.\nHOUSE, 1st floor, GCV, 81, Nungambakkam High Rd, \nNungambakkam, Chennai, Tamil Nadu 600034",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Read More",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              )
            ],
          ),
          if (MediaQuery.of(context).size.width >= 620) ...{
            Spacer(),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/scaleindia.appspot.com/o/notification_image.png?alt=media&token=92bfd429-8312-486a-8934-95c4b1d83209",
              height: 160,
            )
          }
        ],
      ),
    );
  }
}
