import 'package:flutter/material.dart';

class UserViewReplyPage extends StatelessWidget {
  final Map<String, String> complaintData = {
    'Complaint ID': 'CMP123456',
    'Date': '10 April 2025',
    'Subject': 'Late Delivery',
    'Your Complaint':
    'The delivery was delayed by over two hours and I didn’t receive any notification.',
    'Support Reply':
    'We apologize for the delay. The issue occurred due to unexpected traffic. We’ll ensure timely delivery in the future.',
    'Status': 'Resolved',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Reply", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: complaintData.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    entry.value,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
