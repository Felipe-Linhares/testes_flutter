import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varios_testes/models/autocompletar_models.dart';

class AutoCompletarController extends GetxController {
  RxList<AutoCompletarModel> listaPreenchida = <AutoCompletarModel>[].obs;

  RxList<AutoCompletarModel> resultadoPesquisa = <AutoCompletarModel>[].obs;

  void realizarPesquisa(String palavra) {
    if (palavra.isNotEmpty) {
      resultadoPesquisa.value = listaPreenchida
          .where(
            (listaPreenchida) =>
                listaPreenchida.name.toLowerCase().contains(
                      palavra.toLowerCase(),
                    ) ||
                listaPreenchida.imageUrl.toLowerCase().contains(
                      palavra.toLowerCase(),
                    ),
          )
          .toList();

      if (resultadoPesquisa.isEmpty) {
        resultadoPesquisa.value = [
          AutoCompletarModel(name: 'Nenhum resultado encontrado')
        ];
      }
    } else {
      resultadoPesquisa.clear();
    }
  }

  void resetarPesquisa() {
    resultadoPesquisa.assignAll(listaPreenchida);
  }

  void selecionarResultado(
    String result,
    TextEditingController textEditingController,
  ) {
    textEditingController.text = result;
    resultadoPesquisa.assignAll(
      resultadoPesquisa.where((item) => item.name == result).toList(),
    );
  }

  guardaDadosServico(String body) {
    listaPreenchida.clear();

    var jsonServicosPlanos = jsonDecode(body);

    for (Map<String, dynamic> jsonPlano in jsonServicosPlanos) {
      AutoCompletarModel servicoPlano = AutoCompletarModel.fromJson(jsonPlano);

      listaPreenchida.add(servicoPlano);
    }
  }
}
