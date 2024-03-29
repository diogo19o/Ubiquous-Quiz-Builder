import 'package:flutter/material.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/models/ranking_user.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';
import 'package:ubiquous_quizz_builder/screens/ranking/home/ranking_controller.dart';
import 'package:ubiquous_quizz_builder/screens/ranking/home/ranking_page.dart';

class TopThreeRanking extends StatelessWidget {
  final Utilizador first;
  final Utilizador second;
  final Utilizador third;
  int index;

  TopThreeRanking({Key key, this.first, this.second, this.third, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .4,
        ),

        if(second != null) Positioned(
          left: MediaQuery.of(context).size.width / 8,
          top: 40,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "2",
                style: TextStyle(color: AppColors.SecondaryMid,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_drop_up,
                color: AppColors.Orange,
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              CustomCircleAvatar(
                user: second,
                image: 'assets/images/trophy-2-no-bg.png',
                size: 80,
                index: index,
              ),
            ],
          ),
        ),
        first != null ? Positioned(
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "1",
                style: TextStyle(color: AppColors.SecondaryMid, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              /*Image.network(
                  "https://lh3.googleusercontent.com/proxy/_PjfCXLXySnp-3Op6HlolM3aZq3lQ3ta8bZqLGIjT8qFaM5TpZ4LoUyhAB5t9EDJCkkVi_HSjKwtx8yYCCh5Vp9gHFjc8KypmuklT_0w8fGrZI8rXDDejLkM1dXFJTDgm8Q8hKWS8NG9yJUht9ALSBuVoDgiLQ", height: 40,),*/
              SizedBox(
                height: 10,
              ),
              CustomCircleAvatar(
                user: first,
                image: 'assets/images/trophy-1-no-bg.png',
                showGlow: true,
                size: 100,
                index: index,
              ),
            ],
          ),
        ): Text("não há registos"),
        if(third != null) Positioned(
          right: MediaQuery.of(context).size.width / 8,
          top: 40,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "3",
                style: TextStyle(color: AppColors.SecondaryMid,fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              CustomCircleAvatar(
                user: third,
                image: 'assets/images/trophy-3-no-bg.png',
                size: 80,
                index: index,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  final double size;
  final String image;
  final Utilizador user;
  final bool showGlow;
  int index;

  CustomCircleAvatar(
      {Key key, this.size, this.image, this.user, this.showGlow = false, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                width: showGlow ? 3 : 5,
                color: AppColors.SecondaryLight,
              ),
              boxShadow: showGlow
                  ? [
                      BoxShadow(
                        color: AppColors.PrimaryLight,
                        blurRadius: 20,
                      )
                    ]
                  : [],
              image: DecorationImage(
                  image: ExactAssetImage(image), fit: BoxFit.fill)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          user.nome,
          style: TextStyle(color: AppColors.SecondaryMid),
        ),
        SizedBox(
          height: 5,
        ),
        Text( index == 0 ?
          "${user.resultadosCR[0].score}": index == 1 ? "${user.resultadosC[0].score}" : index == 2 ? "${user.resultadosMS[0].score}" :"Erro",
          style: TextStyle(
              color: AppColors.Orange,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        )
      ],
    );
  }
}
