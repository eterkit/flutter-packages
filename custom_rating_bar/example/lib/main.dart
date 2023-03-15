import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Rating Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16)
            .copyWith(top: MediaQuery.of(context).padding.top + 16),
        children: [
          _buildDivider('Half icons'),
          RatingBar(
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            onRatingChanged: (value) => debugPrint('$value'),
            initialRating: 3,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 16),
          _buildDivider('Custom colors'),
          const RatingBar.readOnly(
            isHalfAllowed: true,
            alignment: Alignment.center,
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            emptyColor: Colors.redAccent,
            filledColor: Colors.greenAccent,
            halfFilledColor: Colors.amberAccent,
            halfFilledIcon: Icons.star_half,
            initialRating: 3.5,
            maxRating: 7,
          ),
          const SizedBox(height: 16),
          _buildDivider('Custom icons'),
          const RatingBar.readOnly(
            isHalfAllowed: true,
            alignment: Alignment.center,
            filledIcon: Icons.wb_sunny,
            halfFilledIcon: Icons.wb_cloudy,
            emptyIcon: Icons.ac_unit,
            emptyColor: Colors.blue,
            halfFilledColor: Colors.grey,
            initialRating: 4,
          ),
          const SizedBox(height: 16),
          _buildDivider('Vertical'),
          const RatingBar.readOnly(
            direction: Axis.vertical,
            isHalfAllowed: true,
            alignment: Alignment.center,
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            initialRating: 2,
            maxRating: 3,
            halfFilledIcon: Icons.star_half,
          ),
          const SizedBox(height: 16),
          _buildDivider('Aligned left'),
          const RatingBar.readOnly(
            isHalfAllowed: true,
            filledIcon: Icons.face,
            filledColor: Colors.greenAccent,
            halfFilledColor: Colors.amberAccent,
            emptyIcon: Icons.face,
            initialRating: 3.5,
            halfFilledIcon: Icons.face,
          ),
          const SizedBox(height: 16),
          _buildDivider('Aligned right'),
          const RatingBar.readOnly(
            isHalfAllowed: true,
            alignment: Alignment.centerRight,
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            filledColor: Colors.greenAccent,
            halfFilledColor: Colors.greenAccent,
            initialRating: 3.5,
            halfFilledIcon: Icons.star_half,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(String text) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Divider(
              color: Colors.grey[400],
              height: 48,
              thickness: 1,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Divider(
              color: Colors.grey[350],
              height: 32,
              thickness: 1,
            ),
          ),
        ],
      );
}
