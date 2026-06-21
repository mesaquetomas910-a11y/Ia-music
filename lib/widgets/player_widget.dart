import 'package:flutter/material.dart';

class PlayerWidget extends StatefulWidget {
  final String audioPath;
  final String title;

  const PlayerWidget({
    Key? key,
    required this.audioPath,
    required this.title,
  }) : super(key: key);

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.blue,
                  ),
                  onPressed: _togglePlayPause,
                ),
                Expanded(
                  child: Slider(
                    value: currentPosition.inSeconds.toDouble(),
                    max: totalDuration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        currentPosition = Duration(seconds: value.toInt());
                      });
                    },
                  ),
                ),
                Text(
                  _formatDuration(currentPosition),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDuration(totalDuration),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
    // TODO: Implement actual playback
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
