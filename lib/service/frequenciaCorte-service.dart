import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class FrequenciaCorteService {

  FrequenciaCorte calcular(FrequenciaCorte frequencia) {
    double sum = 0.0;
    if (frequencia.capacitor != null || frequencia.resistor != null) {
      sum += frequencia.capacitor * frequencia.resistor;
    }
    if (frequencia.capacitor2 != null || frequencia.resistor2 != null) {
      sum += frequencia.capacitor2 * frequencia.resistor2;
    }
    frequencia.resultado = 1 / (2 * frequencia.pi * math.sqrt(sum));
    return frequencia;
  }
}
