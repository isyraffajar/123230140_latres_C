import 'package:flutter/material.dart';
import 'screen/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  
  await Hive.openBox<CartItem>('cartBox');
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
