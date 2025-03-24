import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'Buddyauthmodel/Buddyauthmodel.dart';

@immutable
sealed class BuddyAuthState {}

final class BuddyAuthInitial extends BuddyAuthState {}

class BuddyAuthloading extends BuddyAuthState {}

class BuddyAuthenticated extends BuddyAuthState {
  User? user;
  BuddyAuthenticated(this.user);
}

class BuddyUnAuthenticated extends BuddyAuthState {}

class BuddyAuthenticatedError extends BuddyAuthState {
  final String message;

  BuddyAuthenticatedError({required this.message});
}

// get all personal details

final class BuddyByidLoaded extends BuddyAuthState {
  final BuddyModel Userdata;
  BuddyByidLoaded(this.Userdata);
}

class Buddyloading extends BuddyAuthState {}

class Buddyerror extends BuddyAuthState {
  String error;
  Buddyerror({required this.error});
}

//Get all Buddy

final class BuddygetLoading extends BuddyAuthState {}

final class BuddyGetSuccess extends BuddyAuthState {}

final class Buddyfailerror extends BuddyAuthState {
  final String error;

  Buddyfailerror(this.error);
}

class Buddyloaded extends BuddyAuthState {
  final List<BuddyModel> Buddys;

  Buddyloaded(
    this.Buddys,
  );
}

// Acept reject

final class Acceptloading extends BuddyAuthState {}

final class Refresh extends BuddyAuthState {}
