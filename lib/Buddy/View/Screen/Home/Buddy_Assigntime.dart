import 'package:flutter/material.dart';



class BuddyassigntimeScreen extends StatefulWidget {
  @override
  _BuddyassigntimeScreenState createState() => _BuddyassigntimeScreenState();
}

class _BuddyassigntimeScreenState extends State<BuddyassigntimeScreen> {
  bool isAvailable = false;
  String? selectedDay;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? selectedTimeSlot;

  List<String> days = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  List<String> timeSlots = ["08:00 AM", "09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "01:00 PM"];

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Availability Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Available", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Switch(
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value;
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ],
            ),

            SizedBox(height: 20),

            // Days Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map((day) {
                bool isSelected = selectedDay == day;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = day;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      day,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            // Time Picker
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _timePicker("Starting time", startTime, (time) {
                        setState(() {
                          startTime = time;
                        });
                      }),
                      _timePicker("Ending time", endTime, (time) {
                        setState(() {
                          endTime = time;
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.blue),
                    label: Text("Add more time", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // OR Text
            Center(
              child: Text("OR", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),

            SizedBox(height: 10),

            // Time Slots Selection
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5,
              ),
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                String time = timeSlots[index];
                bool isSelected = selectedTimeSlot == time;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTimeSlot = time;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle save logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timePicker(String label, TimeOfDay? time, Function(TimeOfDay) onTimeSelected) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? selectedTime = await _selectTime(context);
        if (selectedTime != null) {
          onTimeSelected(selectedTime);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            width: 140,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time != null ? time.format(context) : "--:--", style: TextStyle(fontSize: 16)),
                Icon(Icons.access_time, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
