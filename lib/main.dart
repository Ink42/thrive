import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thrive/challenge/location_controller.dart';
import 'package:thrive/challenge/view/challenge_view.dart';
import 'package:thrive/challenge/view/map_view.dart';
import 'package:thrive/challenge/view/set_event_view.dart';
import 'package:thrive/challenge/view_model/route_view_model.dart';
import 'package:thrive/const/constant.dart';
import 'package:thrive/global/models/activity_models.dart';
import 'package:thrive/global/models/user_profile_models.dart';
import 'package:thrive/global/services/network_monitor.dart';
import 'package:thrive/global/services/timer_provider.dart';
import 'package:thrive/global/widgets/bottom_navigation_provider.dart';
import 'package:thrive/global/services/pedometer_service.dart';
import 'package:thrive/utils/widgets/wtile.dart';
import 'package:thrive/home/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserProfileModelsAdapter());
  Hive.registerAdapter(ActivityModelsAdapter());
  await Hive.openBox<UserProfileModels>(test_user);
  await Hive.openBox<ActivityModels>(test_box);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
      ChangeNotifierProvider(create: (_) => NetworkMonitor()),
      ChangeNotifierProvider(create: (_) => RouteViewModel()),
      ChangeNotifierProvider(create: (_) => LocationController()),
      ChangeNotifierProvider(create: (_) => PedestrianProvider()),
      ChangeNotifierProvider(create: (_) => TimerProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HivePage(),
      routes: {
        MapView.id: (_) => MapView(),
        SetEventView.id: (_) => SetEventView()
      },
    );
  }
}

class HivePage extends StatefulWidget {
  HivePage({super.key});
  // final box = Hive.box<UserProfileModels>("name"); //Break
  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  String say = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    if (!Hive.isBoxOpen(test_user)) Hive.openBox<UserProfileModels>(test_user);
  }

  void display(String data) {
    setState(() {
      log(data);
      say = data;
    });
  }

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
        bottomNavigationBar: GNav(
            onTabChange: (value) {
              setState(() {
                currentPageIndex = value;
              });
            },
            activeColor: const Color.fromARGB(255, 113, 158, 28),
            color: Colors.grey,
            padding: EdgeInsets.all(10),
            tabMargin: EdgeInsets.all(10),
            tabs: [
              GButton(
                icon: Icons.home,
                text: "home",
                gap: 10,
              ),
              GButton(icon: Icons.map_rounded, text: "map", gap: 10),
              GButton(icon: Icons.search, text: "search", gap: 10),
              GButton(icon: Icons.settings, text: "settings", gap: 10),
            ]),
        // body: page[provider.currentIndex]
        body: page[currentPageIndex]
        // body:
        );
  }

  final page = [
    HomePage(),
    TimerScreen(),
    Center(child: ChallengeView()),
    MapView()
  ];
} // Import your TimerProvider

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Walking Timer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatTime(timerProvider.elapsedSeconds),
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: timerProvider.isRunning
                  ? timerProvider.stopTimer
                  : timerProvider.startTimer,
              child: Text(timerProvider.isRunning ? "Pause" : "Start"),
            ),
            ElevatedButton(
              onPressed: timerProvider.resetTimer,
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }
}

// //////
// class PedometerUI extends StatefulWidget {
//   @override
//   _PedometerUIState createState() => _PedometerUIState();
// }

// class _PedometerUIState extends State<PedometerUI> {
//   @override
//   void initState() {
//     super.initState();
//     // Initialize PedestrianProvider
//     Future.microtask(() =>
//         Provider.of<PedestrianProvider>(context, listen: false).initialize());
//   }

//   @override
//   Widget build(BuildContext context) {
//     TimerModel timerModel = TimerModel();
//     final provider = Provider.of<PedestrianProvider>(context);

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Steps Taken',
//             style: TextStyle(fontSize: 30),
//           ),
//           Text(
//             provider.steps,
//             style: TextStyle(fontSize: 60),
//           ),
//           Divider(
//             height: 100,
//             thickness: 0,
//             color: Colors.white,
//           ),
//           Text(
//             'Pedestrian Status',
//             style: TextStyle(fontSize: 30),
//           ),
//           Icon(
//             provider.status == 'walking'
//                 ? Icons.directions_walk
//                 : provider.status == 'stopped'
//                     ? Icons.accessibility_new
//                     : Icons.error,
//             size: 100,
//           ),
//           Center(
//             child: Text(
//               provider.status,
//               style:
//                   provider.status == 'walking' || provider.status == 'stopped'
//                       ? TextStyle(fontSize: 30)
//                       : TextStyle(fontSize: 20, color: Colors.red),
//             ),
//           ),
//           Row(
//             // spacing: 20,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   provider.register(true);
//                 },
//                 child: Text("Play"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   provider.register(false);
//                 },
//                 child: Text("Pause"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   provider.clearSteps();
//                 },
//                 child: Text("Clear"),
//               ),
//             ],
//           ),
//           // ///////////
//           Column(
//             // spacing: 20,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   timerModel.startTimer();
//                 },
//                 child: Text("Start Timer "),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   timerModel.playTimer();
//                 },
//                 child: Text("Continue Timer"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   timerModel.pauseTimer();
//                 },
//                 child: Text("Pause Timer"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   timerModel.cancelTimer();
//                 },
//                 child: Text("Clear Timer"),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
