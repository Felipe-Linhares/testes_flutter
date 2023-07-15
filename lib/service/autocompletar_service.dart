import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:varios_testes/controllers/autocompletar_controller.dart';

class AutoCompletarService {
  final AutoCompletarController _autoCompletarController =
      Get.find<AutoCompletarController>();
  void fetchData() async {
    final response = await http.get(
        Uri.parse('https://5aa6be85af352a001477f59c.mockapi.io/api/v1/blogs'));

    if (response.statusCode == 200) {
      _autoCompletarController.guardaDadosServico(response.body);

      // A solicitação foi bem-sucedida
      final responseData = response.body;
      // Faça o processamento dos dados aqui
      log(responseData);
    } else {
      // A solicitação falhou
      log('Erro: ${response.statusCode}');
    }
  }
}
