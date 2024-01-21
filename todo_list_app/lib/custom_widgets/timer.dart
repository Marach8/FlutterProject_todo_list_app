import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/circle_avatar.dart';
import 'package:todo_list_app/functions/extensions.dart';

class CountDownTimerView extends StatelessWidget {
  const CountDownTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(
        const Duration(seconds: 1), 
        (time) => 9 - time
      ).take(10), 
      builder: (_, snapshot) => CircleAvatarWidget(
        child: snapshot.hasData ? 
        Center(
          child: Text('${snapshot.data!}')
            .decoratewithGoogleFont(
              redColor, 
              fontSize2, 
              fontWeight4
            ),
        ) : const Text('')
      )
    );
  }
}