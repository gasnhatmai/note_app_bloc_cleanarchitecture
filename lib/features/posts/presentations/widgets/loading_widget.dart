
import 'package:flutter/material.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(18.0),
      child: Center(
       child: SizedBox(
         height: 30,
         width: 30,
         child: CircularProgressIndicator(),
       ),
      ),
    );
  }
}
