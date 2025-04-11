import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedEmoji = -1;
  double rating = 4.0;
  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Feedback",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/Buddy/feedbackimage.png', // Your illustration image
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              "Share Your Feedback",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Please select a topic below and let us\nknow about your concern",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(5, (index) {
            //     List<String> emojiPaths = [
            //       'assets/emojis/sad.png',
            //       'assets/emojis/neutral.png',
            //       'assets/emojis/smile.png',
            //       'assets/emojis/happy.png',
            //       'assets/emojis/love.png',
            //     ];
            //     return GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           selectedEmoji = index;
            //         });
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 5),
            //         child: CircleAvatar(
            //           backgroundColor:
            //           selectedEmoji == index ? Colors.blue[50] : Colors.white,
            //           radius: 22,
            //           child: Image.asset(
            //             emojiPaths[index],
            //             height: 28,
            //           ),
            //         ),
            //       ),
            //     );
            //   }),
            // ),
            SizedBox(height: 20),
            Text(
              "Give us your rider feedback",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      rating = index + 1.0;
                    });
                  },
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Write your feedback (Optional)",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Please write here",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle submit
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
