import 'package:dashboard/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/utils/textstyles.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String data_today;
  final String data_yesterday;
  final String comment;

  const CustomContainer({
    super.key,
    required this.title,
    required this.data_today,
    required this.data_yesterday,
    this.comment = ' ',
  });

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
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: AppTextStyles.custom_container_title,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text(
                      data_today,
                      style: AppTextStyles.custom_container_data,
                    ),
                    Divider(),
                    Text(
                      data_yesterday,
                      style: AppTextStyles.custom_container_data,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      comment,
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
