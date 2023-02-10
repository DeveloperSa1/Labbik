import 'package:flutter/material.dart';

enum ProfileType { Icon, Image, Button }

class ProfileUI extends StatelessWidget {
  final ProfileType dummyType;
  final bool isNetwork;
  final double scale;
  final String? image;
  final Color? color;
  final IconData? icon;
  ProfileUI(
      {Key? key,
      required this.dummyType,
      required this.scale,
      required this.color,
      this.icon,
      this.image, required this.isNetwork})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: ClipOval(
            child: this.dummyType == ProfileType.Icon
                ? Icon(Icons.person, color: Colors.white, size: 30 * scale)
                : isNetwork ? Image(
                    fit: (scale == 1.2) ? BoxFit.cover : BoxFit.contain,
                    image: NetworkImage(
                      image!,
                    ),
                  ) : Image(
                    fit: (scale == 1.2) ? BoxFit.cover : BoxFit.contain,
                    image: AssetImage(
                      image!,
                    ),
                  )
                  ));
  }
}
