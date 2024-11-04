import 'package:flutter/material.dart';
import 'package:dashboard/utils/appcolor.dart';
import 'package:dashboard/utils/textstyles.dart';

class CustomContainer2 extends StatefulWidget {
  final String title;
  final String data_today;
  final String data_yesterday;
  final String comment;
  const CustomContainer2(
      {super.key,
      required this.title,
      required this.data_today,
      required this.data_yesterday,
      this.comment = ''});

  @override
  State<CustomContainer2> createState() => _CustomContainer2State();
}

class _CustomContainer2State extends State<CustomContainer2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.title,
                      style: AppTextStyles.custom_container_title,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('data'),
                      Text('data'),
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.data_today,
                          style: AppTextStyles.custom_container_data,
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      widget.data_yesterday,
                      style: AppTextStyles.custom_container_data,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.comment,
                      style: AppTextStyles.custom_container_comment,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
