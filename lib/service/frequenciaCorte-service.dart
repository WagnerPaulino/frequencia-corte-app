import 'package:calculo/enums/niveis.dart';

import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class FrequenciaCorteService {
  FrequenciaCorte calcular(FrequenciaCorte frequencia, Nivel escolha) {
    double x = 0;
    if (escolha == Nivel.PADRAO) {
      frequencia = this.frequenciaGeral(frequencia);
    } else if (escolha == Nivel.ALTA) {
      frequencia = this.frequenciaPassaAlta(frequencia);
    } else if (escolha == Nivel.BAIXA) {
      frequencia = this.frequenciaPassaBaixa(frequencia);
    }
    return frequencia;
  }

  FrequenciaCorte frequenciaGeral(FrequenciaCorte frequencia) {
    double x = 0;
    if (frequencia.capacitor2 == null || frequencia.resistor2 == null) {
      x = frequencia.capacitor * frequencia.resistor;
      frequencia.frequencia = 1 / (2 * frequencia.pi * math.sqrt(x));
    } else {
      x = frequencia.capacitor *
          frequencia.resistor *
          frequencia.capacitor2 *
          frequencia.resistor2;
      frequencia.frequencia = 1 / (2 * frequencia.pi * math.sqrt(x));
    }
    return frequencia;
  }

  FrequenciaCorte frequenciaPassaAlta(FrequenciaCorte frequencia) {
    double r = 0;
    double c = 0;
    double x = 0;
    if (frequencia.capacitor2 == null || frequencia.resistor2 == null) {
      x = frequencia.capacitor * frequencia.resistor;
      frequencia.frequencia = 1 / (2 * frequencia.pi * math.sqrt(x));
    } else {
      r = frequencia.resistor * frequencia.resistor2;
      c = frequencia.capacitor * frequencia.capacitor2;
      frequencia.frequencia = 1 / (2 * frequencia.pi * c * math.sqrt(r));
    }
    return frequencia;
  }

  FrequenciaCorte frequenciaPassaBaixa(FrequenciaCorte frequencia) {
    double r = 0;
    double c = 0;
    double x = 0;
    if (frequencia.capacitor2 == null || frequencia.resistor2 == null) {
      x = frequencia.capacitor * frequencia.resistor;
      frequencia.frequencia = 1 / (2 * frequencia.pi * math.sqrt(x));
    } else {
      r = frequencia.resistor * frequencia.resistor2;
      c = frequencia.capacitor * frequencia.capacitor2;
      frequencia.frequencia = 1 / (2 * frequencia.pi * r * math.sqrt(c));
    }
    return frequencia;
  }
}
