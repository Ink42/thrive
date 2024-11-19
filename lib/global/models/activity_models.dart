import 'package:hive/hive.dart';
part 'activity_models.g.dart';


@HiveType(typeId: 1)
class ActivityModels {
ActivityModels(this.activityId, this.type, this.distance, this.duration, this.dateTime, this.route);

get getActivity =>activityId;
get getType =>type;
get getDistance =>distance;
get getDuration =>duration;
get getDate =>dateTime;
get getRoutes =>route;



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
}