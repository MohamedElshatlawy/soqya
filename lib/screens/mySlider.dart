import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soqya/models/global.dart';
import 'package:soqya/models/sliderModel.dart';

class HomeSlider extends StatefulWidget {
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<HomeSlider> {
  List<SliderModel> sliders = List();
  bool isLading = true;

  _getSlider() async {
    if (connected) {
      sliders = await fetchSliderData();
      isLading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return isLading
        ? _ladingWidget()
        : sliders.isEmpty
            ? Container(
                height: 200,
                alignment: Alignment.center,
                child: Text("فارغ"),
              )
            : Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                CarouselSlider(
                  items: sliders.map((SliderModel sliderModel) {
                    return InkWell(
                      onTap: () {
                        print(sliderModel.content);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              '$domain/uploads/slider/${sliderModel.name}',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  height: 220,

                  // MediaQuery.of(context).size.height / 3.5,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  // enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ]);
  }

  Widget _ladingWidget() {
    return CarouselSlider(
      items: [
        Container(
            color: Colors.grey.withOpacity(.3),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            color: Colors.grey.withOpacity(.3),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            color: Colors.grey.withOpacity(.3),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
      ],
      height: 220,

      // MediaQuery.of(context).size.height / 3.5,
      aspectRatio: 16 / 9,
      viewportFraction: 1.0,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      pauseAutoPlayOnTouch: Duration(seconds: 10),
      // enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    );
  }
}
