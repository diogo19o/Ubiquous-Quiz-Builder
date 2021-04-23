import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';

class CurvedBottomNavBar extends StatefulWidget {
  @override
  _CurvedBottomNavBarState createState() => _CurvedBottomNavBarState();
}

class _CurvedBottomNavBarState extends State<CurvedBottomNavBar> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  Color paintBottomNavIcons(int index){
    return  /*currentIndex == index
        ? AppColors.Orange
        : */AppColors.PrimaryMidBlue;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: 80,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                      backgroundColor: AppColors.Orange,
                      child: Icon(MdiIcons.home, size: 30,),
                      elevation: 0.1,
                      onPressed: () {}),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            setBottomBarIndex(1);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Icon(
                                MdiIcons.gamepadVariant,
                                size: 35,
                                color: paintBottomNavIcons(1),
                              ),
                              Text("Jogo", style: TextStyle(color: paintBottomNavIcons(1)))
                            ],
                          )),
                      TextButton(
                          onPressed: () {
                            setBottomBarIndex(2);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Icon(
                                MdiIcons.helpCircle,
                                size: 35,
                                color: paintBottomNavIcons(2),
                              ),
                              Text("Questionário", style: TextStyle(color: paintBottomNavIcons(2)))
                            ],
                          )),
                      Container(
                        width: size.width * 0.20,
                      ),
                      TextButton(
                          onPressed: () {
                            setBottomBarIndex(3);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Icon(
                                MdiIcons.chartBox,
                                size: 35,
                                color: paintBottomNavIcons(3),
                              ),
                              Text("Ranking", style: TextStyle(color: paintBottomNavIcons(3)))
                            ],
                          )),
                      TextButton(
                          onPressed: () {
                            setBottomBarIndex(0);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                size: 35,
                                color: paintBottomNavIcons(0),
                              ),
                              Text("Perfil", style: TextStyle(color: paintBottomNavIcons(0)))
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}