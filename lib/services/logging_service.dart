import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final class CustomX extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    log('context: $context \n value: $value');
    super.didAddProvider(context, value);
  }

  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    log('context :$context \n previous: $previousValue \n new: $newValue ');
    super.didUpdateProvider(context, previousValue, newValue);
  }
}
