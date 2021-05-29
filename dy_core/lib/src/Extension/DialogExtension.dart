import '../Utils/Headers/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'StringExtention.dart';

typedef DialogAction = bool Function();

extension Dialog on State<StatefulWidget> {
  /// 屏幕中央
  Future<T> showAlert<T>({
    bool barrierDismissible = true,
    String title,
    String content,
    String cancelTitle,
    String sureTitle,
    DialogAction cancelAction,
    DialogAction sureAction,
  }) {
    if (StringExtension.isEmpty(title) && StringExtension.isEmpty(content)) {
      return null;
    }

    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(fit: StackFit.expand, children: <Widget>[
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
            GestureDetector(onTap: () {
              if (!barrierDismissible ||
                  (StringExtension.isEmpty(cancelTitle) &&
                      StringExtension.isEmpty(sureTitle))) {
                //【允许点击空白】 或 【无cancel和sure按钮】 时
                Navigator.pop(context);
              }
            }),
            _rowOfAlertView(title, content, cancelTitle, sureTitle, () {
              if (cancelAction != null) {
                bool shouldReturn = cancelAction();
                if (shouldReturn) Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            }, () {
              if (sureAction != null) {
                bool shouldReturn = sureAction();
                if (shouldReturn) Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            }),
          ]);
        });
  }

  ///底部弹出
  Future<T> showActionSheet<T>(
      {String cancelTitle,
      String sureTitle,
      CrossAxisAlignment alignment = CrossAxisAlignment.center,
      List<Widget> children,
      DialogAction cancelAction,
      DialogAction sureAction}) {
    List<Widget> list = List();
    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getCupertinoButtonOfActionSheet(cancelTitle, DY102ThemeColor, () {
          if (cancelAction != null) {
            bool shouldReturn = cancelAction();
            if (shouldReturn) Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        }),
        _getCupertinoButtonOfActionSheet(sureTitle, DYRedThemeColor, () {
          if (sureAction != null) {
            bool shouldReturn = sureAction();
            if (shouldReturn) Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        }),
      ],
    ));
    list.addAll(children);

    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: alignment,
              mainAxisSize: MainAxisSize.min,
              children: list,
            ),
          );
        });
  }

  Widget _getCupertinoButtonOfActionSheet(
      String title, Color color, Function() func) {
    return CupertinoButton(
        minSize: 0,
        borderRadius: BorderRadius.zero,
        padding: EdgeInsets.all(15),
        child: Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
                decoration: TextDecoration.none)),
        onPressed: func);
  }

  Widget _rowOfAlertView(String title, String content, String cancelTitle,
      String sureTitle, Function() cancelAction, Function() sureAction) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 50,
          child: Container(),
        ),
        Expanded(
          flex: 275,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: _widgetsOfColumn(title, content, cancelTitle, sureTitle,
                  cancelAction, sureAction),
            ),
          ),
        ),
        Expanded(
          flex: 50,
          child: Container(),
        ),
      ],
    );
  }

  List<Widget> _widgetsOfColumn(
      String title,
      String content,
      String cancelTitle,
      String sureTitle,
      Function() cancelAction,
      Function() sureAction) {
    List<Widget> widgets = List();

    EdgeInsets titleInset = EdgeInsets.zero;
    EdgeInsets contentInset = EdgeInsets.zero;

    bool titleIsEmpty = StringExtension.isEmpty(title);
    bool contentIsEmpty = StringExtension.isEmpty(content);
    bool cancelTitleIsEmpty = StringExtension.isEmpty(cancelTitle);
    bool sureTitleIsEmpty = StringExtension.isEmpty(sureTitle);

    if (!titleIsEmpty && !contentIsEmpty) {
      titleInset = EdgeInsets.fromLTRB(15, 20, 15, 10);
      contentInset = EdgeInsets.fromLTRB(15, 0, 15, 20);
    } else {
      if (!titleIsEmpty) {
        titleInset = EdgeInsets.fromLTRB(15, 20, 15, 20);
      }
      if (!contentIsEmpty) {
        contentInset = EdgeInsets.fromLTRB(15, 20, 15, 20);
      }
    }

    if (!titleIsEmpty) {
      widgets.add(Container(
        padding: titleInset,
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: DY61ThemeColor,
                decoration: TextDecoration.none)),
      ));
    }

    if (!contentIsEmpty) {
      widgets.add(Container(
        padding: contentInset,
        child: Text(content,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: DY61ThemeColor,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none)),
      ));
    }

    if (!cancelTitleIsEmpty || !sureTitleIsEmpty) {
      List<Widget> widgetsOfRow = List();

      if (!cancelTitleIsEmpty) {
        widgetsOfRow.add(Expanded(
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: DY240ThemeColor),
                        right: BorderSide(width: 1, color: DY240ThemeColor))),
                child: _buttonOfRowOfAlertView(
                    cancelTitle, DY153ThemeColor, cancelAction))));
      }

      if (!sureTitleIsEmpty) {
        widgetsOfRow.add(Expanded(
            child: Container(
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(width: 1, color: DY240ThemeColor))),
          child:
              _buttonOfRowOfAlertView(sureTitle, DYRedThemeColor, sureAction),
        )));
      }

      widgets.add(Row(
        children: widgetsOfRow,
      ));
    }

    return widgets;
  }

  Widget _buttonOfRowOfAlertView(String title, Color color, Function() func) {
    return CupertinoButton(
      borderRadius: BorderRadius.zero,
      padding: EdgeInsets.zero,
      child: Text(title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
              decoration: TextDecoration.none)),
      onPressed: func,
    );
  }
}
