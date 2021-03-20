import 'package:flutter/material.dart';
import 'package:h_order/constants/customColors.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key key,
    Widget leading,
    bool automaticallyImplyLeading = true,
    Widget title,
    List<Widget> actions,
    Widget flexibleSpace,
    Widget bottom,
    double elevation,
    Color shadowColor,
    ShapeBorder shape,
    Color backgroundColor,
    Brightness brightness,
    IconThemeData iconTheme,
    IconThemeData actionsIconTheme,
    TextTheme textTheme,
    bool primary = true,
    bool centerTitle,
    bool excludeHeaderSemantics = false,
    double titleSpacing = NavigationToolbar.kMiddleSpacing,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
    double toolbarHeight,
    double leadingWidth,
  }) : super(
          key: key,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          shadowColor: shadowColor,
          shape: shape,
          backgroundColor: backgroundColor,
          brightness: brightness,
          iconTheme: iconTheme,
          actionsIconTheme: actionsIconTheme,
          textTheme: textTheme,
          primary: primary,
          centerTitle: centerTitle,
          excludeHeaderSemantics: excludeHeaderSemantics,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity,
          bottomOpacity: bottomOpacity,
          toolbarHeight: toolbarHeight,
          leadingWidth: leadingWidth,
        );

  factory CustomAppBar.create({
    String title,
    List<Widget> actions,
    Widget leading,
    Color backgroundColor,
    Color titleColor,
    Color actionColor,
    Widget bottom,
  }) =>
      CustomAppBar(
        backgroundColor: backgroundColor ?? Colors.grey[100],
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            width: 1,
            color: backgroundColor ?? Colors.black12,
          ),
        ),
        iconTheme: IconThemeData(
          color: actionColor ?? Colors.black87,
        ),
        actions: actions,
        leading: leading,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: titleColor ?? Colors.black87,
          ),
        ),
        bottom: bottom,
      );

  factory CustomAppBar.search({
    String title,
    List<Widget> actions,
    Widget leading,
    Color backgroundColor,
    Color titleColor,
    Color actionColor,
    FocusNode focusNode,
    TextEditingController controller,
    Widget bottom,
  }) =>
      CustomAppBar(
        bottom: bottom,
        backgroundColor: backgroundColor ?? Colors.grey[100],
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            width: 1,
            color: focusNode.hasFocus ? Colors.blue[500] : Colors.black87,
          ),
        ),
        iconTheme: IconThemeData(
          color: actionColor ?? Colors.black87,
        ),
        actions: actions,
        leading: leading,
        title: Container(
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색어 입력',
            ),
          ),
        ),
        titleSpacing: 0,
      );

  factory CustomAppBar.info({
    String title,
  }) =>
      CustomAppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      );
}
