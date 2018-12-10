import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Animation 102'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  void mylistener(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(mylistener);
      _animationController.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn));
      _animationController.forward();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn))
      ..addStatusListener(mylistener);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform(
              transform: Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
              child: Center(
                child: Center(
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animationController.reset();
          _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
              parent: _animationController, curve: Curves.fastOutSlowIn))..addStatusListener(mylistener);
          _animationController.forward();
        },
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
