import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:step1/screens/detail.dart';
import 'package:step1/screens/home.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const Detail();
          },
        ),
      ],
    ),
  ],
);