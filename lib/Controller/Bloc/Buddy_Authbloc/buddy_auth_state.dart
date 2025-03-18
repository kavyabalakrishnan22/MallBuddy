

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


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
