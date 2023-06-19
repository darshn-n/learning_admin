// ignore_for_file: depend_on_referenced_packages

import 'package:admin/forms/seller_form_videos_books.dart';
import 'package:admin/providers/product_provider.dart';
import 'package:admin/screens/account_screen.dart';
import 'package:admin/screens/categories/category_list.dart';
import 'package:admin/screens/home_screen.dart';
import 'package:admin/screens/main_screen.dart';
import 'package:admin/screens/product_details_screen.dart';
import 'package:admin/screens/products_by_category.dart';
import 'package:admin/screens/seller/seller_category_list.dart';
import 'package:admin/screens/success_screen.dart';
import 'package:admin/providers/category_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: (_) => CategoryProvider(),
        ),
        ListenableProvider(
          create: (_) => ProductProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      initialRoute: MainScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        CategoryListScreen.id: (context) => const CategoryListScreen(),
        MainScreen.id: (context) => const MainScreen(),
        SellerCategoryListScreen.id: (context) =>
            const SellerCategoryListScreen(),
        SellerFormVideos.id: (context) => const SellerFormVideos(),
        SuccessScreen.id: (context) => const SuccessScreen(),
        ProductDetailsScreen.id: (context) => const ProductDetailsScreen(),
        ProductByCategory.id: (context) => const ProductByCategory(),
        AccountScreen.id: (context) => const AccountScreen(),
      },
    );
  }
}
