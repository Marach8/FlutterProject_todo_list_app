import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/circle_avatar.dart';
import 'package:todo_list_app/functions/extensions.dart';

class CountDownTimerView extends StatelessWidget {
  final int duration;
  final Color color;
  const CountDownTimerView({
    super.key,
    required this.color,
    required this.duration
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(
        const Duration(seconds: 1), 
        (time) => duration - time
      ).take(duration + 1), 
      builder: (_, snapshot) => CircleAvatarWidget(
        child: snapshot.hasData ? 
        Center(
          child: Text('${snapshot.data!}')
            .decoratewithGoogleFont(
              color, 
              fontSize2, 
              fontWeight2
            ),
        ) : const Text('')
      )
    );
  }
}