import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/autocompletar_controller.dart';
import 'pages/autocompletar_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => AutoCompletarController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: AutoCompletarPage());
  }
}
