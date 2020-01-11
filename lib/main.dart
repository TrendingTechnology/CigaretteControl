import 'dart:math';

import 'package:cigarette_control/firebase_firestore_util.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cigarette Control',
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFF167F67),
        primarySwatch: Colors.blue,
      ),
      home: DailySmokeCounterWidget(title: 'Smoked so far today'),
    );
  }
}

class DailySmokeCounterWidget extends StatefulWidget {
  DailySmokeCounterWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DailySmokeCounterWidgetState createState() => _DailySmokeCounterWidgetState();
}

class _DailySmokeCounterWidgetState extends State<DailySmokeCounterWidget> with SingleTickerProviderStateMixin {
  bool _loadingInProgress;

  Animation<double> _angleAnimation;
  Animation<double> _scaleAnimation;
  AnimationController _controller;

  int _counter = 0;

  FirebaseFirestoreUtil _firebaseFirestore = FirebaseFirestoreUtil();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Daily", Colors.blue, labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    new TabItem(Icons.search, "Cumulative", Colors.orange, labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    new TabItem(Icons.layers, "Settings", Colors.red),
    new TabItem(Icons.notifications, "Notifications", Colors.cyan),
  ]);

  CircularBottomNavigationController _navigationController;

  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  @override
  void initState() {
    super.initState();

    _loadingInProgress = true;

    _controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _angleAnimation = new Tween(begin: 0.0, end: 360.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    _scaleAnimation = new Tween(begin: 1.0, end: 6.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    _angleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_loadingInProgress) {
          _controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (_loadingInProgress) {
          _controller.forward();
        }
      }
    });

    _controller.forward();

    _firebaseFirestore.initState().then((counter) {
      setState(() {
        _loadingInProgress = false;
        _counter = counter;
      });
    });

    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _navigationController.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _firebaseFirestore.createCounter(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingInProgress) {
      return new Center(
        child: _buildAnimation(),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: new TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Padding(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Today you've smoked:",
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              )),
              padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            ),
            Align(alignment: Alignment.bottomCenter, child: bottomNav())
          ],
        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: _incrementCounter,
//          tooltip: 'I just smoked',
//          child: Icon(Icons.add),
//        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }

  Widget _buildAnimation() {
    double circleWidth = 10.0 * _scaleAnimation.value;
    Widget circles = new Container(
      width: circleWidth * 2.0,
      height: circleWidth * 2.0,
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              _buildCircle(circleWidth, Colors.blue),
              _buildCircle(circleWidth, Colors.red),
            ],
          ),
          new Row(
            children: <Widget>[
              _buildCircle(circleWidth, Colors.yellow),
              _buildCircle(circleWidth, Colors.green),
            ],
          ),
        ],
      ),
    );

    double angleInDegrees = _angleAnimation.value;
    return new Transform.rotate(
      angle: angleInDegrees / 360 * 2 * pi,
      child: new Container(
        child: circles,
      ),
    );
  }

  Widget _buildCircle(double circleWidth, Color color) {
    return new Container(
      width: circleWidth,
      height: circleWidth,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          print(_navigationController.value);
        });
      },
    );
  }
}
