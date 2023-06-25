
import 'package:dartz/dartz.dart';
import 'package:movieapp/data/models/bitcoin_model.dart';
import 'package:movieapp/domain/repo_interface/iget_bitcion_repo.dart';

import '../../application/core/failure/failure.dart';
import '../../application/core/usecases/usecase.dart';


class GetBitcoinCaseUse implements UseCase<BitcoinModel, NoParams> {
  GetBitcoinCaseUse(this.repository);

  final IGetBitcoinRepo repository;

  @override
  Future<Either<Failure, BitcoinModel>> call(NoParams params) async =>
      repository.getBitcoin();
}
