import 'package:chewie/chewie.dart';
import 'package:labbaik/imports.dart';
import 'package:labbaik/shared/constant/texts.dart';
import 'package:labbaik/shared/widget/appLoading.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class StudentVideos extends StatefulWidget {
  const StudentVideos({super.key});

  @override
  State<StudentVideos> createState() => _StudentVideosState();
}

class _StudentVideosState extends State<StudentVideos> {
  @override
  Widget build(BuildContext context) {
    return ChildVideo();
  }
}

class ChildVideo extends StatefulWidget {
  const ChildVideo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChildVideo createState() => _ChildVideo();
}

class _ChildVideo extends State<ChildVideo> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        6,
        (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: ChewieDemo(),
            ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 90.h,
          child: PageView.builder(
            controller: controller,
            // itemCount: pages.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
        ),
        SmoothPageIndicator(
          textDirection: TextDirection.ltr,
          controller: controller,
          count: pages.length,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              width: 32,
              height: 12,
              color: Colors.indigo,
              rotationAngle: 180,
              verticalOffset: -10,
              borderRadius: BorderRadius.circular(24),
              dotBorder: const DotBorder(
                padding: 2,
                width: 2,
                color: Colors.indigo,
              ),
            ),
            dotDecoration: const DotDecoration(
              width: 24,
              height: 12,
              color: Colors.grey,
              dotBorder: DotBorder(
                padding: 2,
                width: 2,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(2)),
              // borderRadius: BorderRadius.circular(16),
              verticalOffset: 0,
            ),
            spacing: 6.0,
            activeColorOverride: (i) => colors[i],
            inActiveColorOverride: (i) => colors[i],
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}

const colors = [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key? key,
    this.title = 'Chewie Demo',
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  List<String> srcs = [
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(srcs[currPlayIndex]);
    _videoPlayerController2 =
        VideoPlayerController.network(srcs[currPlayIndex]);
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: false,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
      // subtitle: Subtitles(subtitles),
      // subtitleBuilder: (context, dynamic subtitle) => Container(
      //   padding: const EdgeInsets.all(10.0),
      //   child: subtitle is InlineSpan
      //       ? RichText(
      //           text: subtitle,
      //         )
      //       : Text(
      //           subtitle.toString(),
      //           style: const TextStyle(color: Colors.black),
      //         ),
      // ),

      // hideControlsTimer: const Duration(seconds: 1),

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex += 1;
    if (currPlayIndex >= srcs.length) {
      currPlayIndex = 0;
    }
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? Chewie(
            controller: _chewieController!,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLoading(),
              SizedBox(height: 20),
              Text(
                ' يتم تحميل الفيديو',
                style: blueText,
              ),
            ],
          );
  }
}
