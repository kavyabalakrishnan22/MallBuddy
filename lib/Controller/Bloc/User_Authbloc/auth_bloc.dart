import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'Userauthmodel/Usermodel.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    // check Auth or Not
    on<checkloginstateevent>(
      (event, emit) async {
        User? user;
        try {
          await Future.delayed(Duration(seconds: 3));
          user = _auth.currentUser;
          if (user != null) {
            emit(Authenticated(user));
          } else {
            emit(UnAuthenticated());
          }
        } catch (e) {
          emit(AuthenticatedError(
            message:
                e.toString().split('] ').last, // Extracts only the message part
          ));
        }
      },
    );
    // Signup
    on<SignupEvent>(
      (event, emit) async {
        emit(Authloading());
        try {
          final usercredential = await _auth.createUserWithEmailAndPassword(
              email: event.user.email.toString(),
              password: event.user.password.toString());

          final user = usercredential.user;

          if (user != null) {
            FirebaseFirestore.instance
                .collection("MallBuddyUsers")
                .doc(user.uid)
                .set({
              "userId": user.uid,
              "email": user.email,
              "name": event.user.name,
              "phone_number": event.user.phone,
              "timestamp": DateTime.now(),
              "Onesignal_id": "playerId",
              "ban": "1",
              "status": "1",
              "imagepath":
                  "https://static.vecteezy.com/system/resources/thumbnails/000/439/863/small/Basic_Ui__28186_29.jpg"
            });
            emit(Authenticated(user));
          } else {
            emit(UnAuthenticated());
          }
        } catch (e) {
          emit(AuthenticatedError(message: e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );
    on<FetchUserDetailsById>((event, emit) async {
      emit(loading());
      User? user = _auth.currentUser;

      if (user != null) {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final doc = await FirebaseFirestore.instance
                .collection('MallBuddyUsers')
                .doc(user.uid)
                .get();

            if (doc.exists) {
              UserModel userData = UserModel.fromMap(doc.data()!);
              emit(UserByidLoaded(userData));
            } else {
              emit(Usererror(error: "User profile not found"));
            }
          } else {
            emit(Usererror(error: "User not authenticated"));
          }
        } catch (e) {
          emit(Usererror(error: e.toString()));
        }
      }
    });

    //  get all users
    on<FetchUsers>((event, emit) async {
      emit(UsersLoading());
      try {
        CollectionReference driversCollection =
            FirebaseFirestore.instance.collection('MallBuddyUsers');

        Query query = driversCollection;
        QuerySnapshot snapshot = await query.get();

        List<UserModel> userss = snapshot.docs.map((doc) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          userss = userss.where((driver) {
            return driver.name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Usersloaded(userss));
      } catch (e) {
        emit(Usersfailerror(e.toString()));
      }
    });

    on<SigOutEvent>(
      (event, emit) async {
        try {
          User? user = _auth.currentUser;

          if (user != null) {
            // Get the Player ID from OneSignalService

            // Update Firestore with the correct user ID and OneSignal ID
            await FirebaseFirestore.instance
                .collection("MallBuddyUsers")
                .doc(user.uid) // Use current user's UID
                .update({"Onesignal_id": "null"}); // Update with OneSignal ID

            // Sign out the user
            await _auth.signOut();
            emit(UnAuthenticated());
          } else {
            emit(AuthenticatedError(message: "No user is logged in"));
          }
        } catch (e) {
          emit(AuthenticatedError(message: e.toString()));
        }
      },
    );

    on<LoginEvent>(
      (event, emit) async {
        emit(Authloading());
        try {
          final userCredential = await _auth.signInWithEmailAndPassword(
            email: event.Email,
            password: event.Password,
          );
          final user = userCredential.user;

          if (user != null) {
            print("Id=======${user.uid}");

            // Fetch user document from Firestore
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection("MallBuddyUsers")
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;

              // Check if the 'Ban' field is 1
              if (userData['ban'] == "1") {
                // Update OneSignal ID
                await FirebaseFirestore.instance
                    .collection("MallBuddyUsers")
                    .doc(user.uid)
                    .update({"Onesignal_id": "playerId"});

                emit(Authenticated(user));
                print("Auth successfully");
              } else {
                await _auth.signOut();
                emit(AuthenticatedError(
                    message: "Your account has been deleted."));
              }
            } else {
              await _auth.signOut();
              emit(AuthenticatedError(message: "User data not found."));
            }
          } else {
            emit(UnAuthenticated());
          }
        } on FirebaseAuthException catch (e) {
          emit(AuthenticatedError(message: e.message ?? "An error occurred."));
          print("FirebaseAuthException: ${e.message}");
        } catch (e) {
          emit(AuthenticatedError(message: "An unexpected error occurred."));
          print("Login error: ${e.toString()}");
        }
      },
    );
  }
}
