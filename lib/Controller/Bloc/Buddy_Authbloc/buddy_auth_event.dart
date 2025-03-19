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


// get all user


