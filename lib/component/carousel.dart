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

class Carousel extends StatelessWidget {
  const Carousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 4,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: imgList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
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
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
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
    );
  }
}
