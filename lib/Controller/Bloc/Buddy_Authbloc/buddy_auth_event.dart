import 'package:flutter/cupertino.dart';

import 'Buddyauthmodel/Buddyauthmodel.dart';

@immutable
sealed class BuddyAuthEvent {}

class checkBuddyloginstateevent extends BuddyAuthEvent {}

// login

class BuddyLoginEvent extends BuddyAuthEvent {
  final String Email;
  final String Password;

  BuddyLoginEvent({required this.Email, required this.Password});
}

// Signup
class BuddySignupEvent extends BuddyAuthEvent {
  final BuddyModel user;
  BuddySignupEvent({required this.user});
}

//signout

class BuddySigOutEvent extends BuddyAuthEvent {}

//get all personal details

class FetchBuddyDetailsById extends BuddyAuthEvent {}

//fetch all shop

class FetchBuddyDetailsEvent extends BuddyAuthEvent {
  final String? searchQuery;
  final String? status;
  final String? floor;
  final String? ban;
  FetchBuddyDetailsEvent(
      {required this.searchQuery, required this.status, this.floor,this.ban});
}


class AcceptRejectbuddyevent extends BuddyAuthEvent{
  final String? id;
  final String? status;
  AcceptRejectbuddyevent({required this.id, required this.status});

}

class BanBuddyrevent extends BuddyAuthEvent{
  final String? id;
  final String? Ban;
  BanBuddyrevent(
      {required this.id, required this.Ban});

}
class EditBuddy extends BuddyAuthEvent {
  final BuddyModel Buddy;
  EditBuddy({required this.Buddy});
}

class EditBuddyProfile extends BuddyAuthEvent {
  final BuddyModel Buddy;
  EditBuddyProfile({required this.Buddy});
}

class BuddyPickAndUploadImageEvent extends BuddyAuthEvent {}
