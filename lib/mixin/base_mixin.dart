




import '../di/di.dart';
import '../services/navService/INavigationService.dart';

mixin BaseMixin {
  final INavigationService _navigator = inject<INavigationService>();


  INavigationService get routeNavigator => _navigator;
}
