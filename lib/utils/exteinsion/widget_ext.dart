import 'package:flutter/widgets.dart';

///针对Widget的扩展方法
///1.致力于减少层级
extension WidgetExt on Widget {
  ///设置边距
  Padding padding({Key key, EdgeInsetsGeometry padding}) {
    return Padding(key: key, padding: padding, child: this);
  }
  ///设置边距
  Padding paddingTop({Key key, double padding}) {
    return Padding(key: key, padding: EdgeInsets.only(top: padding), child: this);
  }

  ///设置边距
  Padding paddingBottom({Key key, double padding}) {
    return Padding(key: key, padding: EdgeInsets.only(bottom: padding), child: this);
  }

  ///设置边距
  Padding paddingLeft({Key key, double padding}) {
    return Padding(key: key, padding: EdgeInsets.only(left: padding), child: this);
  }

  ///设置边距
  Padding paddingRight({Key key, double padding}) {
    return Padding(key: key, padding: EdgeInsets.only(right: padding), child: this);
  }

  ///铺满
  Expanded expand({Key key, int flex}) {
    return Expanded(key: key, flex: flex, child: this);
  }


  GestureDetector onTap({Key key, GestureTapCallback onTap}) {
    return GestureDetector(child: this, onTap: onTap,);
  }

  ///设置背景和前景色
  DecoratedBox decoration({
    Key key,
    DecorationPosition position = DecorationPosition.background,
    Color color,
    DecorationImage image,
    BoxBorder border,
    BorderRadius borderRadius,
    List<BoxShadow> boxShadow,
    Gradient gradient,
    BlendMode backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return DecoratedBox(
      key: key,
      child: this,
      position: position,
      decoration: BoxDecoration(
          color: color,
          image: image,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          gradient: gradient,
          backgroundBlendMode: backgroundBlendMode,
          shape: shape),
    );
  }

  DecoratedBox background({
    Key key,
    Color color,
    DecorationImage image,
    BoxBorder border,
    BorderRadius borderRadius,
    List<BoxShadow> boxShadow,
    Gradient gradient,
    BlendMode backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return decoration(
        key: key,
        position: DecorationPosition.background,
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        backgroundBlendMode: backgroundBlendMode,
        shape: shape);
  }

  DecoratedBox foreground({
    Key key,
    Color color,
    DecorationImage image,
    BoxBorder border,
    BorderRadius borderRadius,
    List<BoxShadow> boxShadow,
    Gradient gradient,
    BlendMode backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return decoration(
        key: key,
        position: DecorationPosition.foreground,
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        backgroundBlendMode: backgroundBlendMode,
        shape: shape);
  }
}
