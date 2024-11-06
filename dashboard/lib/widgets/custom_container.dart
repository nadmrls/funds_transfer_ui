import 'package:flutter/material.dart';
import 'package:dashboard/utils/textstyles.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String data_today;
  final String data_yesterday;
  final String comment;
  final bool test;
  final Color background;
  final Icon titleIcon;
  final String yesterdayLabel;
  final String todayLabel;

  const CustomContainer({
    super.key,
    required this.title,
    required this.data_today,
    required this.data_yesterday,
    this.comment = '',
    required this.test,
    required this.background,
    required this.titleIcon,
    required this.yesterdayLabel,
    required this.todayLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          decoration: BoxDecoration(
            color: background,
          ),
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.custom_container_title,
                ),
                titleIcon,
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Column(
                children: [
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
                                Text(
                                  todayLabel,
                                  style: AppTextStyles.custom_container_date,
                                ),
                              ],
                            ),
                            const Divider(
                              indent: 50,
                            ),
                            Column(
                              children: [
                                Text(
                                  yesterdayLabel,
                                  style: AppTextStyles.custom_container_date,
                                ),
                                Text(
                                  data_yesterday,
                                  style: AppTextStyles.custom_container_data,
                                ),
                              ],
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
                            size: 40,
                            color: test
                                ? const Color.fromARGB(255, 26, 141, 20)
                                : const Color.fromARGB(255, 243, 33, 33)),
                      )
                    ]),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
