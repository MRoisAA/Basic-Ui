import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:basic_ui/planet_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> planets = [
    {
      'planetName': 'Mercury',
      'nickName': 'sunrunner',
      'imagepath': 'mercury.png',
      'temperature': '167',
      'distanceToEarth': '0.00001582 light years',
      'satellitesSent': 2,
      'surfaceArea': '7.48:10^7 km',
      'rotationPeriod': 58.6,
      'averageOrbitalSpeed': '47.48 km/s',
    },
    {
      'planetName': 'Venus',
      'nickName': 'Goddess',
      'imagepath': 'venus.png',
      'temperature': '464',
      'distanceToEarth': '0.0001134 light years',
      'satellitesSent': 42,
      'surfaceArea': '7.48:10^7 km',
      'rotationPeriod': 243,
      'averageOrbitalSpeed': '35.02 km/s',
    },
    {
      'planetName': 'Earth',
      'nickName': 'Home',
      'imagepath': 'earth.png',
      'temperature': '15',
      'distanceToEarth': '0 light years',
      'satellitesSent': 'MANY 9over 2,000 active',
      'surfaceArea': '7.48:10^7 km',
      'rotationPeriod': 1,
      'averageOrbitalSpeed': '29.78 km/s',
    },
    {
      'planetName': 'Mars',
      'nickName': 'Neighbor',
      'imagepath': 'mars.png',
      'temperature': '-65',
      'distanceToEarth': '0.00022228 light years',
      'satellitesSent': 50,
      'surfaceArea': '7.48:10^7 km',
      'rotationPeriod': 1.03,
      'averageOrbitalSpeed': '24.07 km/s',
    },
    {
      'planetName': 'Jupiter',
      'nickName': 'Giant',
      'imagepath': 'jupiter.png',
      'temperature': '-108',
      'distanceToEarth': '0.00008236 light years',
      'satellitesSent': 9,
      'surfaceArea': '7.48:10^7 km',
      'rotationPeriod': 0.41,
      'averageOrbitalSpeed': '13.07 km/s',
    },
    {
      'planetName': 'Saturn',
      'nickName': 'Rings',
      'imagepath': 'saturn.png',
      'temperature': '-139',
      'distanceToEarth': '0.00015056 light years',
      'satellitesSent': 4,
      'surfaceArea': '7.48:10^7 km',
      'rotationPeriod': 0.45,
      'averageOrbitalSpeed': '9.69 km/s',
    },
    {
      'planetName': 'Uranus',
      'nickName': 'Tilted',
      'imagepath': 'uranus.png',
      'temperature': '-195',
      'distanceToEarth': '0.0002544 light years',
      'satellitesSent': 1,
      'surfaceArea': '7.48:10^7 km',
      'rotationPeriod': 0.72,
      'averageOrbitalSpeed': '6.81 km/s',
    },
    {
      'planetName': 'Neptune',
      'nickName': 'Blue',
      'imagepath': 'neptune.png',
      'temperature': '-201',
      'distanceToEarth': '0.000402 light years',
      'satellitesSent': 1,
      'surfaceArea': '7.48:10^7 km',
      'rotationPeriod': 0.67,
      'averageOrbitalSpeed': '5.43 km/s',
    },
  ];

  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      int newIndex = _controller.page?.round() ?? 0;
      if (newIndex != _currentIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: height * 0.06,
            left: width * 0.04,
            right: width * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "Welcome\n",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    children: [
                      TextSpan(
                        text: "rois",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      "assets/images/rois.jpg",
                      height: height * 0.075,
                      width: width * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: height * 0.3,
            child: SizedBox(
              width: width,
              height: height,
              child: PageView.builder(
                controller: _controller,
                itemCount: planets.length,
                itemBuilder: (context, index) {
                  return PlanetContainer(
                      title: planets[index]['planetName'],
                      nickname: planets[index]['nickname'],
                      image_path: planets[index]['imagePath'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PlanetDetailPage(planet: planets[index]),
                          ),
                        );
                      });
                },
              ),
            ),
          ),
          Positioned(
            top: height * 0.2,
            child: RepaintBoundary(
              child: CustomPaint(
                size: Size(width, 50),
                painter: CurvedLineWithDotsPainter(
                    numDots: planets.length, currentIndex: _currentIndex),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PlanetContainer extends StatefulWidget {
  final String image_path;
  final String title;
  final String nickname;
  final Function() onTap;
  const PlanetContainer(
      {super.key,
      required this.image_path,
      required this.title,
      required this.nickname,
      required this.onTap});

  @override
  State<PlanetContainer> createState() => _palanetContainerState();
}

class _palanetContainerState extends State<PlanetContainer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Text(
              widget.title.toUpperCase(),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CurvedLineWithDotsPainter extends CustomPainter {
  final int numDots;
  final int currentIndex;
  final double padding = 20.0;
  CurvedLineWithDotsPainter(
      {required this.numDots, required this.currentIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    //dashed path
    final path = Path()
      ..moveTo(0, size.height * 1.2)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height * 1.2);

    final dashPath = _createDashedPath(path);

    canvas.drawPath(dashPath, paint);

    //draw
    for (int i = 0; i < numDots; i++) {
      double t = i / (numDots - 1);
      Offset position = _getPositionAlongCurve(t, size);

      //membuat
      final ShadowPaint = Paint()
        ..color = (i == currentIndex) ? Colors.white : Colors.grey[300]!
        ..style = PaintingStyle.fill;

      final dotPaint = Paint()
        ..color = (i == currentIndex) ? Colors.white : Colors.grey[300]!
        ..style = PaintingStyle.fill;

      double dotSize = (i == currentIndex) ? 8 : 5;
      double shadowSize = (i == currentIndex) ? 6 : 0;

      canvas.drawCircle(position, dotSize + shadowSize, ShadowPaint);

      canvas.drawCircle(position, dotSize, dotPaint);
    }
  }

  Path _createDashedPath(Path source) {
    const double dashWidth = 5.0;
    const double dashSpace = 5.0;
    final Path dashedPath = Path();
    double distance = 0.0;

    for (PathMetric measurePath in source.computeMetrics()) {
      while (distance < measurePath.length) {
        const double length = dashWidth + dashSpace;
        final Path extractPath =
            measurePath.extractPath(distance, distance + dashWidth);
        dashedPath.addPath(extractPath, Offset.zero);
        distance += length;
      }
    }
    return dashedPath;
  }

  Offset _getPositionAlongCurve(double t, Size size) {
    double x = size.width * t;
    double y = size.height * 0.6 + (pow((1 - 2 * t), 2) * size.height * 0.48);

    x = x.clamp(padding, size.width - padding);
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant CurvedLineWithDotsPainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex;
  }
}
