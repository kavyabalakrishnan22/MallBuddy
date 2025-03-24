import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Buddyauthmodel/Buddyauthmodel.dart';
import 'buddy_auth_event.dart';
import 'buddy_auth_state.dart';

class BuddyAuthBloc extends Bloc<BuddyAuthEvent, BuddyAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BuddyAuthBloc() : super(BuddyAuthInitial()) {
    // check Auth or Not
    on<checkBuddyloginstateevent>(
      (event, emit) async {
        User? user;
        try {
          await Future.delayed(Duration(seconds: 3));
          user = _auth.currentUser;
          if (user != null) {
            emit(BuddyAuthenticated(user));
          } else {
            emit(BuddyUnAuthenticated());
          }
        } catch (e) {
          emit(BuddyAuthenticatedError(
            message:
                e.toString().split('] ').last, // Extracts only the message part
          ));
        }
      },
    );
    // Signup
    on<BuddySignupEvent>(
      (event, emit) async {
        emit(BuddyAuthloading());
        try {
          final usercredential = await _auth.createUserWithEmailAndPassword(
              email: event.user.email.toString(),
              password: event.user.password.toString());

          final user = usercredential.user;

          if (user != null) {
            FirebaseFirestore.instance
                .collection("MallBuddyRiders")
                .doc(user.uid)
                .set({
              "userId": user.uid,
              "email": user.email,
              "Customername": event.user.name,
              "Dateodbirth": event.user.Dob,
              "Gender": event.user.Gender,
              "phone_number": event.user.phone,
              "timestamp": DateTime.now(),
              "Onesignal_id": "playerId",
              "ban": "1",
              "status": "1",
              "imagepath":
                  "https://cdn1.iconfinder.com/data/icons/proffesion/257/Driver-512.png"
            });
            emit(BuddyAuthenticated(user));
          } else {
            emit(BuddyUnAuthenticated());
          }
        } catch (e) {
          emit(BuddyAuthenticatedError(message: e.toString().split("]").last));
          print("Buddy Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );

    on<FetchBuddyDetailsById>((event, emit) async {
      emit(Buddyloading());
      User? user = _auth.currentUser;

      if (user != null) {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final doc = await FirebaseFirestore.instance
                .collection('MallBuddyRiders')
                .doc(user.uid)
                .get();

            if (doc.exists) {
              BuddyModel userData = BuddyModel.fromMap(doc.data()!);
              emit(BuddyByidLoaded(userData));
            } else {
              emit(Buddyerror(error: "User profile not found"));
            }
          } else {
            emit(Buddyerror(error: "User not authenticated"));
          }
        } catch (e) {
          emit(Buddyerror(error: e.toString()));
        }
      }
    });

    // accept

    on<BuddySigOutEvent>(
      (event, emit) async {
        try {
          User? user = _auth.currentUser;

          if (user != null) {
            // Get the Player ID from OneSignalService

            // Update Firestore with the correct user ID and OneSignal ID
            await FirebaseFirestore.instance
                .collection("MallBuddyRiders")
                .doc(user.uid) // Use current user's UID
                .update({"Onesignal_id": "null"}); // Update with OneSignal ID

            // Sign out the user
            await _auth.signOut();
            emit(BuddyUnAuthenticated());
          } else {
            emit(BuddyAuthenticatedError(message: "No user is logged in"));
          }
        } catch (e) {
          emit(BuddyAuthenticatedError(message: e.toString()));
        }
      },
    );

    on<AcceptRejectbuddyevent>(
      (event, emit) async {
        try {
          emit(Acceptloading());

          await FirebaseFirestore.instance
              .collection("MallBuddyRiders")
              .doc(event.id)
              .update({"status": event.status});
          emit(Refresh());
        } catch (e) {
          print(e);
        }
      },
    );

    on<BuddyLoginEvent>(
      (event, emit) async {
        emit(BuddyAuthloading());
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
                .collection("MallBuddyRiders")
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;

              // Check if the 'Ban' field is 1
              if (userData['ban'] == "1") {
                // Update OneSignal ID
                await FirebaseFirestore.instance
                    .collection("MallBuddyRiders")
                    .doc(user.uid)
                    .update({"Onesignal_id": "playerId"});

                emit(BuddyAuthenticated(user));
                print("Auth successfully");
              } else {
                await _auth.signOut();
                emit(BuddyAuthenticatedError(
                    message: "Your account has been deleted."));
              }
            } else {
              await _auth.signOut();
              emit(BuddyAuthenticatedError(message: "User data not found."));
            }
          } else {
            emit(BuddyUnAuthenticated());
          }
        } on FirebaseAuthException catch (e) {
          emit(BuddyAuthenticatedError(
              message: e.message ?? "An error occurred."));
          print("FirebaseAuthException: ${e.message}");
        } catch (e) {
          emit(BuddyAuthenticatedError(
              message: "An unexpected error occurred."));
          print("Login error: ${e.toString()}");
        }
      },
    );

    //   get all shopes

    on<FetchBuddyDetailsEvent>((event, emit) async {
      emit(BuddygetLoading());
      try {
        CollectionReference BuddyCollection =
            FirebaseFirestore.instance.collection('MallBuddyRiders');

        Query query = BuddyCollection;
        query = query.where("status", isEqualTo: event.status);

        QuerySnapshot snapshot = await query.get();

        List<BuddyModel> Buddys = snapshot.docs.map((doc) {
          return BuddyModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          Buddys = Buddys.where((driver) {
            return driver.name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Buddyloaded(Buddys));
      } catch (e) {
        emit(Buddyfailerror(e.toString()));
      }
    });
  }
}
