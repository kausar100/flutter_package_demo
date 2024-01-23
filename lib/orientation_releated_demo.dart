import 'package:flutter/material.dart';

/// If you’re interested in the orientation of the screen,
/// rather than the amount of space available to the parent,
/// use MediaQuery.of(context).orientation instead of an OrientationBuilder widget.
///
/// To lock in Specific orientation
/// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // SystemChrome.setPreferredOrientations([
//   //   DeviceOrientation.portraitUp,
//   // ]);
//   runApp(const MyApp());
// }

class LayoutRelatedWidget extends StatelessWidget {
  const LayoutRelatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              // GridView.count(
              //   crossAxisCount:
              //   MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
              //   children: List.generate(
              //       10,
              //           (index) => Container(
              //         padding: const EdgeInsets.all(8.0),
              //         margin: const EdgeInsets.all(8.0),
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all()),
              //         child: Center(child: Text('Item $index')),
              //       )),
              //   // ...
              // )
              OrientationBuilder(
        builder: (context, orientation) => GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          children: List.generate(
              10,
              (index) => Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    child: Center(child: Text('Item $index')),
                  )),
          // ...
        ),
      )
          // Text(
          //   'This is Google Fonts',
          //   style: GoogleFonts.inconsolata(
          //     fontSize: 24
          //   ),
          // ),
          ),
    );
  }
}
