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
    x = frequencia.resistor * frequencia.resistor2;
    frequencia.frequencia =
        1 / (2 * frequencia.pi * frequencia.capacitor * math.sqrt(x));
    return frequencia;
  }

  FrequenciaCorte frequenciaPassaBaixa(FrequenciaCorte frequencia) {
    double r = 0;
    double c = 0;
    double x = 0;
    r = frequencia.resistor;
    c = frequencia.capacitor * frequencia.capacitor2;
    frequencia.frequencia = 1 / (2 * frequencia.pi * r * math.sqrt(c));
    return frequencia;
  }
}
