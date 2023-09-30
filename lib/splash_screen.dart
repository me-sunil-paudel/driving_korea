import 'package:driving_korea/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      // Change this to your desired background color
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bgi.webp'), fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'DRIVING KOREA',
                style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w200,
                    color: Colors.deepPurple,
                    backgroundColor: Colors.yellowAccent),
              ),
              const SizedBox(
                  height: 20.0), // Add spacing between image and text
              const Text(
                'No ! language barrier, study anytime or anywhere ...',
                style: TextStyle(
                  color: Colors.deepPurple, // Change text color
                  fontSize: 20.0, // Change text size
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.arrow_forward_ios_sharp),
                label: const Text('Get start'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DashboardScreen(), //pass any arguments
                        //assign a name for the screen
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
