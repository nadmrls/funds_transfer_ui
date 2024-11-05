import 'package:dashboard/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/utils/textstyles.dart';
import 'package:intl/intl.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String data_today;
  final String data_yesterday;
  final String comment;
  final String todaylabel;
  final String yesterdaylabel;

  const CustomContainer({
    super.key,
    required this.title,
    required this.data_today,
    required this.data_yesterday,
    this.comment = '',
    required this.todaylabel,
    required this.yesterdaylabel,
  });


  @override
  Widget build(BuildContext context) {
    final double todayValue = double.tryParse(data_today) ?? 0;
    final double yesterdayValue = double.tryParse(data_yesterday) ?? 0;
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (todayValue > yesterdayValue)
                              const Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                                size: 50,
                              )
                            else if (todayValue < yesterdayValue)
                              const Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                                size: 50,
                              )
                            else
                              const Icon(
                                Icons.horizontal_rule,
                                color: Colors.grey,
                                size: 50,
                              ),
                            Text(
                              data_today,
                              style: AppTextStyles.custom_container_data,
                            ),
                            SizedBox(width: 2,)
                          ],
                        ),Text(
                            todaylabel
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.blueGrey,
                    ),
                    Text(yesterdaylabel),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (yesterdayValue > todayValue)
                          const Icon(
                             Icons.arrow_upward,
                            color: Colors.green,
                            size: 50,
                          )
                        else if (yesterdayValue < todayValue)
                          const Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                            size: 50,
                          )
                        else
                          const Icon(
                            Icons.horizontal_rule,
                            color: Colors.grey,
                            size: 50,
                          ),
                        Text(
                          data_yesterday,
                          style: AppTextStyles.custom_container_data,
                        ),
                        SizedBox(width: 2,)
                      ],
                    ),
                    const SizedBox(
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
