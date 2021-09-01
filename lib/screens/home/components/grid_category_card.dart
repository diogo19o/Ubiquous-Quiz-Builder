import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/constants.dart';

import '../../../util.dart';

class GridCategoryCard extends StatelessWidget {
  const GridCategoryCard(
      {Key key,
      @required this.index,
      @required this.categories,
      @required this.MainContext,
      @required this.tapEvent})
      : super(key: key);

  final MainContext;
  final Function(String, BuildContext) tapEvent;
  final List<String> categories;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            tapEvent("classico", MainContext);
            break;
          case 1:
            tapEvent("contra_relogio", MainContext);
            break;
          case 2:
            tapEvent("morte_subita", MainContext);
            break;
          case 3:
            tapEvent("all", MainContext);
            break;
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(35),
                topLeft: Radius.circular(35),
                topRight: Radius.circular(15)),
            gradient: index == 0 ? LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.lightGreen,
                Colors.lightGreen,
              ],
            ) : index == 1 ? LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.orangeAccent,
                Colors.orangeAccent,
              ],
            ) : index == 2 ? LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.deepOrange[800],
                Colors.deepOrange[800],
              ],
            ) : LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blueAccent,
                Colors.blueAccent,
              ],
            )),
        child: Stack(
          children: [
            Container(
              decoration: cardBackgroundDecoration,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  children: [
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: cardInfoDecoration,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                categories[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: index == 3 ? EdgeInsets.only(top: 5.0) : EdgeInsets.only(top: 12.0),
                  child: index == 0
                      ? Icon(
                          MdiIcons.gamepad,
                          color: Colors.white,
                          size: 50,
                        )
                      : index == 1
                          ? Icon(
                              MdiIcons.alarm,
                              color: Colors.white,
                              size: 50,
                            )
                          : index == 2
                              ? Icon(
                                  MdiIcons.skull,
                                  color: Colors.white,
                                  size: 50,
                                )
                              : Icon(
                                  MdiIcons.viewModule,
                                  color: Colors.white,
                                  size: 65,
                                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
