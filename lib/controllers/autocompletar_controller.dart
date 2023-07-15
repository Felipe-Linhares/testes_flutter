import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varios_testes/models/autocompletar_models.dart';

class AutoCompletarController extends GetxController {
  RxList<AutoCompletarModel> listaPreenchida = <AutoCompletarModel>[].obs;

  RxList<AutoCompletarModel> resultadoPesquisa = <AutoCompletarModel>[].obs;

  realizarPesquisa(String query) {
    if (query.isNotEmpty) {
      resultadoPesquisa.value = listaPreenchida
          .where(
            (listaPreenchida) =>
                listaPreenchida.name.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                listaPreenchida.imageUrl.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
          )
          .toList();
    } else {
      resultadoPesquisa.clear();
    }
  }

  selecionarResultado(
      String result, TextEditingController textEditingController) {
    textEditingController.text = result;
    resultadoPesquisa.clear();
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
