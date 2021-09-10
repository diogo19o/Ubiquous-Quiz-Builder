import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/screens/home/home_page.dart';
import 'package:ubiquous_quizz_builder/screens/autenticacao/register/register_page.dart';
import 'package:ubiquous_quizz_builder/widgets/ProgressWidget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  bool sucesso = false;

  DataSource dataSource = DataSource();

  String _username;
  Digest _password;

  bool fromRegister = Get.arguments;
  var snackBar = SnackBar(content: Text(""));

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  Widget _buildUsernameField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => _username = input,
      validator: _validarUsername,
      decoration: new InputDecoration(
        hintText: "Nome de utilizador",
        hintStyle: TextStyle(color: Theme.of(context).accentColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).accentColor.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor)),
        prefixIcon: Icon(
          Icons.person,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (input) => {
        //Encrypting password
        _password = sha1.convert(utf8.encode(input))
      },
      validator: (input) => _validarPassword(input),
      obscureText: hidePassword,
      decoration: new InputDecoration(
        hintText: "Palavra-chave",
        hintStyle: TextStyle(color: Theme.of(context).accentColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).accentColor.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor)),
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).accentColor,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
          color: Theme.of(context).accentColor,
          icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }

  Future<bool> login() async {
    setState(() {
      isApiCallProcess = true;
    });

    var responseJson;

    try {
      responseJson = await Provider.of<Services>(context, listen: false)
          .login(_username, _password.toString());

      if (responseJson['result'] == 0) {
        Provider.of<Services>(context, listen: false).loadActiveUser(_username);
        print(dataSource.questionarios.length);
        print(dataSource.utilizadores.length);
        await Provider.of<Services>(context, listen: false).fetchData("all");
        print(dataSource.questionarios.length);
        print(dataSource.utilizadores.length);
        setState(() {
          isApiCallProcess = false;
        });
        return true;
      } else if (responseJson['result'] == 3) {
        snackBar = SnackBar(
            content: Text("Conta de admin não tem acesso à aplicação"));
        setState(() {
          isApiCallProcess = false;
        });
        return false;
      } else {
        snackBar =
            SnackBar(content: Text("Falha no login: Credenciais erradas"));
        setState(() {
          isApiCallProcess = false;
        });
        return false;
      }
    } catch (e) {
      print(
          "----------\nProblema na ligação ao servidor: ${e.toString()} \nVerifique se tem o caminho correto para o servidor no ficheiro: Common.dart\n----------");
    }

    snackBar = SnackBar(
        content: Text("Falha no login: Verifique a sua ligação à internet"));

    setState(() {
      isApiCallProcess = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _LoginUISetup(context),
      inAsyncCall: isApiCallProcess,
    );
  }

  Widget _LoginUISetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.PrimaryLight,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 250,
              width: 250,
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(125),
                  border: Border.all(
                    width: 5,
                    color: AppColors.SecondaryLight,
                  ),
                  boxShadow: true
                      ? [
                          BoxShadow(
                            color: AppColors.SecondaryLight,
                            blurRadius: 20,
                          )
                        ]
                      : [],
                  image: DecorationImage(
                      image: ExactAssetImage(
                          "assets/images/logo-ubiquous-quiz-builder.png"),
                      fit: BoxFit.fill)),
            ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 2,
                      color: AppColors.PrimaryLight,
                    ),
                    gradient: AppColors.backgroudFade,
                    color: AppColors.PrimaryDarkBlue,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.PrimaryDarkBlue,
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          "Entrar",
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .merge(TextStyle(color: AppColors.SecondaryMid)),
                        ),
                        SizedBox(height: 20),
                        _buildUsernameField(),
                        SizedBox(height: 20),
                        _buildPasswordField(),
                        SizedBox(height: 30),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 50),
                          onPressed: () {
                            if (validateAndSave()) {
                              login().then((loginResult) {
                                if (loginResult) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  Get.to(() => HomeScreen());
                                } else {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                }
                              });
                            }
                          },
                          child: Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                          child: GestureDetector(
                              onTap: () => {
                                    Get.to(() => RegisterScreen())
                                  },
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Ainda não tem conta?",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.SecondaryLight),
                                    ),
                                    TextSpan(
                                        text: " Registe-se aqui",
                                        style: TextStyle(
                                          color: Colors.lightBlue[200],
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String _validarUsername(String value) {
    if (value.length == 0) {
      return "Nome de utilizador em falta";
    }
    return null;
  }

  String _validarPassword(String value) {
    if (value.length == 0) {
      return "Password em falta";
    }
    return null;
  }
}
