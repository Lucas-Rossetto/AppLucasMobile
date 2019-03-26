import 'package:flutter/cupertino.dart';

class CacheControl extends WidgetsBindingObserver {
  CacheControl() {
    WidgetsBinding.instance.addObserver(this);
  }

  void _cleanAllCache() {
    // Cleans all cache.
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      new Future.delayed(
         const Duration(minutes: 15),
         _cleanAllCache,
      );
    }
  }
}