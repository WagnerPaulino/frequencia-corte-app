import 'package:calculo/enums/niveis.dart';

import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class ResistorService {
  FrequenciaCorte calcular(FrequenciaCorte c, Nivel escolha) {
    if (escolha == Nivel.ALTA) {
      c = this.resistorPassaAlta(c);
    } else {
      c = this.resistorPassaBaixa(c);
    }
    return c;
  }

  resistorPassaAlta(FrequenciaCorte c) {
    double resultado = 0;
    resultado = 1 / (2 * math.pi * c.capacitor * c.frequencia * math.sqrt(2));
    c.resistor = resultado;
    c.resistor2 = 1.9994 * resultado;
    return c;
  }

  resistorPassaBaixa(FrequenciaCorte c) {
    double resultado = 0;
    resultado = 1 /
        (2 * math.pi * c.resistor * c.frequencia * math.sqrt(2));
    c.capacitor = resultado;
    c.capacitor2 = resultado * 1.9994;
    return c;
  }
}
