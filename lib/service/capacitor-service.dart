import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class CapacitorService {
  FrequenciaCorte calcular(FrequenciaCorte frequencia) {
    double resultado = 0;
    if (frequencia.frequencia != null &&
        frequencia.resistor != null &&
        frequencia.resistor2 != null) {
      resultado = 1 /
          (2 *
              math.pi *
              frequencia.frequencia *
              math.sqrt(frequencia.resistor * frequencia.resistor2));
    }
    frequencia.capacitor = resultado;
    return frequencia;
  }
}
