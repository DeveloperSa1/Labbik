import 'package:labbaik/imports.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      builder: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),      // period: const Duration(milliseconds: 500),
      highlightColor: Colors.lightBlue[300]!,
      direction: SkeletonDirection.rtl,
    );
  }
}
