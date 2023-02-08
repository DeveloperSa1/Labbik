import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/constant/colors.dart';
import 'package:labbaik/shared/constant/sized.dart';

class StudentPhotos extends StatefulWidget {
  const StudentPhotos({super.key});

  @override
  State<StudentPhotos> createState() => _StudentPhotosState();
}

class _StudentPhotosState extends State<StudentPhotos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizedH20,
        ...List.generate(
            3,
            (index) =>
                PhotoWidget(img: 'assets\slider-background-${index + 1}.png'))
      ],
    );
  }
}

class PhotoWidget extends StatelessWidget {
  final String img;
  const PhotoWidget({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 32.0,
      ),
      padding: const EdgeInsets.all(14.0),
      height: size.height * 0.40,
      width: size.width,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(width: 8.0),

          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: white),
          ),
          const Spacer(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     _buildPostStat(
          //       context: context,
          //       iconPath: 'assets/icons/favorite_border.svg',
          //       value: '5.2K',
          //     ),
          //     _buildPostStat(
          //       context: context,
          //       iconPath: 'assets/icons/favorite_border.svg',
          //       value: '1.1K',
          //     ),
          //     _buildPostStat(
          //       context: context,
          //       iconPath: 'assets/icons/favorite_border.svg',
          //       value: '5.2K',
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
