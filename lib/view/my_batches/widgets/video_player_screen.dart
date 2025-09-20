// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   final String youtubeUrl;

//   const VideoPlayerScreen({Key? key, required this.youtubeUrl})
//     : super(key: key);

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();

//     final videoId = YoutubePlayerController.convertUrlToId(widget.youtubeUrl);

//     _controller = YoutubePlayerController.fromVideoId(
//       videoId: videoId ?? "",
//       autoPlay: true,
//       params: const YoutubePlayerParams(showFullscreenButton: true),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerScaffold(
//       controller: _controller,
//       builder: (context, player) {
//         return Scaffold(
//           appBar: AppBar(title: const Text("Play Video")),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(child: player),
//                 SamplePlayer(),
//                 NetworkVideoPlayer(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class SamplePlayer extends StatefulWidget {
//   @override
//   _SamplePlayerState createState() => _SamplePlayerState();
// }

// class _SamplePlayerState extends State<SamplePlayer> {
//   late FlickManager flickManager;
//   bool _isInitialized = false;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }

//   Future<void> _initializePlayer() async {
//     try {
//       final videoPlayerController = VideoPlayerController.asset(
//         'assets/videos/video.mp4',
//       );

//       // Wait for the video to initialize
//       await videoPlayerController.initialize();

//       flickManager = FlickManager(videoPlayerController: videoPlayerController);

//       if (mounted) {
//         setState(() {
//           _isInitialized = true;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _error = 'Failed to load video: ${e.toString()}';
//         });
//       }
//       print('Video initialization error: $e');
//     }
//   }

//   @override
//   void dispose() {
//     if (_isInitialized) {
//       flickManager.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_error != null) {
//       return Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 48, color: Colors.red),
//             SizedBox(height: 16),
//             Text(
//               _error!,
//               style: TextStyle(color: Colors.red),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _error = null;
//                   _isInitialized = false;
//                 });
//                 _initializePlayer();
//               },
//               child: Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (!_isInitialized) {
//       return Container(
//         height: 200,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 16),
//               Text('Loading video...'),
//             ],
//           ),
//         ),
//       );
//     }

//     return Container(
//       child: FlickVideoPlayer(
//         flickManager: flickManager,
//         flickVideoWithControls: FlickVideoWithControls(
//           controls: FlickPortraitControls(),
//         ),
//       ),
//     );
//   }
// }

// class NetworkVideoPlayer extends StatefulWidget {
//   @override
//   _NetworkVideoPlayerState createState() => _NetworkVideoPlayerState();
// }

// class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
//   late FlickManager flickManager;
//   bool _isInitialized = false;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }

//   Future<void> _initializePlayer() async {
//     try {
//       // Test with a sample video URL
//       final videoPlayerController = VideoPlayerController.network(
//         'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
//       );

//       // Wait for the video to initialize
//       await videoPlayerController.initialize();

//       flickManager = FlickManager(
//         videoPlayerController: videoPlayerController,
//         autoPlay: true, // Auto-play the video
//       );

//       if (mounted) {
//         setState(() {
//           _isInitialized = true;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _error = 'Failed to load video: ${e.toString()}';
//         });
//       }
//       print('Video initialization error: $e');
//     }
//   }

//   @override
//   void dispose() {
//     if (_isInitialized) {
//       flickManager.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Video Player Test')),
//       body: Container(child: _buildVideoPlayer()),
//     );
//   }

//   Widget _buildVideoPlayer() {
//     if (_error != null) {
//       return Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 48, color: Colors.red),
//             SizedBox(height: 16),
//             Text(
//               _error!,
//               style: TextStyle(color: Colors.red),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _error = null;
//                   _isInitialized = false;
//                 });
//                 _initializePlayer();
//               },
//               child: Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (!_isInitialized) {
//       return Container(
//         height: 200,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 16),
//               Text('Loading video...'),
//             ],
//           ),
//         ),
//       );
//     }

//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: FlickVideoPlayer(
//         flickManager: flickManager,
//         flickVideoWithControls: FlickVideoWithControls(
//           controls: FlickPortraitControls(),
//         ),
//       ),
//     );
//   }
// }
import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/view/my_batches/widgets/AlternativeVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyleCustom.headingStyle(
            fontSize: 18,
            color: AppColors.blackColor,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
      body: const _LiveClassBody(),
    );
  }
}

class _LiveClassBody extends StatefulWidget {
  const _LiveClassBody();

  @override
  State<_LiveClassBody> createState() => _LiveClassBodyState();
}

class _LiveClassBodyState extends State<_LiveClassBody> {
  final List<_Comment> _comments = [
    _Comment(
      author: 'Rahul',
      timeAgo: '1 hour ago',
      text: 'Welcome everyone! Excited for today\'s session.',
      likes: 32,
      replies: 3,
    ),
    _Comment(
      author: 'Anjali',
      timeAgo: '45 minutes ago',
      text: 'Please share today\'s notes after class 🙏',
      likes: 18,
      replies: 1,
    ),
    _Comment(
      author: 'Vikash',
      timeAgo: '10 minutes ago',
      text: 'Can you explain refraction again with another example?',
      likes: 6,
      replies: 0,
    ),
  ];

  // Local comment interactions
  void _addTempComment(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _comments.insert(
        0,
        _Comment(
          author: 'You',
          timeAgo: 'just now',
          text: text,
          likes: 0,
          replies: 0,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [_buildVideoPlayer(), Expanded(child: _buildComments())],
        ),
        Positioned(bottom: 0, left: 0, right: 0, child: _buildActions()),
      ],
    );
  }

  Widget _buildVideoPlayer() {
    return Stack(
      children: [
        // Placeholder gradient frame for modern look; actual player below in separate widget
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor.withOpacity(0.25),
                AppColors.primaryColor.withOpacity(0.05),
              ],
            ),
          ),
        ),
        AlternativeVideoPlayer(
          youtubeUrl: "https://www.youtube.com/watch?v=0LawAwK5OaI",
        ),
        // Positioned(
        //   top: 12,
        //   right: 12,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        //     decoration: BoxDecoration(
        //       color: Colors.redAccent,
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //     child: Text(
        //       'LIVE',
        //       style: TextStyleCustom.normalStyle(
        //         fontSize: 12,
        //         color: AppColors.whiteColor,
        //         fontFamily: FontFamily.semiBold,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildComments() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_comments.length} comments',
                  style: TextStyleCustom.headingStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sort, size: 18),
                  label: const Text('Sort by'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          // Add comment input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: _InlineCommentField(onSubmit: _addTempComment)),
              ],
            ),
          ),
          const Divider(height: 1),
          // Comments list
          Expanded(
            child: ListView.separated(
              itemCount: _comments.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder:
                  (context, index) => _buildCommentTile(_comments[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentTile(_Comment c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            child: Text(
              c.author.isNotEmpty ? c.author[0].toUpperCase() : '?',
              style: TextStyleCustom.normalStyle(
                fontSize: 12,
                color: AppColors.primaryColor,
                fontFamily: FontFamily.semiBold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        c.author,
                        style: TextStyleCustom.normalStyle(
                          fontSize: 13,
                          color: AppColors.blackColor,
                          fontFamily: FontFamily.semiBold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '• ${c.timeAgo}',
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.clr606060,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  c.text,
                  style: TextStyleCustom.normalStyle(
                    fontSize: 13,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _iconAction(
                      icon:
                          c.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color:
                          c.isLiked
                              ? AppColors.primaryColor
                              : AppColors.clr606060,
                      onTap: () {
                        setState(() {
                          c.toggleLike();
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${c.likes}',
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.clr606060,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _iconAction(
                      icon:
                          c.isDisliked
                              ? Icons.thumb_down
                              : Icons.thumb_down_outlined,
                      color:
                          c.isDisliked
                              ? AppColors.primaryColor
                              : AppColors.clr606060,
                      onTap: () {
                        setState(() {
                          c.toggleDislike();
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Reply'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.blackColor,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ],
                ),
                if (c.replies > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      'View ${c.replies} replies',
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontFamily: FontFamily.semiBold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: AppColors.clr606060, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _iconAction({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Widget _buildActions() {
    return SafeArea(
      top: false,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionIcon(
                icon: Icons.call_end_rounded,
                color: Colors.redAccent,
                onTap: () => Navigator.of(context).pop(),
              ),
              _actionIcon(
                icon: Icons.pan_tool_alt_outlined,
                color: AppColors.primaryColor,
              ),
              _actionIcon(
                icon: Icons.volume_off_outlined,
                color: AppColors.primaryColor,
                onTap: () {},
              ),
              _actionIcon(icon: Icons.more_horiz, color: AppColors.clr606060),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionIcon({
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ink(
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: IconButton(onPressed: onTap, icon: Icon(icon, color: color)),
        ),
      ],
    );
  }
}

// Separated widget to keep video implementation clean
class _NetworkVideoPlayer extends StatefulWidget {
  const _NetworkVideoPlayer();

  @override
  State<_NetworkVideoPlayer> createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<_NetworkVideoPlayer> {
  VideoPlayerController? _vpController;
  YoutubePlayerController? _ytController;
  bool _initialized = false;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    const String url = "https://youtu.be/2t9BCOeWAyI?si=fs5QNg-92lRJmkJn";
    final String? ytId = _extractYouTubeId(url);

    if (ytId != null) {
      _ytController = YoutubePlayerController(
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          mute: false,
          loop: false,
          enableCaption: true,
        ),
      );
      _ytController!.loadVideoById(videoId: ytId);
      _ytController!.playVideo();
      setState(() {
        _initialized = true;
        _playing = true;
      });
    } else {
      _vpController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _vpController!.initialize();
      setState(() {
        _initialized = true;
      });
      await _vpController!.play();
      setState(() {
        _playing = true;
      });
    }
  }

  @override
  void dispose() {
    _vpController?.dispose();
    _ytController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_ytController != null) {
      return YoutubePlayer(
        controller: _ytController!,
        enableFullScreenOnVerticalDrag: true,
      );
    }
    return GestureDetector(
      onTap: () async {
        if (_playing) {
          await _vpController!.pause();
        } else {
          await _vpController!.play();
        }
        setState(() => _playing = !_playing);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: _vpController!.value.aspectRatio,
            child: VideoPlayer(_vpController!),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _playing ? Icons.pause_circle_filled : Icons.play_circle_fill,
                  size: 52,
                  color: Colors.white.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineCommentField extends StatefulWidget {
  const _InlineCommentField({required this.onSubmit});

  final Function(String text) onSubmit;

  @override
  State<_InlineCommentField> createState() => _InlineCommentFieldState();
}

class _InlineCommentFieldState extends State<_InlineCommentField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.clrD6D6D6.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: TextStyleCustom.normalStyle(
                  fontSize: 13,
                  color: AppColors.clr606060,
                ),
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: _submit,
            ),
          ),
          IconButton(
            onPressed: () => _submit(_controller.text),
            icon: Icon(Icons.send, size: 18, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }

  void _submit(String value) {
    widget.onSubmit(value);
    _controller.clear();
  }
}

class _Comment {
  _Comment({
    required this.author,
    required this.timeAgo,
    required this.text,
    required this.likes,
    required this.replies,
  });

  final String author;
  final String timeAgo;
  final String text;
  int likes;
  final int replies;
  bool isLiked = false;
  bool isDisliked = false;

  void toggleLike() {
    if (isLiked) {
      likes = (likes - 1).clamp(0, 1000000);
    } else {
      likes += 1;
      if (isDisliked) isDisliked = false;
    }
    isLiked = !isLiked;
  }

  void toggleDislike() {
    if (isLiked) {
      isLiked = false;
      likes = (likes - 1).clamp(0, 1000000);
    }
    isDisliked = !isDisliked;
  }
}

String? _extractYouTubeId(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return null;
  if (uri.host.contains('youtu.be')) {
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
  }
  if (uri.host.contains('youtube.com')) {
    if (uri.pathSegments.contains('watch')) {
      return uri.queryParameters['v'];
    }
    if (uri.pathSegments.contains('embed') && uri.pathSegments.length >= 2) {
      return uri.pathSegments[1];
    }
  }
  return null;
}
