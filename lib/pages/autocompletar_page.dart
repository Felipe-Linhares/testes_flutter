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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    AutoCompletarService().fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final AutoCompletarController _autoCompletarController =
      Get.find<AutoCompletarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocomplete Exemplo'),
      ),
      body: Obx(
        () => Column(
          children: [
            TextFormField(
              controller: _searchController,
              onChanged: _autoCompletarController.realizarPesquisa,
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
            ),
            Expanded(
              child: _autoCompletarController.resultadoPesquisa.isEmpty
                  ? ListView.builder(
                      itemCount:
                          _autoCompletarController.listaPreenchida.length,
                      itemBuilder: (context, index) {
                        final result =
                            _autoCompletarController.listaPreenchida[index];
                        return ListTile(
                          title: Text(result.name),
                          subtitle: Text(result.imageUrl),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount:
                          _autoCompletarController.resultadoPesquisa.length,
                      itemBuilder: (context, index) {
                        final result =
                            _autoCompletarController.resultadoPesquisa[index];
                        return GestureDetector(
                          onTap: () {
                            _autoCompletarController.selecionarResultado(
                              result.name,
                              _searchController,
                            );
                          },
                          child: ListTile(
                            title: Text(result.name),
                            subtitle: Text(result.imageUrl),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
