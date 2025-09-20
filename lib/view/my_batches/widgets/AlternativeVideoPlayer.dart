import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:video_player/video_player.dart';

class AlternativeVideoPlayer extends StatefulWidget {
  final String youtubeUrl;
  
  const AlternativeVideoPlayer({
    Key? key,
    required this.youtubeUrl,
  }) : super(key: key);

  @override
  State<AlternativeVideoPlayer> createState() => _AlternativeVideoPlayerState();
}

class _AlternativeVideoPlayerState extends State<AlternativeVideoPlayer> {
  late WebViewController _webViewController;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final String? videoId = _extractYouTubeId(widget.youtubeUrl);
    
    if (videoId == null) {
      setState(() {
        _error = "Invalid YouTube URL";
        _isLoading = false;
      });
      return;
    }
    
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading status
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _error = null;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
              _error = "Failed to load video";
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://www.youtube.com/embed/$videoId?autoplay=0&controls=1&rel=0&showinfo=0&modestbranding=1'),
      );
  }

  String? _extractYouTubeId(String url) {
    // Multiple regex patterns to handle different YouTube URL formats
    final List<RegExp> patterns = [
      RegExp(r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([a-zA-Z0-9_-]{11})'),
      RegExp(r'youtube\.com\/watch\?.*v=([a-zA-Z0-9_-]{11})'),
      RegExp(r'youtu\.be\/([a-zA-Z0-9_-]{11})'),
    ];
    
    for (final pattern in patterns) {
      final match = pattern.firstMatch(url);
      if (match != null && match.group(1) != null) {
        return match.group(1);
      }
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Container(
        height: 200,
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                "This video is unavailable",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Error code: 15",
                style: TextStyle(color: Colors.grey[400]),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                  _initializeWebView();
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 200,
      color: Colors.black,
      child: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    "Loading video...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}