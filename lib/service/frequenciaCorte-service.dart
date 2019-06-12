import 'package:calculo/enums/niveis.dart';

import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class FrequenciaCorteService {
  FrequenciaCorte calcular(FrequenciaCorte frequencia, Nivel escolha) {
    double x = 0;
    if (escolha == Nivel.ALTA) {
      frequencia = this.frequenciaPassaAlta(frequencia);
    } else if (escolha == Nivel.BAIXA) {
      frequencia = this.frequenciaPassaBaixa(frequencia);
    }
    return frequencia;
  }

  FrequenciaCorte frequenciaPassaAlta(FrequenciaCorte frequencia) {
    double x = 0;
    if (frequencia.capacitor != null &&
        frequencia.resistor != null &&
        frequencia.resistor2 != null) {
      x = frequencia.resistor * frequencia.resistor2;
      frequencia.frequencia =
          1 / (2 * frequencia.pi * frequencia.capacitor * math.sqrt(x));
    } else {
      frequencia.frequencia = 0;
    }
    return frequencia;
  }

  FrequenciaCorte frequenciaPassaBaixa(FrequenciaCorte frequencia) {
    double r = 0;
    double c = 0;
    double x = 0;
    if (frequencia.resistor != null &&
        frequencia.capacitor != null &&
        frequencia.capacitor2 != null) {
      r = frequencia.resistor;
      c = frequencia.capacitor * frequencia.capacitor2;
      frequencia.frequencia = 1 / (2 * frequencia.pi * r * math.sqrt(c));
    } else {
      frequencia.frequencia = 0;
    }
    return frequencia;
  }
}
