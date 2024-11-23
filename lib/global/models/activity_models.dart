import 'package:hive/hive.dart';
part 'activity_models.g.dart';


@HiveType(typeId: 1)
class ActivityModels {
ActivityModels(this.activityId, this.type, this.distance, this.duration, this.dateTime, this.route, this.title, this.summary, this.complete);

get getActivity =>activityId;
get getType =>type;
get getDistance =>distance;
get getDuration =>duration;
get getDate =>dateTime;
get getRoutes =>route;
get getTitle =>title;
get getComplete =>complete;
get getSummary =>summary;



@HiveField(0)
final String activityId;
@HiveField(1)
final String type;
@HiveField(2)
final double distance;
@HiveField(3)
final int duration;
@HiveField(4)
final DateTime dateTime;
@HiveField(5)
final List route;
@HiveField(6)
final String title;
@HiveField(7)
final bool complete;
@HiveField(8)
final String summary;
}