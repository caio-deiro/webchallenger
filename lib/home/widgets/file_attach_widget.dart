import 'package:flutter/material.dart';

class FileAttachWidget extends StatelessWidget {
  final String fileName;
  final void Function()? onDelete;
  const FileAttachWidget({
    super.key,
    required this.fileName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.attach_file),
            const SizedBox(width: 2),
            Text(
              fileName,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ],
    );
  }
}
