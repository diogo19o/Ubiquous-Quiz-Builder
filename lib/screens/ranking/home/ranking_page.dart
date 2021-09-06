import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/data/api_response.dart';
import 'package:ubiquous_quizz_builder/models/ranking_user.dart';
import 'package:ubiquous_quizz_builder/models/utilizador.dart';
import 'package:ubiquous_quizz_builder/screens/ranking/home/ranking_controller.dart';
import 'package:ubiquous_quizz_builder/screens/ranking/shared/custom_chip/custom_chip_widget.dart';
import 'package:ubiquous_quizz_builder/screens/ranking/shared/triade_ranking/triade_ranking.dart';

class RankingScreen extends StatefulWidget {
  final String title;

  const RankingScreen({Key key, this.title = "Ranking"}) : super(key: key);

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  RankingController controller = RankingController();

  @override
  void initState() {
    controller.blocServices.fetchResultsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          gradient: AppColors.backgroudFade),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          title: Text(widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25)),
          centerTitle: true,
          bottom: PreferredSize(
            child: Observer(builder: (_) {
              return buildCategorias();
            }),
            preferredSize: Size.fromHeight(40),
          ),
        ),
        body: Observer(builder: (_) {
          var size = controller.listaUsersRanking.length;
          return _buildBody(context, size);
        }),
      ),
    );
  }

  Row buildCategorias() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomChipWidget(
                label: "Contra-Relógio",
                selected: controller.selectedIndex == 0,
                onSelected: ()  => controller.changeIndex(0),
              ),
              CustomChipWidget(
                label: "Clássico",
                selected: controller.selectedIndex == 1,
                onSelected: ()  => controller.changeIndex(1),
              ),
              CustomChipWidget(
                label: "Morte-Súbita",
                selected: controller.selectedIndex == 2,
                onSelected: () => controller.changeIndex(2),
              ),
            ],
          );
  }

  RefreshIndicator _buildBody(BuildContext context, size) {
    return RefreshIndicator(
      onRefresh: () => controller.blocServices.fetchResultsList(),
      child: StreamBuilder<ApiResponse<List<Utilizador>>>(
        stream: controller.blocServices.quizResultsStream.asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case Status.COMPLETED:
                return buildStats(size);
                break;
              case Status.ERROR:
                return AlertDialog(
                  title: Text("Não foi possivel atualizar a lista"),
                  actions: [
                    TextButton(
                        onPressed: () => controller.blocServices
                            .fetchLocalResultsList() /*Get.back()*/,
                        child: Text("Usar dados offline")),
                    TextButton(
                        onPressed: () =>
                            {controller.blocServices.fetchResultsList()},
                        child: Text("Tentar de novo")),
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

  Widget buildStats(int size) {
    print(size);
    print("'recent'");
    print(controller.listaUsersRanking.length);
    return size == 0
        ? buildNoResultsMessage(size)
        : size <= 3
        ? Column(
      children: [
        buildTopThree(size),
        buildNoResultsMessage(size)
      ],
    )
        : buildResultadosSecondarios(size);
  }

  ShaderMask buildResultadosSecondarios(int size) {
    return ShaderMask(
          child: ListView.builder(
            itemCount: size,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return buildTopThree(size);
              }
              if (index < 3) {
                return Container();
              }
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "${index + 1}",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        /*Icon(
                        Icons.arrow_drop_up,
                        color: Color(0xff21EEB6),
                      )*/
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .75,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.2),
                          borderRadius: BorderRadius.circular(50)),
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(MdiIcons.account, size: 30, color: AppColors.SecondaryLight,),
                            radius:
                            22,
                            backgroundColor: AppColors.PrimaryLight,
                            /*backgroundImage: NetworkImage(
                              controller.listaUsersRanking[index].picture),*/
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              controller
                                  .listaUsersRanking[index].nome,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Text(
                            "${controller.selectedIndex == 0 ? controller.listaUsersRanking[index].resultadosCR[0].score : controller.selectedIndex == 1 ? controller.listaUsersRanking[index].resultadosC[0].score : controller.listaUsersRanking[index].resultadosMS[0].score}",
                            style: TextStyle(
                                color: AppColors.Orange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Color(0xff002619)
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstOut,
        );
  }

  Column buildNoResultsMessage(int size) {
    return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.2),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Text(
                            size == 0 ?
                            "Não existem resultados disponiveis" : "Ainda não existem mais resultados",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "",
                          style: TextStyle(
                              color: Color(0xff45C9A1),
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ],
            )
          ],
        );
  }

  TopThreeRanking buildTopThree(int size) {
    return size == 1
        ? TopThreeRanking(
            first: controller.listaUsersRanking[0], second: null, third: null)
        : size == 2
            ? TopThreeRanking(
                first: controller.listaUsersRanking[0],
                second: controller.listaUsersRanking[1],
                third: null)
            : size != 0
                ? TopThreeRanking(
                    first: controller.listaUsersRanking[0],
                    second: controller.listaUsersRanking[1],
                    third: controller.listaUsersRanking[2])
                : Container(
                    width: 0,
                    height: 0,
                  );
  }
}
