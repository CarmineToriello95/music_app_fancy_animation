import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/album.dart';
import '../shared_widgets.dart/carousel_dots.dart';
import '../shared_widgets.dart/custom_app_bar.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final Album album;
  AlbumDetailsScreen({@required this.album});
  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController _trackListAnimationController;
  int _currentIndex;
  bool _animatingToTrackListScreen;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController =
        PageController(initialPage: _currentIndex, viewportFraction: 0.85);
    _trackListAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            _animatingToTrackListScreen = !_animatingToTrackListScreen;
          });
        }
      });
    _animatingToTrackListScreen = false;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _trackListAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Hero(
              tag: heroTagAppBar,
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> heroAnimation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                return AnimatedBuilder(
                  animation: heroAnimation,
                  builder: (_, __) {
                    return CustomAppBar(
                      opacityValue: heroAnimation.value,
                      leading: IconButton(
                        icon: CustomBackIconAppBar(),
                        onPressed: () => Navigator.pop(context),
                      ),
                      title: '${widget.album.author} - ${widget.album.title} ',
                    );
                  },
                );
              },
              child: CustomAppBar(
                leading: IconButton(
                  icon: CustomBackIconAppBar(),
                  onPressed: () => Navigator.pop(context),
                ),
                title: '${widget.album.author} - ${widget.album.title} ',
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _triggerTrackListAnimation();
                },
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: heroTagImageSection,
                      flightShuttleBuilder: (
                        BuildContext flightContext,
                        Animation<double> heroAnimation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext,
                      ) {
                        return AnimatedBuilder(
                          animation: heroAnimation,
                          builder: (_, __) {
                            return ImageSectionAnimation(
                              imagePath: widget.album.images[_currentIndex],
                              heroAnimationValue: heroAnimation.value,
                              pageController: _pageController,
                            );
                          },
                        );
                      },
                      child: !_animatingToTrackListScreen
                          ? ImagesCarousel(
                              album: widget.album,
                              currentIndex: _currentIndex,
                              onPageChanged: (index) {
                                setState(
                                  () {
                                    _currentIndex = index;
                                  },
                                );
                              },
                            )
                          : AnimatedBuilder(
                              animation: _trackListAnimationController,
                              builder: (_, __) {
                                return ImageSectionAnimation(
                                  imagePath: widget.album.images[_currentIndex],
                                  showTrackListAnimationValue:
                                      _trackListAnimationController.value,
                                  pageController: _pageController,
                                );
                              },
                            ),
                    ),
                    !_animatingToTrackListScreen
                        ? Column(
                            children: <Widget>[
                              SizedBox(
                                height: 12.0,
                              ),
                              CarouselDots(
                                dotsNumber: widget.album.images.length,
                                activeIndex: _currentIndex,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                            ],
                          )
                        : AnimatedBuilder(
                            animation: _trackListAnimationController,
                            builder: (_, child) => Container(
                              height:
                                  (1 - _trackListAnimationController.value) *
                                      30,
                            ),
                          ),
                    Expanded(
                      flex: 2,
                      child: Hero(
                        tag: heroTagBodySection,
                        flightShuttleBuilder: (
                          BuildContext flightContext,
                          Animation<double> heroAnimation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext,
                        ) {
                          return AnimatedBuilder(
                            animation: heroAnimation,
                            builder: (_, __) {
                              return BodySectionAnimation(
                                trackListAnimationController:
                                    _trackListAnimationController,
                                album: widget.album,
                                heroAnimationValue: heroAnimation.value,
                              );
                            },
                          );
                        },
                        child: AnimatedBuilder(
                          animation: _trackListAnimationController,
                          builder: (_, __) {
                            return BodySectionAnimation(
                              trackListAnimationController:
                                  _trackListAnimationController,
                              album: widget.album,
                              showTrackListAnimationValue:
                                  _trackListAnimationController.value,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _triggerTrackListAnimation() {
    if (_trackListAnimationController.isDismissed) {
      setState(() {
        _animatingToTrackListScreen = true;
      });
      _trackListAnimationController.forward();
    } else if (_trackListAnimationController.isCompleted) {
      _trackListAnimationController.reverse();
    }
  }
}

class ImageSectionAnimation extends StatelessWidget {
  final String imagePath;
  final double heroAnimationValue;
  final double showTrackListAnimationValue;
  final PageController pageController;

  const ImageSectionAnimation({
    this.heroAnimationValue = 1,
    this.showTrackListAnimationValue = 0,
    @required this.imagePath,
    @required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(
          showTrackListAnimationValue * math.pi / 8,
        ),
      alignment: Alignment.topCenter,
      child: Container(
        height: 216.0,
        child: PageView.builder(
          controller: pageController,
          itemCount: 1,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: heroAnimationValue * 8.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(heroAnimationValue * 10.0),
                  bottomRight: Radius.circular(heroAnimationValue * 10.0),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImagesCarousel extends StatefulWidget {
  final int currentIndex;
  final Function(int) onPageChanged;
  final Album album;
  ImagesCarousel(
      {@required this.currentIndex,
      @required this.album,
      @required this.onPageChanged});

  @override
  _ImagesCarouselState createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  PageController _pageController;
  bool _isMoving;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isMoving = false;
    _pageController = PageController(
        initialPage: widget.currentIndex, viewportFraction: 0.85);
    _pageController.addListener(() {
      if (_pageController.page % 1 != 0) {
        setState(() {
          _isMoving = true;
        });
      } else {
        setState(() {
          _isMoving = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      child: PageView.builder(
        onPageChanged: widget.onPageChanged,
        controller: _pageController,
        itemCount: widget.album.images.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(
                  _isMoving ? -math.pi / 10 : 0,
                ),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  widget.album.images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BodySectionAnimation extends StatelessWidget {
  final double heroAnimationValue;
  final double showTrackListAnimationValue;
  final Animation<double> trackListAnimationController;
  final Album album;

  const BodySectionAnimation({
    this.heroAnimationValue = 1,
    this.showTrackListAnimationValue = 0,
    @required this.trackListAnimationController,
    @required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: showTrackListAnimationValue < 0.7
          ? EdgeInsets.only(bottom: 0)
          : EdgeInsets.only(bottom: showTrackListAnimationValue * 32.0),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(heroAnimationValue * 10.0),
            topRight: Radius.circular(heroAnimationValue * 10.0),
            bottomLeft: Radius.circular(
                (showTrackListAnimationValue + (1 - heroAnimationValue)) *
                    10.0),
            bottomRight: Radius.circular(
                (showTrackListAnimationValue + (1 - heroAnimationValue)) *
                    10.0),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${album.author}'),
                SizedBox(
                  height: 8.0,
                ),
                RichText(
                  text: TextSpan(
                    text: album.title,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: ' '),
                      TextSpan(
                        text: album.year,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: 25.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: album.genres.length,
                    itemBuilder: (_, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 6.0,
                        ),
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            '${album.genres[index]}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: 90 +
                      Tween<double>(begin: 0, end: 1)
                              .animate(
                                CurvedAnimation(
                                  curve: Interval(0.0, 0.5),
                                  reverseCurve: Interval(0.5, 1.0),
                                  parent: trackListAnimationController,
                                ),
                              )
                              .value *
                          50,
                  child: showTrackListAnimationValue < 0.5
                      ? Column(
                          children: <Widget>[
                            Opacity(
                              opacity: 1 -
                                  Tween<double>(begin: 0, end: 1)
                                      .animate(
                                        CurvedAnimation(
                                          curve: Interval(0.0, 0.5),
                                          parent: trackListAnimationController,
                                        ),
                                      )
                                      .value,
                              child: Text(
                                '${album.mainDescription}',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Opacity(
                              opacity: heroAnimationValue -
                                  Tween<double>(begin: 0, end: 1)
                                      .animate(
                                        CurvedAnimation(
                                          curve: Interval(0.0, 0.5),
                                          parent: trackListAnimationController,
                                        ),
                                      )
                                      .value,
                              child: Text(
                                '${album.moreDescription}',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Opacity(
                          opacity: Tween<double>(begin: 0, end: 1)
                              .animate(
                                CurvedAnimation(
                                  curve: Interval(0.6, 1.0),
                                  parent: trackListAnimationController,
                                ),
                              )
                              .value,
                          child: ListView.builder(
                            itemCount: album.trackList.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(album.trackList[index].name),
                                  Text(album.trackList[index].duration),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Opacity(
                  opacity: heroAnimationValue,
                  child: PlayButtons(
                    showTrackListAnimationValue: showTrackListAnimationValue,
                    trackListAnimationController: trackListAnimationController,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                showTrackListAnimationValue < 0.5
                    ? Opacity(
                        opacity: heroAnimationValue -
                            Tween<double>(begin: 0, end: 1)
                                .animate(
                                  CurvedAnimation(
                                    curve: Interval(0.0, 0.1),
                                    parent: trackListAnimationController,
                                  ),
                                )
                                .value,
                        child: Container(
                          width: double.infinity,
                          height: 40.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            color: Colors.black,
                            child: Text(
                              '\$26,66 Buy now',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    : Container(
                        height: (1 - showTrackListAnimationValue) * 40.0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayButtons extends StatelessWidget {
  final double showTrackListAnimationValue;
  final Animation<double> trackListAnimationController;
  PlayButtons(
      {this.showTrackListAnimationValue = 0,
      @required this.trackListAnimationController});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: showTrackListAnimationValue < 0.5
              ? Opacity(
                  opacity: Tween<double>(begin: 1, end: 0)
                      .animate(
                        CurvedAnimation(
                          curve: Interval(0.0, 0.5),
                          parent: trackListAnimationController,
                        ),
                      )
                      .value,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                )
              : Opacity(
                  opacity: Tween<double>(begin: 0, end: 1)
                      .animate(
                        CurvedAnimation(
                          curve: Interval(0.5, 1),
                          parent: trackListAnimationController,
                        ),
                      )
                      .value,
                  child: IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {},
                  ),
                ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Play demo',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  '02:40',
                  style: TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: showTrackListAnimationValue < 0.5
              ? Opacity(
                  opacity: Tween<double>(begin: 1, end: 0)
                      .animate(
                        CurvedAnimation(
                          curve: Interval(0.0, 0.5),
                          parent: trackListAnimationController,
                        ),
                      )
                      .value,
                  child: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                  ),
                )
              : Opacity(
                  opacity: Tween<double>(begin: 0, end: 1)
                      .animate(
                        CurvedAnimation(
                          curve: Interval(0.5, 1),
                          parent: trackListAnimationController,
                        ),
                      )
                      .value,
                  child: IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: () {},
                  ),
                ),
        ),
      ],
    );
  }
}
