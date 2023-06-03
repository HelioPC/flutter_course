import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/auth_or_home_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (context) => ProductList(),
          update: (context, value, previous) {
            return ProductList(
              value.token ?? '',
              value.uid ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (context) => OrderList([], ''),
          update: (context, value, previous) {
            return OrderList(previous?.items ?? [], value.token ?? '');
          },
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              secondary: Colors.deepOrange,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            fontFamily: 'Lato',
            useMaterial3: true,
          ),
          routes: {
            AppRoutes.auth: (context) => const AuthOrHomePage(),
            AppRoutes.productDetail: (context) => const ProductDetailPage(),
            AppRoutes.cart: (context) => const CartPage(),
            AppRoutes.orders: (context) => const OrdersPage(),
            AppRoutes.products: (context) => const ProductsPage(),
            AppRoutes.productForm: (context) => const ProductFormPage(),
          },
        ),
      ),
    );
  }
}
