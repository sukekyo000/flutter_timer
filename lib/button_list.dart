
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class ButtonList extends ConsumerWidget{
  const ButtonList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(countdownTimerControllerProvider);
    final runningState = ref.watch(countdownTimerControllerIsRunningProvider);

    if(runningState == 0){
      return InkWell(
        onTap: () {
          controller.start();
          ref.read(countdownTimerControllerIsRunningProvider.notifier).state = 1;
        },
        child: Icon(
          CupertinoIcons.play_circle,
          size: 50,
          color: Colors.blue.shade300,
        ),
      );
    } else if (runningState == 1) {
      return InkWell(
        onTap: () {
          controller.pause();
          ref.read(countdownTimerControllerIsRunningProvider.notifier).state = 2;
        },
        child: Icon(
          CupertinoIcons.pause_circle,
          size: 50,
          color: Colors.blue.shade300,
        ),
      );
    } else if (runningState == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              controller.reset();
              ref.read(countdownTimerControllerIsRunningProvider.notifier).state = 0;
            },
            child: Icon(
              CupertinoIcons.stop_circle,
              size: 50,
              color: Colors.blue.shade300,
            ),
          ),
          InkWell(
            onTap: () {
              controller.resume();
              ref.read(countdownTimerControllerIsRunningProvider.notifier).state = 1;
            },
            child: Icon(
              CupertinoIcons.play_circle,
              size: 50,
              color: Colors.blue.shade300,
            ),
          ),
        ],
      );
    }

    return Container();
  }
}