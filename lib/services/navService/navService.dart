import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


import 'INavigationService.dart';

class NavigationService implements INavigationService {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  @override
  Future<dynamic>? pushNamed(String path, {Object? object}) {
    return _key.currentState?.pushNamed(path, arguments: object);
  }

  @override
  Future<dynamic>? pushNamedAndRemoveUntil(String path, {Object? object}) {
    return _key.currentState?.pushNamedAndRemoveUntil(path, (route) => false, arguments: object);
  }

  @override
  Future<dynamic>? pushReplacementNamed(String path, {Object? object}) {
    return _key.currentState?.pushReplacementNamed(path, arguments: object);
  }

  @override
  GlobalKey<NavigatorState> key() => _key;

  @override
  Future<bool?> pop([Object? result]) async {
    return await _key.currentState?.maybePop(result);
  }

  @override
  Future<bool?> showNAVDialog(String title, String content,String image,{bool dismissOnly = false}) async {
    return await showDialog<bool>(
      context: _key.currentContext!,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: AlertDialog(

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Center(
              child: Lottie.asset(
                image,
                width: 80,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
            content: Text(
              content,
              style: TextStyle(fontSize: 14),
            ),
            actions: dismissOnly
                ? <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                      child: TextButton(
                        child:  Text('Done', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                        onPressed: () {
                          _key.currentState?.pop(true); // Dismiss alert dialog
                        },
                      ),
                    ),
                  ]
                : <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () async {
                        await pop(false); // Dismiss alert dialog
                      },
                    ),
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () async {
                        await pop(true); // Dismiss alert dialog
                      },
                    ),
                  ],
          ),
        );
      },
    );
  }

  @override
  Future<void> showLoadingDialog() async {
    return await showDialog<void>(
      context: _key.currentContext!,
      builder: (BuildContext dialogContext) {
        return const AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Future<void> showCustomDialog(Widget child) async {
    return await showDialog<void>(
      context: _key.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return child;
      },
    );
  }
}
