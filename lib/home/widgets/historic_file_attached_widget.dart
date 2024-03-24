// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HistoricFileAttachedWidget extends StatelessWidget {
  final String fileName;
  const HistoricFileAttachedWidget({
    Key? key,
    required this.fileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: const Border.fromBorderSide(BorderSide(color: Colors.black)),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(fileName),
          const SizedBox(width: 5),
          const Icon(Icons.delete, color: Colors.red),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_downward, color: Colors.yellow),
        ],
      ),
    );
  }
}
