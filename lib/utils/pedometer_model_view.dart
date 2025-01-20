// import 'package:flutter/material.dart';
// import 'package:pedometer/pedometer.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:thrive/utils/pedometer_service.dart';

// // import 'dart:async';
// // import 'package:pedometer/pedometer.dart';
// // import 'permission_handler.dart';

// // import 'package:flutter/material.dart';
// // import 'pedestrian_handler.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final PedestrianHandler _pedestrianHandler = PedestrianHandler();
//   String _status = '?';
//   String _steps = '?';

//   @override
//   void initState() {
//     super.initState();
//     _initializeHandlers();
//   }

//   Future<void> _initializeHandlers() async {
//     await _pedestrianHandler.initialize(
//       onStepCount: (event) {
//         setState(() {
//           _steps = event.steps.toString();
//         });
//       },
//       onPedestrianStatusChanged: (event) {
//         setState(() {
//           _status = event.status;
//         });
//       },
//       onStepCountError: (error) {
//         setState(() {
//           _steps = 'Step Count not available';
//         });
//       },
//       onPedestrianStatusError: (error) {
//         setState(() {
//           _status = 'Pedestrian Status not available';
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Pedometer Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Steps Tken',
//                 style: TextStyle(fontSize: 30),
//               ),
//               Text(
//                 _steps,
//                 style: TextStyle(fontSize: 60),
//               ),
//               Divider(
//                 height: 100,
//                 thickness: 0,
//                 color: Colors.white,
//               ),
//               Text(
//                 'Pedestrian Status',
//                 style: TextStyle(fontSize: 30),
//               ),
//               Icon(
//                 _status == 'walking'
//                     ? Icons.directions_walk
//                     : _status == 'stopped'
//                         ? Icons.accessibility_new
//                         : Icons.error,
//                 size: 100,
//               ),
//               Center(
//                 child: Text(
//                   _status,
//                   style: _status == 'walking' || _status == 'stopped'
//                       ? TextStyle(fontSize: 30)
//                       : TextStyle(fontSize: 20, color: Colors.red),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
