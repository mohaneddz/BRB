import 'package:pedometer/pedometer.dart';
import 'dart:async';

class StepsService {
  void Function()? onUpdate;
  late Stream<StepCount> _stepCountStream;
  StreamSubscription<StepCount>? _stepCountSub;
  int? _initialSteps;
  int? _currentSteps;
  String steps = '0';
  String status = 'Initializing...';
  Timer? pedometerTimeoutTimer;
  DateTime? lastStepUpdate;

  StepsService({this.onUpdate});

  void start() {
    _stepCountSub?.cancel();
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountSub = _stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
    );
    status = 'Pedometer stream started';
    pedometerTimeoutTimer = Timer(const Duration(seconds: 10), () {
      if (steps == '0') {
        status = 'No step events received. Check permissions or try moving.';
        onUpdate?.call();
      }
    });
  }

  void _onStepCount(StepCount event) {
    pedometerTimeoutTimer?.cancel();
    _currentSteps = event.steps;
    _initialSteps ??= event.steps;
    steps = (_currentSteps! - (_initialSteps ?? 0)).toString();
    lastStepUpdate = DateTime.now();
    status = 'StepCount event received';
    onUpdate?.call();
  }

  void _onStepCountError(error) {
    status = 'StepCount error: $error';
    steps = 'Step Count not available';
    onUpdate?.call();
  }

  void resetSteps() {
    _initialSteps = _currentSteps;
    steps = '0';
    onUpdate?.call();
  }

  void dispose() {
    pedometerTimeoutTimer?.cancel();
    _stepCountSub?.cancel();
  }
}
