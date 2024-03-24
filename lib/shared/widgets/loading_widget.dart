// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final ValueListenable<bool> valueListenable;
  const LoadingWidget({
    Key? key,
    required this.valueListenable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, value, _) {
        return Visibility(
            visible: value,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey.withOpacity(0.5),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ));
      },
    );
  }
}
