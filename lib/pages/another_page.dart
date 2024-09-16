import 'package:flutter/material.dart';
import 'package:labshared_pref/pages/first_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnotherPage extends StatefulWidget {
  const AnotherPage({super.key});

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  // Declare your variable for data
  String? myname;

  // Declare your function to load data
  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myname = prefs.getString("myName");
    });
  }

  void removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("myName");
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Another Page", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(
                      255, 242, 179, 7), // เปลี่ยนสี AppBar ให้เป็นชมพูอ่อน
      ),
      backgroundColor: Colors.pink[50], // สีพื้นหลังของ Scaffold
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show Your name
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                child: Text(
                  myname ?? "รอสักครู่",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.pink[300],
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              // Button go to Home Page
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(
                      255, 242, 179, 7), // Background color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'ย้อนกลับ',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // Button go to First Page
              ElevatedButton.icon(
                onPressed: () {
                  removeData(); // ฟังก์ชันที่ใช้ลบข้อมูล เช่น token หรือ session
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            FirstPage()), // นำผู้ใช้กลับไปยัง FirstPage
                    (Route<dynamic> route) => false, // ลบทุกหน้าใน stack
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(
                      255, 242, 179, 7), // Background color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text(
                  'หน้าแรก',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
