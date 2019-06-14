import 'package:calculo/enums/niveis.dart';

import '../model/frequencia-corte.dart';
import 'dart:math' as math;

class CapacitorService {
  FrequenciaCorte calcular(FrequenciaCorte frequencia, Nivel escolha) {
    if (escolha == Nivel.ALTA) {
      frequencia = this.capacitorPassaAlta(frequencia);
    } else {
      frequencia = this.capacitorPassaBaixa(frequencia);
    }
    return frequencia;
  }

  FrequenciaCorte capacitorPassaAlta(FrequenciaCorte frequencia) {
    double resultado = 0;
    resultado = 1 /
        (2 *
            math.pi *
            frequencia.frequencia *
            math.sqrt(frequencia.resistor * frequencia.resistor2));
    frequencia.capacitor = resultado;
    return frequencia;
  }

  FrequenciaCorte capacitorPassaBaixa(FrequenciaCorte frequencia) {
    double resultado = 0;
    resultado = 1 /
        (2 *
            math.pi *
            frequencia.frequencia *
            math.sqrt(frequencia.capacitor * frequencia.capacitor2));
    frequencia.resistor = resultado;
    return frequencia;
  }
}
