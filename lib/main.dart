import 'package:deeper_riverpod_education/src/features/postcard/domain/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/config/app_router.dart';
import 'src/config/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Clean Redirect App',
      theme: CustomTheme().theme(),
      routerConfig: AppRouter(userData).router,
    );
  }
}
