import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:movieapp/application/core/failure/failure.dart';
import 'package:movieapp/data/models/bitcoin_model.dart';
import 'package:provider/provider.dart';

import '../../application/core/result.dart';
import '../../mixin/base_mixin.dart';
import '../../presentation/utilis/app_colors.dart';
import '../view_model/view_model.dart';
import 'favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with BaseMixin
    implements Result<BitcoinModel> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        context.read<ViewModel>().getBitcoin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ViewModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Online Trading",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: viewModel.getLoader == Loader.loading
            ? const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: LoadingIndicator(
                      indicatorType: Indicator.lineScale,
                      colors: [AppColors.mainSkin],
                      strokeWidth: 50,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.black),
                ),
              )
            : viewModel.bitcoinModel!.data!.isEmpty
                ? const Center(child: Text("No Coins Yet"))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.bitcoinModel!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final bitcoin = viewModel.bitcoinModel!.data![index];
                      return AnimationConfiguration.staggeredList(
                        position: 0,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          horizontalOffset: -300,
                          verticalOffset: -850,
                          child: InkWell(
                            onTap: () {},
                            child: Card(
                              color: AppColors.lightSkin,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                tileColor: AppColors.lightSkin,
                                title: Text(
                                  '${bitcoin.name}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                subtitle: Text(
                                  '${bitcoin.symbol}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                                trailing: Text(
                                    "${double.parse(bitcoin.priceUsd.toString()).toStringAsFixed(2)} \$"),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainSkin,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavoriteScreen(),
            ),
          );
        },
        child: const Icon(Icons.favorite_border),
      ),
    );
  }

  @override
  onError(Failure error) {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  onSuccess(BitcoinModel result) {
    // TODO: implement onSuccess
    throw UnimplementedError();
  }
}
