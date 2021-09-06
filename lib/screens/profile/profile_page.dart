import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';

class ProfileScreen extends StatelessWidget {
  Services _bloc = Services();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Map<String, double> dataMap = _bloc.calcTotalPoints();
    List<dynamic> dadosPerfil = _bloc.calcProfileData();
    DataSource dataSource = DataSource();

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(gradient: AppColors.backgroudFade),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Perfil"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Text(
                                      dataSource.utilizadorAtivo.nome,
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Jogos',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              dadosPerfil[0].toString(),
                                              style: TextStyle(
                                                color: AppColors.PrimaryMidBlue,
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        buildSeperator(),
                                        Column(
                                          children: [
                                            Text(
                                              'Certas',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              dadosPerfil[1].toString(),
                                              style: TextStyle(
                                                color: AppColors.PrimaryMidBlue,
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        buildSeperator(),
                                        Column(
                                          children: [
                                            Text(
                                              'Erradas',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              dadosPerfil[2].toString(),
                                              style: TextStyle(
                                                color: AppColors.PrimaryMidBlue,
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text:
                                            "Perc. Acerto: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(color: AppColors.PrimaryDarkBlue),
                                            children: [
                                              TextSpan(
                                                text: "${double.parse((dadosPerfil[3]).toStringAsFixed(1))}%",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(color: AppColors.Orange),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110,
                              right: 20,
                              child: Icon(
                                MdiIcons.accountSettings,
                                color: Colors.grey[700],
                                size: 30,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/avatar.png',
                                    width: innerWidth * 0.45,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.35,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Pontos Totais',
                            style: TextStyle(
                              color: AppColors.PrimaryMidBlue,
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                            color: AppColors.Orange,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [PieChart(
                              dataMap: dataMap,
                              animationDuration: Duration(milliseconds: 800),
                              chartLegendSpacing: 32,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              colorList: <Color>[
                                Colors.amberAccent,
                                AppColors.PrimaryLight,
                                Colors.green,
                              ],
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 32,
                              centerText: (dataMap["Clássico"] +
                                      dataMap["Morte Súbita"] +
                                      dataMap["Contra Relógio"])
                                  .toInt()
                                  .toString(),
                              legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: true,
                                decimalPlaces: 1,
                              ),
                            ),]
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildSeperator(){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Container(
        height: 50,
        width: 3,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(100),
          color: AppColors.Orange,
        ),
      ),
    );
  }
}
