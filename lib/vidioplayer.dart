import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late List<VideoPlayerController> _controller=[];

  late Future<void> _initializeVideoPlayerFuture;

  List<String> url=['https://propertystop.com/media/property-images/15/videos/Video.mp4',
    'https://propertystop.com/media/property-images/15/videos/Video.mp4',
    'https://propertystop.com/media/property-images/15/videos/Video.mp4'];


  addurl()
  {
    for (var element in url) { _controller.add(VideoPlayerController.network(
      element,
    ));}

   asd();

  }
  asd()
  {
    for (int i=0;i<int.parse(url.length.toString());i++) {_initializeVideoPlayerFuture= _controller[i].initialize();}
  }

  @override
  void initState() {
    super.initState();
    addurl();

  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerCo

    for (int i=0;i<int.parse(url.length.toString());i++) { _controller[i].dispose();}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return ListView.builder(
              itemCount: url.length,
              itemBuilder: (BuildContext context, int index){

              return AspectRatio(
                aspectRatio: (_controller[index].value.aspectRatio),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap:(){
                        if (_controller[index].value.isPlaying) {
                          _controller[index].pause();
                        } else {
                          // If the video is paused, play it.
                          _controller[index].play();
                        }
                      },
                      child: VideoPlayer(_controller[index])),
                ),


                );},
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Wrap the play or pause in a call to `setState`. This ensures the
      //     // correct icon is shown.
      //     setState(() {
      //       // If the video is playing, pause it.
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         // If the video is paused, play it.
      //         _controller.play();
      //       }
      //     });
      //   },
      //   // Display the correct icon depending on the state of the player.
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}