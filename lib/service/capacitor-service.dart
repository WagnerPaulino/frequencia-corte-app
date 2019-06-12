import 'package:calculo/enums/niveis.dart';

import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class CapacitorService {
  FrequenciaCorte calcular(FrequenciaCorte frequencia, Nivel escolha) {
    if (escolha == Nivel.ALTA) {
      frequencia = this.capacitorPassaBaixa(frequencia);
    } else {
      frequencia = this.capacitorPassaBaixa(frequencia);
    }
    return frequencia;
  }

  FrequenciaCorte capacitorPassaAlta(FrequenciaCorte frequencia) {
    double resultado = 0;
    if (frequencia.frequencia != null &&
        frequencia.resistor != null &&
        frequencia.resistor2 != null) {
      resultado = 1 /
          (2 *
              math.pi *
              frequencia.frequencia *
              math.sqrt(frequencia.resistor * frequencia.resistor2));
    } else {
      resultado = 0;
    }
    frequencia.capacitor = resultado;
    return frequencia;
  }

  FrequenciaCorte capacitorPassaBaixa(FrequenciaCorte frequencia) {
    double resultado = 0;
    if (frequencia.frequencia != null &&
        frequencia.resistor != null &&
        frequencia.resistor2 != null) {
      resultado = 1 /
          (2 *
              math.pi *
              frequencia.frequencia *
              frequencia.resistor *
              math.sqrt(2));
    } else {
      resultado = 0;  
    }
    frequencia.capacitor = resultado;
    frequencia.capacitor2 = resultado * 1.9994;
    return frequencia;
  }
}
