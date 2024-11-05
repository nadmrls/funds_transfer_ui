import 'package:dashboard/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/utils/textstyles.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String data_today;
  final String data_yesterday;
  final String comment;
  final bool test;

  const CustomContainer({
    super.key,
    required this.title,
    required this.data_today,
    required this.data_yesterday,
    this.comment = '',
    required this.test,
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
              Container(
                child: Stack(children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              data_today,
                              style: AppTextStyles.custom_container_data,
                            ),
                          ],
                        ),
                        Divider(
                          indent: 50,
                        ),
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
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 30,
                    child: Icon(
                        test
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 50,
                        color: test
                            ? Color.fromARGB(255, 26, 141, 20)
                            : Color.fromARGB(255, 243, 33, 33)),
                  )
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
