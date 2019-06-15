import 'package:calculo/model/amplificacao.dart';

class AmplificacaoService {
  Amplificacao ganho(Amplificacao apl) {
    apl.ganho = (49400 / apl.resistor) + 1;
    return apl;
  }

  Amplificacao resistor(Amplificacao apl) {
    apl.resistor = 49400 / (apl.ganho - 1);
    return apl;
  }
}
