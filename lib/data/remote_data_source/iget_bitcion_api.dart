



import '../models/bitcoin_model.dart';

abstract class IGetBitcoinApi {
  Future<BitcoinModel> getBitcoin();
}
