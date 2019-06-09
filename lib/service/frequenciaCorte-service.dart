import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class FrequenciaCorteService {
  FrequenciaCorte calcular(FrequenciaCorte frequencia) {
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
}
