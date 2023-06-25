


import 'package:dartz/dartz.dart';
import 'package:movieapp/data/models/bitcoin_model.dart';
import 'package:movieapp/data/remote_data_source/iget_bitcion_api.dart';

import '../../application/core/exception/exception.dart';
import '../../application/core/failure/failure.dart';
import '../../application/network/error_handler/error_handler.dart';
import '../../domain/repo_interface/iget_bitcion_repo.dart';

class GetBitcoinRepo implements IGetBitcoinRepo {
  GetBitcoinRepo({required this.api});
  IGetBitcoinApi api;

  @override
  Future<Either<Failure, BitcoinModel>> getBitcoin() async {
    try {
      final result = await api.getBitcoin();
      return Right(result);
    } catch (error) {
      if (error is Exception) {
        return Left(getFailure(error));
      } else {
        return Left(getFailure(DefaultException(msg: error.toString())));
      }
    }
  }
}
