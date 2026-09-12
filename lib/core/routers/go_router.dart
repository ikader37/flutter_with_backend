


import 'package:app_test_with_backend/features/login/presentation/pages/loginPage.dart';
import 'package:app_test_with_backend/features/login/presentation/pages/profil_page.dart';
import 'package:app_test_with_backend/features/news/presentation/pages/all_news_page.dart';
import 'package:app_test_with_backend/features/news/presentation/pages/sources_page.dart';
import 'package:app_test_with_backend/features/register/presentation/pages/register_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../features/news/presentation/pages/to_headlines_pages.dart';
import '../../main.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  // redirect: (context,state) async{
  //   final _storage = const FlutterSecureStorage();
  //   if(await _storage.read(key: "token") != null){
  //     return '/headlines';
  //   }
  //   return '/login';
  // },
  routes: [
    GoRoute(
      path: "/",
      name: "home",
      builder: (context, state) =>  MyHomePage(title: "Backend screen"),
    ),

    GoRoute(
        path: "/login",
        name: "login",
        builder: (context, state) =>LoginPage()
    ),
    GoRoute(
        path: "/register",
        name: "register",
        builder: (context, state) =>RegisterPage()
    ),
    GoRoute(
        path: "/headlines",
        name: "headlines",
        builder: (context, state) =>ToHeadlinesPages()
    ),
    GoRoute(
        path: "/all-news",
        name: "all-news",
        builder: (context, state) => AllNewsPage()
    ),
    GoRoute(
        path: "/sources",
        name: "sources",
        builder: (context, state) =>SourcesPage()
    ),
    GoRoute(
        path: "/profil",
        name: "profil",
        builder: (context, state) =>ProfilPage()
    ),
  ],
);