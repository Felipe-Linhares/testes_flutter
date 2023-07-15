import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varios_testes/controllers/autocompletar_controller.dart';
import 'package:varios_testes/service/autocompletar_service.dart';

class AutoCompletarPage extends StatefulWidget {
  const AutoCompletarPage({super.key});

  @override
  State<AutoCompletarPage> createState() => _AutoCompletarPageState();
}

class _AutoCompletarPageState extends State<AutoCompletarPage> {
  final TextEditingController _procurarPalavra = TextEditingController();

  @override
  void initState() {
    AutoCompletarService().fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _procurarPalavra.dispose();
    super.dispose();
  }

  final AutoCompletarController _autoCompletarController =
      Get.find<AutoCompletarController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Autocomplete Exemplo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => Column(
              children: [
                TextFormField(
                  controller: _procurarPalavra,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      _autoCompletarController.resetarPesquisa();
                    } else {
                      _autoCompletarController.realizarPesquisa(value);
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Procurar',
                      suffix: IconButton(
                          onPressed: () {
                            _procurarPalavra.clear();
                            _autoCompletarController.resetarPesquisa();
                          },
                          icon: const Icon(Icons.delete))),
                ),
                Expanded(
                  child: _autoCompletarController.resultadoPesquisa.isEmpty
                      ? _listViewPesquisaVazia()
                      : _listViewPesquisa(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Caso a pesquisa não seja vazia, retorna um ListView com os dados correspondentes a pesquisa.
  ListView _listViewPesquisa() {
    return ListView.builder(
      itemCount: _autoCompletarController.resultadoPesquisa.length,
      itemBuilder: (context, index) {
        final result = _autoCompletarController.resultadoPesquisa[index];
        return _autoCompletarController.resultadoPesquisa[0].name ==
                'Nenhum resultado encontrado'
            ? ListTile(
                title: Text(result.name),
                subtitle: Text(result.imageUrl),
              )
            : GestureDetector(
                onTap: () {
                  _autoCompletarController.selecionarResultado(
                    result.name,
                    _procurarPalavra,
                  );
                },
                child: ListTile(
                  title: Text(result.name),
                  subtitle: Text(result.imageUrl),
                ),
              );
      },
    );
  }

  /// Se o campo da pesquisa estiver vazia, retorna um ListView sem nenhuma lista de dados.
  ListView _listViewPesquisaVazia() {
    return ListView.builder(
      itemCount: _autoCompletarController.listaPreenchida.length,
      itemBuilder: (context, index) {
        final result = _autoCompletarController.listaPreenchida[index];
        return ListTile(
          title: Text(result.name),
          subtitle: Text(result.imageUrl),
        );
      },
    );
  }
}
