import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_bud/Controller/Bloc/Order_Authbloc/Orderauthmodel/order_auth_model.dart';
import 'package:mall_bud/Controller/Bloc/Order_Authbloc/Orderauthmodel/order_bloc.dart';

class ShopCheckoutPage extends StatelessWidget {
  final String riderName;

  final String riderContact;
  final String deliveryTime;
  final String ownerName;
  final String ownerMobile;
  final String vehicleNumber;
  final String vehicleName;
  final String vehicleColor;
  final String parkingFloor;
  final String parkingPillar;
  final String id;
  final String useremail;
  final String ownerContact;
  final String invoiceId;

  const ShopCheckoutPage({
    super.key,
    required this.id,
    required this.riderName,
    required this.riderContact,
    required this.deliveryTime,
    required this.ownerName,
    required this.ownerMobile,
    required this.vehicleNumber,
    required this.vehicleName,
    required this.vehicleColor,
    required this.parkingFloor,
    required this.parkingPillar,
    required this.useremail,
    required this.ownerContact,
    required this.invoiceId,
  });

  void _registerUser() {
    void _registerUser() {
      if (_formKey.currentState?.validate() ?? false) {
        OrderModel user = OrderModel(conatctrider: riderContact,
            Ridername: riderName,
          useremail: useremail,
          invoiceid: invoiceId,
          Ownername: ownerName,
          userphone: ownerMobile,
          status: "0",
          Shopname: ownerName,
          Selectfloor: parkingFloor,
          vehicle_name: vehicleName,
          vehicle_color: vehicleColor,
          vehicle_number: vehicleNumber,
          uid: id,

        );
        // Trigger the sign-up event
        context.read<OrderBloc>().add(ShopSignupEvent(user: user));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout (3/4)"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rider Details
            _buildSectionTitle("Rider Details"),
            _buildBoldText("Ridername", riderName),
            _buildDetailRow("Contact:", riderContact),
            const SizedBox(height: 8),

            // Delivery Time Box
            _buildDeliveryTimeBox(deliveryTime),
            const Divider(height: 30),

            // Customer Details
            _buildSectionTitle("Customer Details"),
            _buildParkingFloorRow(parkingFloor, parkingPillar),
            _buildDetailRow("Owner Name", ownerName),
            _buildDetailRow("Mobile Number", ownerMobile),
            _buildDetailRow("Vehicle Number", vehicleNumber),
            _buildDetailRow("Vehicle Name", vehicleName),
            _buildDetailRow("Vehicle Color", vehicleColor),
            const Divider(height: 30),

            // Payment Details
            _buildSectionTitle("Payment Details"),
            _buildDetailRow("Delivery Charges", "₹ 200"),

            const Spacer(),

            // Complete Payment Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _registerUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Complete Payment",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Rider Name with ID
  Widget _buildBoldText(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // Rider Contact & Payment Details
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Parking Floor and Pillar Row
  Widget _buildParkingFloorRow(String floor, String pillar) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Parking floor\nand pillar",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Row(
            children: [
              _buildSmallButton(floor),
              const SizedBox(width: 6),
              _buildSmallButton(pillar),
            ],
          ),
        ],
      ),
    );
  }

  // Small Button (For Parking Floor & Pillar)
  Widget _buildSmallButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  // Delivery Time Box
  Widget _buildDeliveryTimeBox(String time) {
    return Row(
      children: [
        const Text("Delivery Time:",
            style: TextStyle(fontSize: 14, color: Colors.black87)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white38,
            border: Border.all(width: 0.7, color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(time,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
