import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapoapplication/controller/banner-controller.dart';
class BannerWiget extends StatefulWidget {
  const BannerWiget({super.key});

  @override
  State<BannerWiget> createState() => _BannerState();
}

class _BannerState extends State<BannerWiget> {

  final CarouselController carouselController = CarouselController();
  final bannerController _bannercontroller = Get.put(bannerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
          (){
            return CarouselSlider(
                items:
                  _bannercontroller.bannerUrls.map((anhUrls) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: anhUrls,
                      fit: BoxFit.cover,
                      width: Get.width - 10,
                      placeholder: (context, url) => ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                      ),

                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                  ).toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  aspectRatio: 2.5,
                  viewportFraction: 1
                ),
            );
          }
      ),
    );
  }
}
