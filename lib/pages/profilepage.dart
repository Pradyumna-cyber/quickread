import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'homepage.dart';

void navigateToNews(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const NewsPage()),
  );
}
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 40),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('images/news.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'User',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                crossAxisCount: 2,
                children: <Widget>[
                  _buildGridItem(Icons.person, 'Profile'),
                  _buildGridItem(Icons.notifications_active_rounded, 'Notification'),
                  _buildGridItem(Icons.filter_tilt_shift_rounded, 'General'),
                  _buildGridItem(Icons.logout, 'Logout'),
                ],
              ),
            ),
           Container(
                alignment: Alignment.bottomCenter,
                child:  GNav(
                    tabBackgroundColor: Colors.white70,
                    gap: 8,
                    tabs: [
                       GButton(
                        onPressed: () {
                          navigateToNews(context);
                        },
                        icon: Icons.home,
                        text: "Home",
                      ),
                      GButton(
                        icon: Icons.video_file_rounded,
                        text: 'Video News',
                        backgroundColor: Colors.orange.shade300,
                      ),
                      const GButton(
                        icon: Icons.person_pin,
                        text: 'Profile',
                      )
                    ],
                  ),

              ),
          ],
        ),
      ),

    );
  }

  Widget _buildGridItem(IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        // Add functionality for each grid item
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
