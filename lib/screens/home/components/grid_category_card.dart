import 'package:flutter/material.dart';
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
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.PrimaryMidBlue,
              AppColors.Orange,
            ],
          )
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(15)),
                color: kCardInfoBG.withOpacity(0.6),
              ),
              /*child: Image.asset(
                "assets/images/place3.jpg",
                width: double.infinity,
                height: 200,

                fit: BoxFit.cover,
              ),*/
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
            )
          ],
        ),
      ),
    );
  }
}
