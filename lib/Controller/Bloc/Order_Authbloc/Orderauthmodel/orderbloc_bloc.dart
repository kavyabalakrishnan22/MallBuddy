import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mall_bud/Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import 'package:mall_bud/Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';

import 'orderbloc_event.dart';
import 'orderbloc_state.dart';


class OrderAuthBloc extends Bloc<OrderAuthEvent, OrderAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  OrderAuthBloc() : super(OrderAuthInitial()) {
    // check Auth or Not
    on<checkOrderloginstateevent>(
          (event, emit) async {
        User? user;
        try {
          await Future.delayed(Duration(seconds: 3));
          user = _auth.currentUser;
          if (user != null) {
            emit(OrderAuthenticated(user));
          } else {
            emit(OrderUnAuthenticated());
          }
        } catch (e) {
          emit(OrderAuthenticatedError(
            message:
            e.toString().split('] ').last, // Extracts only the message part
          ));
        }
      },
    );
    // Signup


    on<FetchOrderDetailsById>((event, emit) async {
      emit(Orderloading());
      User? user = _auth.currentUser;
      print("fetch shop details loading......");
      if (user != null) {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final doc = await FirebaseFirestore.instance
                .collection('MallBuddyOrder')
                .doc(user.uid)
                .get();

            if (doc.exists) {
              OrderModel userData = OrderModel.fromMap(doc.data()!);
              emit(OrderByidLoaded(userData));
            } else {
              emit(Ordererror(error: "User profile not found"));
            }
          } else {
            emit(Ordererror(error: "User not authenticated"));
          }
        } catch (e) {
          emit(Ordererror(error: e.toString()));
        }
      }
    });

    on<OrderSigOutEvent>(
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
            emit(OrderUnAuthenticated());
          } else {
            emit(OrderAuthenticatedError(message: "No user is logged in"));
          }
        } catch (e) {
          emit(OrderAuthenticatedError(message: e.toString()));
        }
      },
    );

    on<OrderLoginEvent>(
          (event, emit) async {
        emit(OrderAuthloading());
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

                  emit(OrderAuthenticated(user));
                  print("Auth successfully");
                } else {
                  await _auth.signOut();
                  emit(OrderAuthenticatedError(
                      message:
                      "Please wait, you are in progress. Please try again later."));
                }
              } else {
                await _auth.signOut();
                emit(OrderAuthenticatedError(message: "you are banned"));
                emit(OrderUnAuthenticated());
              }
              // Check if the 'Ban' field is 1
            } else {
              await _auth.signOut();
              emit(OrderUnAuthenticated());
              emit(OrderAuthenticatedError(message: "User data not found."));
            }
          } else {
            await _auth.signOut();
            emit(OrderUnAuthenticated());
          }
        } on FirebaseAuthException catch (e) {
          await _auth.signOut();
          emit(OrderUnAuthenticated());
          emit(OrderAuthenticatedError(
              message: e.message ?? "An error occurred."));
          print("FirebaseAuthException: ${e.message}");
        } catch (e) {
          await _auth.signOut();
          emit(OrderUnAuthenticated());
          emit(
              OrderAuthenticatedError(message: "An unexpected error occurred."));
          print("Login error: ${e.toString()}");
        }
      },
    );

    //   get all shopes

    on<FetchOrderDetailsEvent>((event, emit) async {
      emit(OrdergetLoading());
      try {
        CollectionReference OrderCollection =
        FirebaseFirestore.instance.collection('MallBuddyShops');

        Query query = OrderCollection;
        query = query.where("status", isEqualTo: event.status);

        QuerySnapshot snapshot = await query.get();

        List<OrderModel> Orders = snapshot.docs.map((doc) {
          return OrderModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          Orders= Orders.where((driver) {
            return driver.Ownername!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Shopesloaded(Orders));
      } catch (e) {
        emit(Shopesfailerror(e.toString()));
      }
    });
  }
}
