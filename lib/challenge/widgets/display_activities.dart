



import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thrive/const/constant.dart';
import 'package:thrive/global/models/activity_models.dart';

class displayActivities extends StatelessWidget {
  const displayActivities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final box  = Hive.box<ActivityModels>(test_box);
    log("Hive db has ${box.length}");
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: box.length, 
        itemBuilder: (_, index) {
          return  Center(

            child:
            box.get(index)==null? 
            Text("There seems to be no activity."):
            ListTile(
              leading: Icon(Icons.directions_bike_rounded),
              title:Text( box.get(index)!.title ),
              subtitle: Text( box.get(index)!.summary ) ,
              trailing: Icon(Icons.check_box_outline_blank),
              
            )
          );
        },
      ),
    );
  }
}
