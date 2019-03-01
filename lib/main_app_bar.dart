import 'package:flutter/material.dart';
import 'package:app_lucas/layout_type.dart';


class MainAppBar extends AppBar {
  MainAppBar({
    LayoutGroup layoutGroup,
    LayoutType layoutType,
    PreferredSize bottom,
    VoidCallback onLayoutToggle,
  }) : super(
          leading: IconButton(
            icon: Icon(layoutGroup == LayoutGroup.scrollable ? Icons.filter_1 : Icons.filter_2),
            onPressed: onLayoutToggle,
          ),
          title: Text(layoutName(layoutType)),
          elevation: 1.0,
          bottom: bottom,
        );
}
