import 'package:flutter/material.dart';

class Utils {
    static Map<int, String> potenciaMap = {
    0: "Und",
    12: "Tera",
    9: "Giga",
    6: "Mega",
    3: "Quilo",
    -3: "Mili",
    -6: "Micro",
    -9: "Nano",
    -12: "Pico"
  };

  static List<DropdownMenuItem<int>> getDropDownMenuItems() {
    List<DropdownMenuItem<int>> items = new List();
    Utils.potenciaMap.forEach((value, label) => {
          items.add(new DropdownMenuItem(value: value, child: new Text(label)))
        });
    return items;
  }
}