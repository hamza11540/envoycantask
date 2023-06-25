
import 'package:dio/dio.dart';

import '../../../application/core/exception/exception.dart';
import '../../../application/network/client/iApService.dart';
import '../../../application/network/error_handler/error_handler.dart';
import '../models/bitcoin_model.dart';
import 'iget_bitcion_api.dart';




class GetBitcoinApi implements IGetBitcoinApi {
  GetBitcoinApi(IApiService api) : dio = api.get();
  Dio dio;

  @override
  Future<BitcoinModel> getBitcoin() async {
    try {
      final responseData = await dio.get(
        "assets",
      );
      return BitcoinModel.fromJson(responseData.data);
    } on DioError catch (e) {
      final exception = getException(e);
      throw exception;
    } catch (e, t) {
      // d(t);
      throw ResponseException(msg: e.toString());
    }
  }
}


