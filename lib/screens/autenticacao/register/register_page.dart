import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';
import 'package:ubiquous_quizz_builder/controllers/services_bloc.dart';
import 'package:ubiquous_quizz_builder/data/data_source.dart';
import 'package:ubiquous_quizz_builder/screens/autenticacao/login/login_page.dart';
import 'package:ubiquous_quizz_builder/widgets/ProgressWidget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isApiCallProcess = false;
  bool sucesso = false;

  DataSource dataSource = DataSource();

  String _username, _email;
  Digest _password, _confirmPassword;

  var snackBar = SnackBar(content: Text(""));

  Future<bool> register() async {
    setState(() {
      isApiCallProcess = true;
    });
    if (_confirmPassword == _password) {
      try {
        final responseJson = await Provider.of<Services>(context, listen: false)
            .register(_username, _email, _password.toString());

        print(responseJson);

        if (responseJson['result'] == 0) {
          await Provider.of<Services>(context, listen: false)
              .fetchData("utilizadores");
          setState(() {
            isApiCallProcess = false;
          });
          return true;
        } else {
          snackBar = SnackBar(content: Text("Falha no registo da conta"));
          setState(() {
            isApiCallProcess = false;
          });
          return false;
        }
      } catch (e) {
        print(
            "----------\nProblema na ligação ao servidor: ${e
                .toString()} \nVerifique se tem o caminho correto para o servidor no ficheiro: Common.dart\n----------");
      }
    } else {
      snackBar = SnackBar(
          content: Text("Falha no registo da conta: Passwords diferentes"));
      setState(() {
        isApiCallProcess = false;
      });
      return false;
    }

    snackBar = SnackBar(
        content: Text("Falha no registo da conta: Verifique a sua ligação à internet"));

    setState(() {
      isApiCallProcess = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return ProgressHUD(
      child: _registerUISetup(context),
      inAsyncCall: isApiCallProcess,
    );
  }

  Widget _registerUISetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.PrimaryLight,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
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
                        SizedBox(height: 25),
                        Text(
                          "Registar",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline3
                              .merge(TextStyle(color: AppColors.SecondaryMid)),
                        ),
                        SizedBox(height: 20),
                        _buildUsernameField(),
                        SizedBox(height: 20),
                        _buildEmailField(),
                        SizedBox(height: 20),
                        _buildPasswordFieldFirst(),
                        SizedBox(height: 20),
                        _buildPasswordFieldSecond(),
                        SizedBox(height: 30),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 50),
                          onPressed: () {
                            if (validateAndSave()) {
                              register().then((registResult) {
                                if (registResult) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  Get.off(() => LoginScreen(), arguments: true);
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
                            "Registar",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          color: Theme
                              .of(context)
                              .accentColor,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: GestureDetector(
                              onTap: () =>
                              {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreen()))
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Já tem uma conta?",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.SecondaryLight),
                                    ),
                                    TextSpan(
                                        text: " Entre aqui",
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
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordFieldFirst() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (input) =>
      {
        //Encrypting password
        _password = sha1.convert(utf8.encode(input))
      },
      validator: (input) => _validarPassword(input),
      obscureText: hidePassword,
      decoration: new InputDecoration(
        hintText: "Palavra-chave",
        hintStyle: TextStyle(color: Theme
            .of(context)
            .accentColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme
                .of(context)
                .accentColor)),
        prefixIcon: Icon(
          Icons.lock,
          color: Theme
              .of(context)
              .accentColor,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
          color: Theme
              .of(context)
              .accentColor,
          icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }

  Widget _buildPasswordFieldSecond() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (input) =>
      {
        //Encrypting password
        _confirmPassword = sha1.convert(utf8.encode(input))
      },
      validator: (input) => _validarPassword(input),
      obscureText: hideConfirmPassword,
      decoration: new InputDecoration(
        hintText: "Confirme a palavra-chave",
        hintStyle: TextStyle(color: Theme
            .of(context)
            .accentColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme
                .of(context)
                .accentColor)),
        prefixIcon: Icon(
          Icons.lock,
          color: Theme
              .of(context)
              .accentColor,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hideConfirmPassword = !hideConfirmPassword;
            });
          },
          color: Theme
              .of(context)
              .accentColor,
          icon: Icon(
              hideConfirmPassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => _username = input,
      validator: _validarUsername,
      decoration: new InputDecoration(
        hintText: "Nome de utilizador",
        hintStyle: TextStyle(color: Theme
            .of(context)
            .accentColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme
                .of(context)
                .accentColor)),
        prefixIcon: Icon(
          Icons.person,
          color: Theme
              .of(context)
              .accentColor,
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => _email = input,
      validator: (input) => _validarEmail(input),
      decoration: new InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(color: Theme
            .of(context)
            .accentColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme
                .of(context)
                .accentColor)),
        prefixIcon: Icon(
          MdiIcons.email,
          color: Theme
              .of(context)
              .accentColor,
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

  String _validarEmail(String value) {
    if (value.length == 0) {
      return "Email em falta";
    } else if (!EmailValidator.validate(value)) {
      return "Formato do email inválido";
    }
    return null;
  }

  String _validarPassword(String value) {
    if (value.length == 0) {
      return "Password em falta";
    } else if (value.length < 6) {
      return "Password tem que contem pelo menos 6 caracteres";
    }
    return null;
  }
}
