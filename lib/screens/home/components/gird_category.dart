import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/screens/listQuestionarios/list.dart';

import 'grid_category_card.dart';


class CategoryGrid extends StatelessWidget {
  CategoryGrid({
    Key key,
  }) : super(key: key);

  final DataSource dataSource = DataSource();
  List<String> categories = ['Clássico','Contra-Relógio','Morte Súbita', 'Todos'];

  void navigateToCategoryList(String category, BuildContext context){
    Get.to(() => ListQuestionarios(category));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 20,right: 20),
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1.7,
        children: List.generate(
            4,
                (index) {
              return GridCategoryCard(
                index: index,
                categories: categories,
                MainContext: context,
                tapEvent: navigateToCategoryList,
              );
            }
        ),
      ),
    );
  }
}