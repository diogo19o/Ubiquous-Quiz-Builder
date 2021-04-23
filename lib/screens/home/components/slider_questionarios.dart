import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/data/access_service_api.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/screens/home/components/card_questionario.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/quiz_initial_page.dart';
import 'package:ubiquous_quizz_builder/screens/single_post_test.dart';

class SliderQuestionario extends StatefulWidget {
  const SliderQuestionario({
    Key key,
  }) : super(key: key);

  @override
  _SliderQuestionarioState createState() => _SliderQuestionarioState();
}

class _SliderQuestionarioState extends State<SliderQuestionario> {
  DataSource dataSource = DataSource();

  int currentSlider = 0;
  int listSize;

  void navigateToQuiz(String id, BuildContext context) {
    Provider.of<Services>(context, listen: false).loadActiveQuiz(int.parse(id));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<QuestionarioDetails> questionariosFiltered = dataSource.questionarios
        .where((questionario) => questionario.modo == "questionario")
        .toList();
    listSize = questionariosFiltered.length;

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentSlider = value;
                  });
                },
                controller: PageController(
                    viewportFraction: 0.7, initialPage: currentSlider),
                itemCount: listSize,
                itemBuilder: (context, index) => QuestionarioCard(
                      questionario: questionariosFiltered[index],
                      MainContext: context,
                      tapEvent: navigateToQuiz,
                    )),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(listSize, (index) => buildDotNav(index: index)),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer buildDotNav({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentSlider == index ? 24 : 6,
      decoration: BoxDecoration(
          color: currentSlider == index
              ? AppColors.SecondaryMid
              : AppColors.SecondaryMid.withAlpha(70),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
