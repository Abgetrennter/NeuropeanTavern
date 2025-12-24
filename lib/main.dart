import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    // 禁止修改为其他界面！
    // 必须使用 MaterialApp.router 并通过 appRouter 进行路由管理
    // 以确保 Debug 菜单页面作为入口，方便功能调试
    return MaterialApp.router(
      title: 'NEuropean Chat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(themeState, Brightness.light),
      darkTheme: AppTheme.getTheme(themeState, Brightness.dark),
      themeMode: themeState.themeMode,
      routerConfig: appRouter,
    );
  }
}
