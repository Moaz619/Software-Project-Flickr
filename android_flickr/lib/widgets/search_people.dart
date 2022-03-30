import 'package:android_flickr/widgets/search_people_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flickr_posts.dart';
import '../providers/flickr_post.dart';
import '../screens/non_profile_screen.dart';
import '../providers/flickr_profiles.dart';

/// Contains list of the people profiles that came from the search result.
class SearchPeople extends StatefulWidget {
  final peopleSearchResult;
  SearchPeople(this.peopleSearchResult);
  @override
  SearchPeopleState createState() => SearchPeopleState();
}

class SearchPeopleState extends State<SearchPeople> {
  /// When circle avatar or name is pressed then the app navigates to this user and sends its details(post information) and other posts
  /// and profiles to choose the posts and images needed and display them.
  void _goToNonprofile(BuildContext ctx, PicPosterDetails userDetails,
      List<PostDetails> currentPosts, FlickrProfiles flickrProfiles) {
    final flickrProfileDetails =
        flickrProfiles.addProfileDetailsToList(userDetails, currentPosts);
    /* final flickrProfileDetails = FlickrProfiles().profiles.where(
        (profile) => profile.profileID == postInformation.picPoster.profileId); */
    // print(flickrProfileDetails.profileID);
    final profileFirstPostFound = currentPosts.firstWhere(
      (post) => post.picPoster.profileId == userDetails.profileId,
      orElse: () {
        return PostDetails(
          picPoster: userDetails,
          id: "-1",
          dateTaken: DateTime.now(),
          privacy: false,
          description: "",
          tags: [],
          commentsTotalNumber: 20,
          postImageUrl: "postImageUrl",
          postedSince: "6w",
          favesDetails: FavedPostDetails(favedUsersNames: [], isFaved: false),
        );
      },
    );
    Navigator.of(ctx).pushNamed(
      NonProfileScreen.routeName,
      arguments: [profileFirstPostFound, flickrProfileDetails],
    );
  }

  ///When the follow button is pressed this function updates the data so any widgets that needs to know can notice the changes
  void toggleFollowPicPoster(
      PicPosterDetails personDetails, List<PostDetails> currentPosts) {
    //print("first");
    //print(personDetails.isFollowedByUser);
    //print
    final profileFirstPostFound = currentPosts.firstWhere(
        (post) => post.picPoster.profileId == personDetails.profileId);
    profileFirstPostFound.toggleFollowPicPoster(
        currentPosts, profileFirstPostFound.picPoster);
    personDetails.notify();
    //print("second");
    //print(personDetails.isFollowedByUser);
    setState(() {
      personDetails.isFollowedByUser = !personDetails.isFollowedByUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Contains the list of the photos that came from the search result if any.
    final peopleSearchDetails =
        widget.peopleSearchResult as List<PicPosterDetails>;
    //final flickrProfiles = Provider.of<FlickrProfiles>(context);
    //final currentPosts = Provider.of<Posts>(context).posts;
    //final listener = Provider.of<PicPosterDetails>(context);
    return ListView.builder(
      itemCount: peopleSearchDetails.length,
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: peopleSearchDetails[index],
          child: SearchPeopleListTile(),
        );
      },
    );
  }
}
