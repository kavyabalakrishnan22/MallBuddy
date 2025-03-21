import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_bud/Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import 'package:mall_bud/Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';

import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import 'Checkout.dart';

class AssignRiderWrapper extends StatelessWidget {
  final String ownername;
  final String ownerEmail;
  final String ownerContact;
  final String invoiceId;
  final String parkingfloor;
  final String vehiclename;
  final String vehicleNumber;
  final String vehicleColor;
  final String deliveryTime;
  final String pillar;
  final String Userid;

  const AssignRiderWrapper({
    super.key,
    required this.ownername,
    required this.ownerEmail,
    required this.ownerContact,
    required this.invoiceId,
    required this.parkingfloor,
    required this.vehiclename,
    required this.vehicleNumber,
    required this.vehicleColor,
    required this.deliveryTime,
    required this.pillar,
    required this.Userid,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuddyAuthBloc>(
      create: (context) => BuddyAuthBloc()
        ..add(FetchBuddyDetailsEvent(searchQuery: null, status: "1")),
      child: AssignRidersPage(
        ownername: ownername,
        ownerEmail: ownerEmail,
        ownerContact: ownerContact,
        invoiceId: invoiceId,
        parkingfloor: parkingfloor,
        vehiclename: vehiclename,
        vehicleNumber: vehicleNumber,
        vehicleColor: vehicleColor,
        deliveryTime: deliveryTime,
        pillar: pillar,
        Userid: Userid,
      ),
    );
  }
}

class AssignRidersPage extends StatelessWidget {
  final String ownername;
  final String ownerEmail;
  final String ownerContact;
  final String invoiceId;
  final String parkingfloor;
  final String vehiclename;
  final String vehicleNumber;
  final String vehicleColor;
  final String deliveryTime;
  final String pillar;
  final String Userid;

  const AssignRidersPage({
    super.key,
    required this.ownername,
    required this.ownerEmail,
    required this.ownerContact,
    required this.invoiceId,
    required this.parkingfloor,
    required this.vehiclename,
    required this.vehicleNumber,
    required this.vehicleColor,
    required this.deliveryTime,
    required this.pillar,
    required this.Userid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Rider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Available Riders",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is BuddygetLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is Buddyfailerror) {
                    return Text(state.error.toString());
                  } else if (state is Buddyloaded) {
                    return ListView.builder(
                      itemCount: state.Buddys.length,
                      itemBuilder: (context, index) {
                        final rider = state.Buddys[index];
                        return Card(
                          color: Colors.grey[100],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://cdn1.iconfinder.com/data/icons/proffesion/257/Driver-512.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rider.name.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Contact : ${rider.phone}",
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ShopCheckoutPage(
                                                          riderName: rider.name
                                                              .toString(),
                                                          riderContact: rider
                                                              .phone
                                                              .toString(),
                                                          ownerName: ownername
                                                              .toString(),
                                                          useremail: ownerEmail,
                                                          ownerContact:
                                                              ownerContact,
                                                          invoiceId: invoiceId,
                                                          parkingFloor:
                                                              parkingfloor,
                                                          vehicleName:
                                                              vehiclename,
                                                          vehicleNumber:
                                                              vehicleNumber,
                                                          vehicleColor:
                                                              vehicleColor,
                                                          deliveryTime:
                                                              deliveryTime,
                                                          parkingPillar: pillar,
                                                          ownerMobile:
                                                              ownerContact,
                                                          Userid: Userid,
                                                          Riderid: rider.uid.toString());
                                                    },
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Book",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
