import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mall_bud/Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import 'package:mall_bud/Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';

import 'Shopauthmodel/Shopauthmodel.dart';

class ShopAuthBloc extends Bloc<ShopAuthEvent, ShopAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ShopAuthBloc() : super(ShopAuthInitial()) {
    // check Auth or Not
    on<checkShoploginstateevent>(
      (event, emit) async {
        User? user;
        try {
          await Future.delayed(Duration(seconds: 3));
          user = _auth.currentUser;
          if (user != null) {
            emit(ShopAuthenticated(user));
          } else {
            emit(ShopUnAuthenticated());
          }
        } catch (e) {
          emit(ShopAuthenticatedError(
            message:
                e.toString().split('] ').last, // Extracts only the message part
          ));
        }
      },
    );
    // Signup
    on<ShopSignupEvent>(
      (event, emit) async {
        emit(ShopAuthloading());
        try {
          final usercredential = await _auth.createUserWithEmailAndPassword(
              email: event.user.email.toString(),
              password: event.user.password.toString());

          final user = usercredential.user;

          if (user != null) {
            FirebaseFirestore.instance
                .collection("MallBuddyShops")
                .doc(user.uid)
                .set({
              "userId": user.uid,
              "email": user.email,
              "Ownername": event.user.Ownername,
              "Shopname": event.user.Shopname,
              "phone_number": event.user.phone,
              "selecfloor": event.user.Selectfloor,
              "timestamp": DateTime.now(),
              "Onesignal_id": "playerId",
              "ban": "0",
              "status": "0",
              "imagepath":
                  "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg"
            });
            emit(ShopAuthenticated(user));
          } else {
            emit(ShopUnAuthenticated());
          }
        } catch (e) {
          emit(ShopAuthenticatedError(message: e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );

    on<FetchShopDetailsById>((event, emit) async {
      emit(Shoploading());
      User? user = _auth.currentUser;
      print("fetch shop details loading......");
      if (user != null) {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final doc = await FirebaseFirestore.instance
                .collection('MallBuddyShops')
                .doc(user.uid)
                .get();

            if (doc.exists) {
              ShopModel userData = ShopModel.fromMap(doc.data()!);
              emit(ShopByidLoaded(userData));
            } else {
              emit(Shoperror(error: "User profile not found"));
            }
          } else {
            emit(Shoperror(error: "User not authenticated"));
          }
        } catch (e) {
          emit(Shoperror(error: e.toString()));
        }
      }
    });



    on<ShopSigOutEvent>(
      (event, emit) async {
        try {
          User? user = _auth.currentUser;

          if (user != null) {
            // Get the Player ID from OneSignalService

            // Update Firestore with the correct user ID and OneSignal ID
            await FirebaseFirestore.instance
                .collection("MallBuddyShops")
                .doc(user.uid) // Use current user's UID
                .update({"Onesignal_id": "null"}); // Update with OneSignal ID

            // Sign out the user
            await _auth.signOut();
            emit(ShopUnAuthenticated());
          } else {
            emit(ShopAuthenticatedError(message: "No user is logged in"));
          }
        } catch (e) {
          emit(ShopAuthenticatedError(message: e.toString()));
        }
      },
    );
    on<ShopAcceptRejectbuddyevent>(
          (event, emit) async {
        try {
          emit(ShopAcceptloading());

          await FirebaseFirestore.instance
              .collection("MallBuddyShops")
              .doc(event.id)
              .update({"status": event.status});
          emit(ShopRefresh());
        } catch (e) {
          print(e);
        }
      },
    );

    on<ShopLoginEvent>(
      (event, emit) async {
        emit(ShopAuthloading());
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
                .collection("MallBuddyShops")
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;
              if (userData['ban'] == "0") {
                if (userData['status'] == "1") {
                  // Update OneSignal ID
                  await FirebaseFirestore.instance
                      .collection("MallBuddyShops")
                      .doc(user.uid)
                      .update({"Onesignal_id": "playerId"});

                  emit(ShopAuthenticated(user));
                  print("Auth successfully");
                } else {
                  await _auth.signOut();
                  emit(ShopAuthenticatedError(
                      message:
                          "Please wait, you are in progress. Please try again later."));
                }
              } else {
                await _auth.signOut();
                emit(ShopAuthenticatedError(message: "you are banned"));
                emit(ShopUnAuthenticated());
              }
              // Check if the 'Ban' field is 1
            } else {
              await _auth.signOut();
              emit(ShopUnAuthenticated());
              emit(ShopAuthenticatedError(message: "User data not found."));
            }
          } else {
            await _auth.signOut();
            emit(ShopUnAuthenticated());
          }
        } on FirebaseAuthException catch (e) {
          await _auth.signOut();
          emit(ShopUnAuthenticated());
          emit(ShopAuthenticatedError(
              message: e.message ?? "An error occurred."));
          print("FirebaseAuthException: ${e.message}");
        } catch (e) {
          await _auth.signOut();
          emit(ShopUnAuthenticated());
          emit(
              ShopAuthenticatedError(message: "An unexpected error occurred."));
          print("Login error: ${e.toString()}");
        }
      },
    );

    //   get all shopes

    on<FetchShopesDetailsEvent>((event, emit) async {
      emit(ShopgetLoading());
      try {
        CollectionReference ShopesCollection =
            FirebaseFirestore.instance.collection('MallBuddyShops');

        Query query = ShopesCollection;
        query = query.where("status", isEqualTo: event.status);

        QuerySnapshot snapshot = await query.get();

        List<ShopModel> shopes = snapshot.docs.map((doc) {
          return ShopModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          shopes = shopes.where((driver) {
            return driver.Ownername!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Shopesloaded(shopes));
      } catch (e) {
        emit(Shopesfailerror(e.toString()));
      }
    });
  }
}
