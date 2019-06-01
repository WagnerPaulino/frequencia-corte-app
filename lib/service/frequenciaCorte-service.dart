import '../model/frequencia-corte.dart';

class FrequenciaCorteService {

  FrequenciaCorte calcular(FrequenciaCorte frequencia) {
    if (frequencia.capacitor != null || frequencia.resistor != null) {
      frequencia.resultado =
          1 / 2 * frequencia.pi * frequencia.resistor * frequencia.capacitor;
    }
    return frequencia;
  }
}
