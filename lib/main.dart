import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'config/theme/theme.dart';
import 'module/home/presentation/page/home_page.dart';
import 'module/todo_list/logic/todo_list_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    Get.put(TodoListController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}
