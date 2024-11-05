// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class Container1 extends StatelessWidget {
//   final double yesterdayOutput = 1000000000.0;
//   final double todayOutput = 20.0;
//   final DateTime today = DateTime.now();
//   final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
//
//   Container1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final DateFormat dateFormat = DateFormat("MMM. d, yyyy");
//     final String todayLabel = dateFormat.format(today);
//     final String yesterdayLabel = dateFormat.format(yesterday);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             bool isWideScreen = constraints.maxWidth >= 400;
//             double containerWidth = isWideScreen ? constraints.maxWidth * 1.2 : constraints.maxWidth * 1.3;
//             double containerHeight = isWideScreen ? 90.0 : 180.0;
//
//             return Container(
//               width: containerWidth,
//               height: containerHeight,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.0),
//                 border: Border.all(
//                   color: Colors.grey.shade400,
//                   width: 2,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(0),
//                 child: isWideScreen ? Column(
//                   children: [
//                     const Text(
//                       "Container  1",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         fontStyle: FontStyle.normal,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         DataContainer(
//                           label: yesterdayLabel,
//                           icon: yesterdayOutput > todayOutput
//                               ? Icons.arrow_upward
//                               : Icons.arrow_downward,
//                           iconColor: yesterdayOutput > todayOutput
//                               ? Colors.green
//                               : Colors.red,
//                           value: yesterdayOutput,
//                         ),
//                         const SizedBox(width: 5),
//                         DataContainer(
//                           label: todayLabel,
//                           value: todayOutput,
//                           icon: todayOutput > yesterdayOutput
//                               ? Icons.arrow_upward
//                               : Icons.arrow_downward,
//                           iconColor: todayOutput > yesterdayOutput
//                               ? Colors.green
//                               : Colors.red,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ) : Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const Text(
//                       "Container  1",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         fontStyle: FontStyle.normal,
//                       ),
//                     ),
//                     DataContainer(
//                       label: yesterdayLabel,
//                       icon: yesterdayOutput > todayOutput
//                           ? Icons.arrow_upward
//                           : Icons.arrow_downward,
//                       iconColor: yesterdayOutput > todayOutput
//                           ? Colors.green
//                           : Colors.red,
//                       value: yesterdayOutput,
//                     ),
//                     const SizedBox(height: 5),
//                     DataContainer(
//                       label: todayLabel,
//                       value: todayOutput,
//                       icon: todayOutput > yesterdayOutput
//                           ? Icons.arrow_upward
//                           : Icons.arrow_downward,
//                       iconColor: todayOutput > yesterdayOutput
//                           ? Colors.green
//                           : Colors.red,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class DataContainer extends StatelessWidget {
//   final String label;
//   final double value;
//   final IconData icon;
//   final Color iconColor;
//
//   const DataContainer({
//     Key? key,
//     required this.label,
//     required this.value,
//     required this.icon,
//     required this.iconColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color: iconColor,
//               size: 50,
//             ),
//             const SizedBox(width: 10.0),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                       fontStyle: FontStyle.normal,
//                       fontSize: 18,
//                       fontWeight:
//                       FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8.0),
//                 Text(
//                   value.toStringAsFixed(1),
//                   style: const TextStyle(
//                       fontStyle: FontStyle.normal,
//                       fontSize: 17,
//                       fontWeight:
//                       FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }