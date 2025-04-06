import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class ReviewBox extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final List<int> starCounts;

  const ReviewBox({
    super.key,
    this.averageRating=4.5,
    this.totalReviews = 1000,
    this.starCounts=const[900, 200, 50, 30, 20]
  }); // 5,4,3,2,1 stars count

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Average Rating & Stars
            Row(
              children: [
                Text(
                  averageRating.toStringAsFixed(1),
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(Icons.star,
                            color: index < averageRating ? Colors.orange : Colors.grey),
                      ),
                    ),
                    Text("$totalReviews reviews",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Bar Chart
            Expanded(
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(
                    show: false
                  ),
                  // barTouchData: BarTouchData(),
                  gridData: FlGridData(
                    show: false
                  ),
                  barGroups: List.generate(5, (index) {
                    return BarChartGroupData(
                      x: 5 - index,
                      barRods: [
                        BarChartRodData(
                          toY: starCounts[index].toDouble(),
                          color: Colors.orange,
                          width: 18,
                          borderRadius: BorderRadius.circular(4),
                        )
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text("${value.toInt()} ★",
                              style: TextStyle(fontWeight: FontWeight.bold));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
