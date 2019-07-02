import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_gesture/widgets/slider_and_picker.dart';
import 'package:flutter/scheduler.dart';

class ControlerPage extends StatefulWidget {
  ControlerPage({
    Key key,
  }) : super(key: key);

  @override
  _ControlerPageState createState() => _ControlerPageState();
}

class _ControlerPageState extends State<ControlerPage> {
  
  bool _value = true;
  Color _color;
  int _number;

  _onChanged(bool value) {
    setState(() {
      _value = value;
    });
  }
  
  _onColorUpdate(Color color) {
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() { _color = color;}));
  }
  
  _onNumberUpdate(int number) {
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() { _number = number;}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  child: Icon(Icons.arrow_back, color: Color(0xFF1D2952),),
                ),
                Spacer(),
                Container(
                  width: 60,
                  height: 60,
                  child: Icon(Icons.more_vert, color: Color(0xFF1D2952),),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 80,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Container(
                              child: Text('Main Light',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'MuktaMahee',
                                  color: Color(0xFF1D2952),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38
                                ),
                              ),
                            )
                          ),
                          Positioned(
                            top: 48,
                            child: Container(
                              child: Text('Bedroom',
                                style:TextStyle(
                                  fontFamily: 'MuktaMahee',
                                  color: Color(0xFF1D2952),
                                  fontSize: 17
                                )  
                              ),
                            ),  
                          )
                        ],
                      ),
                    )
                  ),
                  Flexible(
                    flex: 0,
                    child: Container(
                      height: 60,
                      width: 60,
                      child: CupertinoSwitch( //Swicth
                        // activeThumbImage: AssetImage('assets/icons/switch-active.png'),
                        // activeTrackColor: Color(0xFFF45350),
                        activeColor: Color(0xFFF45350),
                        value: _value,
                        onChanged: (bool value) {
                          _onChanged(value);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  SliderAndPicker(
                    width: 200,
                    height: 600,
                    onColorUpdate: (Color color) => _onColorUpdate(color),
                    onNumberUpdate: (int number) => _onNumberUpdate(number),
                  ),
                  Positioned(
                    top: 180,
                    left: 20,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_number.toString(),
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 100,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1D2952),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 26),
                                child: Text('lm',
                                  style: TextStyle(
                                    fontFamily: 'MuktaMahee',
                                    fontSize: 17,
                                    color: Color(0xFF1D2952),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: Text('Light Strength',
                              style: TextStyle(
                                fontFamily: 'MuktaMahee',
                                fontSize: 17,
                                color: Color(0xFF1D2952),
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                  Positioned(
                    bottom: 150,
                    left: 20,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Icon(Icons.flash_on, color: Colors.black.withOpacity(0.2), size: 20,)
                              ),
                              Text('12 kw',
                                style: TextStyle(
                                  fontFamily: 'MuktaMahee',
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.35),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                padding: EdgeInsets.all(10),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _color,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                              ),
                              Text('Hue',
                                style: TextStyle(
                                  fontFamily: 'MuktaMahee',
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.35),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    )
                  )
                ],
              ),
            ),
            // FOOTER
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0XFFF1F2F6), width: 1.5))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding:EdgeInsets.only(right: 10),
                          child: Icon(Icons.access_time, color: Colors.black26,),
                        ),
                        Text('Set smart schedule',
                          style: TextStyle(
                            fontFamily: 'MuktaMahee',
                            fontSize: 17,
                            color: Color(0xFF1D2952),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.black26, size: 17,),
                  ],
                )
              ),
            )
          ],
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}