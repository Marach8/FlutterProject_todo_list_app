import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/functions/extensions.dart';

class ContainerWithText extends StatelessWidget {
  final String title, content;
  final int index;

  const ContainerWithText({
    required this.title, 
    required this.content,
    required this.index,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: screenwidth/6,
        width: screenwidth/3,
        decoration: BoxDecoration(
          color: backGroundColor,
          border: Border.all(
            color: customGreenColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: blackColor,
                child: Center(
                  child: Text('$index')
                    .decorate(
                      blueColor, 
                      fontSize2, 
                      fontWeight3
                    )
                )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: backGroundColor,
                border: Border.all(
                  color: blueColor,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title).decorate(
                        whiteColor, 
                        fontSize2,
                        fontWeight3
                      ),
                      Text(content).decorate(
                        darkWhiteColor, 
                        fontSize2,
                        fontWeight3
                      ),
                    ],
                  ),
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}