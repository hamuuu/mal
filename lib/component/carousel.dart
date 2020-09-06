import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mal/component/text_stroke.dart';

class CarouselImage {
  final String description;
  final String image;

  const CarouselImage({
    @required this.image,
    @required this.description,
  });
}

final List<CarouselImage> imgList = [
  CarouselImage(
    image: '1.png',
    description: 'Pengumuman Anime Guild Award Tahun 2019',
  ),
  CarouselImage(
    image: '2.png',
    description: 'Pengumuman Anime Guild Award Tahun 2018',
  ),
  CarouselImage(
    image: '3.png',
    description: 'Recap Kodansha Comic Pada Anime Expo 2019',
  ),
  CarouselImage(
    image: '4.jpeg',
    description: 'Pengumuman Series Terbaru Serial Love Live!',
  ),
  CarouselImage(
    image: '5.jpg',
    description: 'Anime Movie Terbaik Jepang Tahun 2019',
  ),
];

class Carousel extends StatefulWidget {
  const Carousel({
    Key key,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            height: MediaQuery.of(context).size.height * 0.25,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
          items: imgList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: double.infinity,
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: TextStroke(
                        description: i.description,
                        size: 14,
                        strokeColor: Colors.black,
                        strokeWidth: 0.6,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/carousel/${i.image}'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
