
import 'package:hive/hive.dart';

part 'user_profile_models.g.dart';
@HiveType(typeId: 0)
class UserProfileModels {
UserProfileModels({
  required this.userEmail, 
  required this.userID,
  required this.userName,
  required this.userProfilePicture
  });
String get id => userID;

String get name => userName;

String get email => userEmail;
String get profilePicture => userProfilePicture;



@HiveField(0)
final String userID;
@HiveField(1)
final String userName;
@HiveField(2)
final String userEmail;
@HiveField(3)
final String userProfilePicture;



}