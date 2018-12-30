import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../util/constants.dart';

class TextView extends StatelessWidget {
  final String header;
  final String text;
  final double fontSize;
  final String fontFamily;

  TextView(this.header, this.text, this.fontSize, this.fontFamily);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(
                left: textEdgeInset, top: textEdgeInset, right: textEdgeInset),
            child: Text(
              header,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize * 1.2, fontWeight: FontWeight.w900, fontFamily: fontFamily),
            )),
        Html(
          data: text,
//Optional parameters:
          padding: EdgeInsets.all(textEdgeInset),
          defaultTextStyle: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily
          ),
        ),
      ],
    );
  }
}
