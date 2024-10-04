import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool autoLeading;
  final bool showImage;
  final ImageProvider? imageProvider;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.autoLeading = true,
    this.showImage = false,
    this.imageProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: autoLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : leading,
      title: Row(
        children: [
          if (showImage && imageProvider != null)
            CircleAvatar(
              backgroundImage: imageProvider,
              radius: 20,
            ),
          const SizedBox(width: 8), // Space between image and title
          Text(title),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
