import 'package:flutter/material.dart';
import 'package:ubiquous_quizz_builder/app_colors.dart';

class NewRecordDialog extends StatelessWidget {
  final String title, description, buttonText;

  NewRecordDialog({this.title, this.description, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 60, left: 20, right: 20),
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(5.0, 10.0),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(description, style: TextStyle(fontSize: 16), textAlign: TextAlign.justify,),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(buttonText,style: TextStyle(fontSize: 15, color: AppColors.PrimaryDarkBlue, fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            )),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 30,
              foregroundImage: ExactAssetImage('assets/images/trophy-1-no-bg.png'),
            ))
      ],
    );
  }
}
