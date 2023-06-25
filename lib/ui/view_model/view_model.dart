import 'package:flutter/material.dart';
import 'package:movieapp/data/models/bitcoin_model.dart';
import 'package:movieapp/domain/repo_interface/iget_bitcion_repo.dart';
import 'package:movieapp/domain/usecase/get_bitcoin_usecase.dart';
import '../../../di/di.dart';
import '../../application/core/result.dart';
import '../../application/core/usecases/usecase.dart';
import '../../application/network/error_handler/error_handler.dart';
import '../../common/logger/log.dart';

enum Loader { none, loading, fail, success, loading2, empty }

class ViewModel extends ChangeNotifier {
  late IGetBitcoinRepo bitcoinRepo;
  BitcoinModel? _bitcoinModel;

  BitcoinModel? get bitcoinModel => _bitcoinModel;
  Loader _loader = Loader.none;
  Loader get getLoader => _loader;
  set getLoader(Loader value) {
    _loader = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ViewModel() {
    bitcoinRepo = inject<IGetBitcoinRepo>();
  }

  Future<void> getBitcoin() async {
    getLoader = Loader.loading;
    final _getBitcion = GetBitcoinCaseUse(bitcoinRepo);
    final getBitcion = await _getBitcion(NoParams());
    getBitcion.fold((error) {
      d(ErrorMessage.fromError(error));
      getLoader = Loader.fail;
      return;
    }, (response) {
      getLoader = Loader.success;
      _bitcoinModel = response;

      notifyListeners();
      return;
    });
  }
}
