import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gridbound_galaxy/services/enemies_datasource_initializer.dart';
import 'package:gridbound_galaxy/services/levels_datasource.dart';

import 'services/logging_service.dart';
import 'services/towers_datasource.dart';

Future<ProviderContainer> initializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ProviderContainer container = ProviderContainer(observers: [CustomX()]);
  await container.read(enemiesDatasourceInitializerProvider.future);
  await container.read(towersDatasourceInitializerProvider.future);
  await container.read(levelsDatasourceInitializerProvider.future);
  return container;
}
