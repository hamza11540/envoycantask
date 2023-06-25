
import 'package:dartz/dartz.dart';
import 'package:movieapp/data/models/bitcoin_model.dart';

import '../../application/core/failure/failure.dart';

abstract class IGetBitcoinRepo {
  Future<Either<Failure, BitcoinModel>> getBitcoin();
}
