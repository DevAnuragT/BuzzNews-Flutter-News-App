import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GeminiLoading extends StatelessWidget {
  final int num;
  GeminiLoading(this.num);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white70.withOpacity(0.4),
      ),
      margin: EdgeInsets.all(10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(num, (index) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white70
            ),
            width: double.infinity,
            height: 10,
            margin: EdgeInsets.all(10),
          ),
          )
        ),
      ),
    );
  }
}
