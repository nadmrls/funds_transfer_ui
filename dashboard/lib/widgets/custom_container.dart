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

  const CustomContainer({
    super.key,
    required this.title,
    required this.data_today,
    required this.data_yesterday,
    this.comment = '',
    required this.test,
    required this.background,
    required this.titleIcon,
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
                        top: 15,
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
        ),
      ],
    );
  }
}
