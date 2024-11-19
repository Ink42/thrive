import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thrive/const/constant.dart';
import 'package:thrive/global/models/user_profile_models.dart';
import 'package:thrive/global/widgets/bottom_navigation_bar.dart';
import 'package:thrive/global/widgets/bottom_navigation_provider.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(UserProfileModelsAdapter());
    await Hive.openBox<UserProfileModels>(test_user);
  
  runApp(

      MultiProvider(providers: 
      [
        ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
      ],
      child: const MyApp(),
      )

  );
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
      home:HivePage(),
    );
  }
}


class HivePage extends StatefulWidget {
  HivePage({super.key});
  // final box = Hive.box<UserProfileModels>("name");
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

  void display(String data){
    setState(() {
       log(data);
       say = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavigationProvider>(context);
    final userBox = Hive.box<UserProfileModels>(test_user);
    UserProfileModels user = UserProfileModels(
      userEmail: "example@yahoo.co", 
      userID: "9kkds8ads)sa", 
      userName: "Toby", 
      userProfilePicture: "https://media.npr.org/assets/img/2017/08/29/stretch-and-bob-stevie-wonder_wide-fb64384afd53e5775957a41f6630367922f712c0.jpg"
      );
    
    return Scaffold(
      
      bottomNavigationBar:  GlobaleBottomNavigationBar(),
      body: page[provider.currentIndex]
    );
  }
 final page =[
  Center(child: Text("Home"),),
  Center(child: Text("Stats"),),
  Center(child: Text("Map"),),
  Center(child: Text("Settings"),),

  ];
}
