import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:step1/screens/webview.dart';
import 'package:step1/screens/home.dart';

//GoRouterの設定ファイル
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'subpage',
          builder: (BuildContext context, GoRouterState state) {
            return SubPage(state.extra as String);
          },
        ),
      ],
    ),
  ],
);
