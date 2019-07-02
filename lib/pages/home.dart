import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<Device> devicesOn = [
    Device(title: 'Stand Lamp', room: 'Living Room'),
    Device(title: 'Curtains', room: 'Living Room'),
    Device(title: 'TV', room: 'Bedroom'),
  ];
  
  List<QuickAction> quickActions = [
    QuickAction(title: 'Get Up', icon: AssetImage('assets/icons/get_up.png',)),
    QuickAction(title: 'Sleep', icon: AssetImage('assets/icons/get_up.png',)),
    QuickAction(title: 'Happy', icon: AssetImage('assets/icons/get_up.png',)),
    QuickAction(title: 'Sad', icon: AssetImage('assets/icons/get_up.png',)),
  ];
  
  List<Scene> scenes = [
    Scene(title: 'Gest Scene', off: false),
    Scene(title: 'Leave Home', off: true),
    Scene(title: 'Party', off: true),
    Scene(title: 'Romantic', off: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/home.png',),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 3, bottom: 3, left: 7.5, right: 7.5),
                          child: Text('Welcome',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'ProximaNova',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0XFF76CDDE),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(2.5), topRight: Radius.circular(2.5))
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
                          color: Colors.white,
                          child: Text('Home',
                            style: TextStyle(
                              color: Color(0xFF1D2952),
                              fontSize: 40,
                              fontFamily: 'ProximaNova',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Devices on',
                              style: TextStyle(
                                color: Color(0xFF1D2952),
                                fontFamily: 'MuktaMahee',
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text('View all',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.35),
                                fontFamily: 'MuktaMahee',
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 185,
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints viewportConstraints) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.only(left: 12.5, right: 12.5,),
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: viewportConstraints.maxWidth,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: devicesOn.map((Device device) {
                                    return Container(
                                      width: 150,
                                      height: 175,
                                      margin: EdgeInsets.only(left: 7.5, right: 7.5),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 3.0, // has the effect of softening the shadow
                                            spreadRadius: 0, // has the effect of extending the shadow
                                            offset: Offset(
                                              2.5, // horizontal, move right 10
                                              2.5, // vertical, move down 10
                                            ),
                                          )
                                        ]
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.orange[200],
                                              borderRadius: BorderRadius.all(Radius.circular(20))
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(device.title, 
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2952),
                                                    fontFamily: 'MuktaMahee',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                  )
                                                ),
                                                Text(device.room, 
                                                  style: TextStyle(
                                                    color: Colors.black.withOpacity(0.35),
                                                    fontFamily: 'MuktaMahee',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold
                                                  )
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Quick Action',
                              style: TextStyle(
                                color: Color(0xFF1D2952),
                                fontFamily: 'MuktaMahee',
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text('View all',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.35),
                                fontFamily: 'MuktaMahee',
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 85,
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints viewportConstraints) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.only(left: 12.5, right: 12.5,),
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: viewportConstraints.maxWidth,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: quickActions.map((QuickAction action) {
                                    return Container(
                                      width: 140,
                                      height: 70,
                                      margin: EdgeInsets.only(left: 7.5, right: 7.5),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: Color(0XFF76CDDE),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 3.0, // has the effect of softening the shadow
                                            spreadRadius: 0, // has the effect of extending the shadow
                                            offset: Offset(
                                              2.5, // horizontal, move right 10
                                              2.5, // vertical, move down 10
                                            ),
                                          )
                                        ]
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(action.title, 
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'MuktaMahee',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                            )
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 0),
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              image: DecorationImage(
                                                image: action.icon,
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, left: 20, right: 20,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Scenes',
                              style: TextStyle(
                                color: Color(0xFF1D2952),
                                fontFamily: 'MuktaMahee',
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text('View all',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.35),
                                fontFamily: 'MuktaMahee',
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 185,
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints viewportConstraints) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.only(left: 12.5, right: 12.5,),
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: viewportConstraints.maxWidth,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: scenes.map((Scene scene) {
                                    return Container(
                                      width: 150,
                                      height: 175,
                                      margin: EdgeInsets.only(left: 7.5, right: 7.5),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 3.0, // has the effect of softening the shadow
                                            spreadRadius: 0, // has the effect of extending the shadow
                                            offset: Offset(
                                              2.5, // horizontal, move right 10
                                              2.5, // vertical, move down 10
                                            ),
                                          )
                                        ]
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.orange[200],
                                              borderRadius: BorderRadius.all(Radius.circular(20))
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(scene.title, 
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2952),
                                                    fontFamily: 'MuktaMahee',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                  )
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 6,
                                                      height: 6,
                                                      margin: EdgeInsets.only(right: 5),
                                                      decoration: BoxDecoration(
                                                        color: scene.off ? Colors.black.withOpacity(0.35) : Colors.green[200],
                                                        borderRadius: BorderRadius.all(Radius.circular(3))
                                                      ),
                                                    ),
                                                    Text(scene.off ? 'Off' : 'On', 
                                                      style: TextStyle(
                                                        color: Colors.black.withOpacity(0.35),
                                                        fontFamily: 'MuktaMahee',
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold
                                                      )
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        )
                      ),
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}

class Device {
  final String title;
  final Icon icon;
  final String room;

  Device({this.title, this.icon, this.room});
}

class QuickAction {
  final String title;
  final AssetImage icon;

  QuickAction({this.title, this.icon});
}

class Scene {
  final String title;
  final bool off;

  Scene({this.title, this.off});
}