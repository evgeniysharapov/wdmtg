import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Activity Tracker Home Page'),
    );
  }
}

class Activity {
  final String title;
  final String imageUrl;
  List<DateTime> startTimes = [];
  List<DateTime> stopTimes = [];

  Activity({required this.title, required this.imageUrl});

  void start() {
    startTimes.add(DateTime.now());
  }

  void stop() {
    stopTimes.add(DateTime.now());
  }
}

class ActivityTile extends StatelessWidget {
  final Activity activity;
  final bool isActive;
  final VoidCallback onTap;

  ActivityTile({
    required this.activity,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(activity.imageUrl),
            fit: BoxFit.cover,
          ),
          border: isActive ? Border.all(color: Colors.blue, width: 3) : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.5),
          ),
          child: Center(
            child: Text(
              activity.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Activity> activities = [
    Activity(title: 'Work', imageUrl: 'office_work.png'),
    Activity(title: 'Excercies', imageUrl: 'exercise.png'),
    Activity(title: 'Read', imageUrl: 'book.png')
  ];

  Activity? currentActivity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ActivityTile(
            activity: activities[index],
            isActive: activities[index] == currentActivity,
            onTap: () => _handleActivityTap(activities[index]),
          );
        },
      ),

      // Button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _handleActivityTap(Activity tappedActivity) {
    setState(() {
      if (currentActivity != null) {
        currentActivity!.stop();
      }
      if (currentActivity != tappedActivity) {
        currentActivity = tappedActivity;
        currentActivity!.start();
      } else {
        currentActivity = null;
      }
    });
  }
}
