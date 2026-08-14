import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Records a short audio clip as alarm evidence, mirroring how
/// camera_utils.dart snaps a photo.
class AudioRecorderService {
  static const _clipDuration = Duration(seconds: 5);

  final AudioRecorder _recorder = AudioRecorder();

  /// Records a fixed-length clip and returns the saved file path, or null
  /// if recording isn't available (no mic, permission revoked mid-flight).
  Future<String?> recordClip() async {
    try {
      if (!await _recorder.hasPermission()) return null;
      final appDir = await getApplicationDocumentsDirectory();
      final path =
          '${appDir.path}/alarm_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(const RecordConfig(), path: path);
      await Future.delayed(_clipDuration);
      final savedPath = await _recorder.stop();
      return savedPath;
    } catch (_) {
      return null;
    } finally {
      await _recorder.dispose();
    }
  }
}
