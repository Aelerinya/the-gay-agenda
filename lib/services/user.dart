import 'package:hive_flutter/adapters.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String imagePath;

  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.imagePath});

  String getName() => firstName + ' ' + lastName;
}
