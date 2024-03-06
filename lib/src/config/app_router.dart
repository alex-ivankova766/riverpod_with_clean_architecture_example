import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/postcard/data/repositories/user_data_repository_impl.dart';
import '../features/postcard/presentation/postcard.dart';
import '../features/postcard/presentation/questionnaire.dart';

class AppRouter {
  AppRouter(this.userProvider);
  final UserDataRepositoryImpl userProvider;

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'postcard',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const PostCard();
        },
      ),
      GoRoute(
        name: 'questionnaire',
        path: '/questionnaire',
        builder: (BuildContext context, GoRouterState state) {
          return const Questionnaire();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final postcardLocation = state.namedLocation('postcard');
      final questionnaireLocation = state.namedLocation('questionnaire');

      final bool isUserFilled = userProvider.user != null &&
          userProvider.user?.name.value != '' &&
          userProvider.user?.birthDate != null;
      final isPostCard = state.matchedLocation == postcardLocation;
      final isQuestionnaire = state.matchedLocation == questionnaireLocation;
      if (isQuestionnaire && isUserFilled) {
        return '/';
      }
      if (isPostCard && !isUserFilled) {
        return '/questionnaire';
      }
      return null;
    },
    refreshListenable: userProvider,
  );
}
