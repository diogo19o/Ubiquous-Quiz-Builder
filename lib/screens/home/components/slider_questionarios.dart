import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/data/api_response.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/models/questionario_details.dart';
import 'package:ubiquous_quizz_builder/screens/home/components/card_questionario.dart';
import 'package:ubiquous_quizz_builder/screens/quiz/quiz_initial_page.dart';

class SliderQuestionario extends StatefulWidget {
  const SliderQuestionario({
    Key key,
  }) : super(key: key);

  @override
  _SliderQuestionarioState createState() => _SliderQuestionarioState();
}

class _SliderQuestionarioState extends State<SliderQuestionario> {
  DataSource _dataSource = DataSource();
  Services _bloc = Services();

  int _currentSlider = 0;
  int _listSize;

  Size size;

  void navigateToQuiz(String id, BuildContext context) {
    Provider.of<Services>(context, listen: false).loadActiveQuiz(int.parse(id));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizInitialPage(),
      ),
    );
  }

  List<QuestionarioDetails> questionariosFiltered;

  filterQuestionarios(){
    questionariosFiltered = _dataSource.questionarios
        .where((questionario) => questionario.modo == "questionario")
        .toList();
    _listSize = questionariosFiltered.length;
  }

  @override
  void initState() {
    super.initState();
    _bloc.fetchQuizList();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () => _bloc.fetchQuizList(),
      child: StreamBuilder<ApiResponse<List<QuestionarioDetails>>>(
        stream: _bloc.quizListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case Status.COMPLETED:
                filterQuestionarios();
                return _buildPageView();
                break;
              case Status.ERROR:
                return AlertDialog(
                  title: Text("Não foi possivel atualizar a lista: ${snapshot.data.message}", style: TextStyle(color: AppColors.SecondaryMid),),
                  backgroundColor: AppColors.PrimaryLight,
                  titlePadding: EdgeInsets.only(left: 10,right: 10, top: 20),
                  actions: [
                    TextButton(onPressed: () => {_bloc.fetchLocalQuizList()}, child: Text("OK", style: TextStyle(color: AppColors.PrimaryDarkBlue),)),
                    TextButton(onPressed: () => {_bloc.fetchQuizList()}, child: Text("Tentar de novo", style: TextStyle(color: AppColors.PrimaryDarkBlue),)),
                  ],
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildPageView(){
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
                    _currentSlider = value;
                  });
                },
                controller: PageController(
                    viewportFraction: 0.7, initialPage: _currentSlider),
                itemCount: _listSize,
                itemBuilder: (context, index) => QuestionarioCard(
                  questionario: questionariosFiltered[index],
                  MainContext: context,
                  tapEvent: navigateToQuiz,
                )),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              List.generate(_listSize, (index) => buildDotNav(index: index)),
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
      width: _currentSlider == index ? 24 : 6,
      decoration: BoxDecoration(
          color: _currentSlider == index
              ? AppColors.SecondaryMid
              : AppColors.SecondaryMid.withAlpha(70),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
