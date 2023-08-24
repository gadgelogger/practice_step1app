import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:step1/view/sub_page.dart';
import 'package:step1/view/home_page.dart';

//GoRouterの設定ファイル
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'sub_page',
          builder: (BuildContext context, GoRouterState state) {
            return SubPage(
              state.extra as String,
            );
          },
        ),
      ],
    ),
  ],
);
