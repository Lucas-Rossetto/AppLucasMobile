import 'package:flutter/foundation.dart';

enum LayoutGroup {
  scrollable
}

abstract class HasLayoutGroup {
  LayoutGroup get layoutgroup;
  VoidCallback get onLayoutToggle;
}

enum LayoutType {
  rss,
  todo,
  actuality,
  whatEver,
}

String layoutName(LayoutType layoutType) {
  switch (layoutType) {
    case LayoutType.rss:
      return 'RSS';
    case LayoutType.todo:
      return 'Todo list';
    case LayoutType.actuality:
      return "Fil d'actualité";
    case LayoutType.whatEver:
      return "Peu importe"; 
    default:
      return '';       
  }
} 
