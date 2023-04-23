import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'button_list.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Timer App',
      home: MyHomePage(),
    );
  }
}

final countdownTimerControllerProvider = StateProvider((ref) => CountDownController());

/// 0: not running
/// 1: running
/// 2: paused
final countdownTimerControllerIsRunningProvider = StateProvider((ref) => 0);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(countdownTimerControllerProvider);

    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      String twoDigitMilliSeconds = twoDigits(duration.inMilliseconds.remainder(100));
      return "$twoDigitMinutes:$twoDigitSeconds:$twoDigitMilliSeconds";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer App'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularCountDownTimer(
                autoStart: false,
                duration: 3,
                initialDuration: 0,
                controller: controller,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                ringColor: Colors.red.shade300,
                fillColor: Colors.grey.shade300,
                backgroundColor: Colors.white,
                strokeWidth: 15.0,
                isReverse: false,
                isReverseAnimation: true,
                textStyle: const TextStyle(
                  fontSize: 33.0,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
                textFormat: CountdownTextFormat.MM_SS,
                onComplete: () {
                  ref.read(countdownTimerControllerIsRunningProvider.notifier).state = 0;
                },
                timeFormatterFunction: (_, duration) {
                  if(duration.inMilliseconds == 0){
                    return "00:00:00";
                  } else {
                    return _printDuration(duration);
                  }
                }
              ),
              const ButtonList(),
            ],
          ),
        ),
      ),
    );
  }
}