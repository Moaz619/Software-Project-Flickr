import 'package:android_flickr/providers/flickr_posts.dart';
import 'package:flutter_test/flutter_test.dart';

///Testing the function that tells since when was theimage posted by subtracting the post date from current date.
void main() {
  final posts = Posts();
  DateTime imageTime;
  group(("Posted since, "), () {
    test("More than 1 day", () {
      //Arrange
      imageTime = DateTime.now().subtract(Duration(days: 3));

      String matcher = posts.postedSinceFinder(imageTime);
      //print(matcher);
      //Act
      String actual = "3d";
      //Assert
      expect(actual, matcher);
    });
    test("More than 1 hr", () {
      //Arrange
      imageTime = DateTime.now().subtract(Duration(hours: 5));
      String matcher = posts.postedSinceFinder(imageTime);
      //Act
      String actual = "5h";
      //Assert
      expect(actual, matcher);
    });
    test("More than 1 min", () {
      //postInformation.favesDetails.favesTotalNumber = 1;
      //Arrange
      imageTime = DateTime.now().subtract(Duration(minutes: 10));
      String matcher = posts.postedSinceFinder(imageTime);
      //Act
      String actual = "10m";
      //Assert
      expect(actual, matcher);
    });
    test("More than 1 sec", () {
      //postInformation.favesDetails.favesTotalNumber = 1;
      //Arrange
      imageTime = DateTime.now().subtract(Duration(seconds: 53));
      String matcher = posts.postedSinceFinder(imageTime);
      //Act
      String actual = "53s";
      //Assert
      expect(actual, matcher);
    });
  });
}
