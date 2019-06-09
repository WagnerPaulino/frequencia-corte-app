import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class ResistorService {
  FrequenciaCorte calcular(FrequenciaCorte c) {
    double resultado = 0;
    if (c.capacitor != null && c.frequencia != null) {
      resultado = 1 / (2 * math.pi * c.capacitor * c.frequencia * math.sqrt(2));
    } else {
      c.resistor = 0;
      c.resistor2 = 0;
    }
    c.resistor = resultado;
    c.resistor2 = 1.9994 * resultado;
    return c;
  }
}
