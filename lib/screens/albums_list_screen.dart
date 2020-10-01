import 'package:flutter/material.dart';
import 'package:music_app_fancy_animation/bloc/bloc.dart';
import 'package:music_app_fancy_animation/screens/album_details_screen.dart';
import 'package:music_app_fancy_animation/shared_widgets.dart/carousel_dots.dart';

import '../constants.dart';
import '../models/album.dart';

class AlbumsListScreen extends StatefulWidget {
  @override
  _AlbumsListScreenState createState() => _AlbumsListScreenState();
}

class _AlbumsListScreenState extends State<AlbumsListScreen>
    with TickerProviderStateMixin {
  final Bloc _bloc = Bloc();
  AnimationController _swipeAnimationController;
  bool _isSwipeToLeft;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  _initValues() {
    _swipeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addStatusListener(
        (AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _swipeAnimationController.reset();
            if (_isSwipeToLeft) {
              setState(() {
                _currentIndex++;
              });
              _bloc.stackSwipedToLeft();
            } else {
              setState(() {
                _isSwipeToLeft = true;
                _currentIndex--;
              });
            }
          }
        },
      );
    _isSwipeToLeft = true;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('Rock of 1970s'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        onTap: () => Navigator.of(context).push(
          _createRoute(_bloc.stackAlbumList[0]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0, bottom: 8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7 + 48.0,
                child: AnimatedBuilder(
                  animation: _swipeAnimationController,
                  builder: (_, child) {
                    return StreamBuilder<List<Album>>(
                      stream: _bloc.sStackAlbums,
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Stack(
                            children: <Widget>[
                              Transform.scale(
                                scale: 0.9,
                                child: AlbumCard(album: snapshot.data[2]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: Transform.scale(
                                  scale: 0.95,
                                  child: AlbumCard(album: snapshot.data[1]),
                                ),
                              ),
                              Transform.translate(
                                offset: _isSwipeToLeft
                                    ? Offset(
                                        _swipeAnimationController.value *
                                            -MediaQuery.of(context).size.width,
                                        0,
                                      )
                                    : Offset(
                                        (1 - _swipeAnimationController.value) *
                                            -MediaQuery.of(context).size.width,
                                        0,
                                      ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 48.0),
                                  child: AlbumCard(
                                    album: snapshot.data[0],
                                    isFrontCard: true,
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CarouselDots(
                  dotsNumber: hardCodedAlbums.length,
                  activeIndex: _currentIndex,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute(Album album) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          AlbumDetailsScreen(
        album: album,
      ),
      transitionDuration: const Duration(milliseconds: 1000),
    );
  }

  bool _isDraggable;
  bool _isDragFromLeft = false;

  void _onDragStart(DragStartDetails details) {
    _isDragFromLeft = _swipeAnimationController.isDismissed &&
        details.globalPosition.dx < MediaQuery.of(context).size.width / 2;
    bool isDragFromRight = _swipeAnimationController.isDismissed &&
        details.globalPosition.dx > MediaQuery.of(context).size.width / 2;
    _isDraggable = _isDragFromLeft || isDragFromRight;
    if (_isDragFromLeft) {
      _isDraggable &= !(_currentIndex == 0);
      if (_isDraggable) {
        setState(() {
          _isSwipeToLeft = false;
        });
        _bloc.stackSwipedToRight();
      }
    } else {
      _isDraggable &= !(_currentIndex == _bloc.stackAlbumList.length);
      if (_isDraggable) {
        setState(() {
          _isSwipeToLeft = true;
        });
      }
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isDraggable) {
      double delta = details.primaryDelta / MediaQuery.of(context).size.width;

      if (_isDragFromLeft) {
        _swipeAnimationController.value += delta;
      } else {
        _swipeAnimationController.value -= delta;
      }
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_swipeAnimationController.isDismissed ||
        _swipeAnimationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >=
        MediaQuery.of(context).size.width / 2) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx.abs() /
          MediaQuery.of(context).size.width;

      _swipeAnimationController.fling(velocity: visualVelocity);
    } else if (_swipeAnimationController.value > 0.5) {
      _swipeAnimationController.forward();
    } else {
      _swipeAnimationController.reverse();
    }
  }
}

class AlbumCard extends StatelessWidget {
  final Album album;
  final bool isFrontCard;
  AlbumCard({@required this.album, this.isFrontCard = false});

  @override
  Widget build(BuildContext context) {
    return isFrontCard
        ? Column(
            children: <Widget>[
              Hero(
                tag: 'image',
                child: AlbumCardImageSection(
                  album: album,
                ),
              ),
              Expanded(
                child: Hero(
                  tag: 'body',
                  child: AlbumCardBodySection(album: album),
                ),
              ),
            ],
          )
        : Column(
            children: <Widget>[
              AlbumCardImageSection(
                album: album,
              ),
              Expanded(
                child: AlbumCardBodySection(album: album),
              ),
            ],
          );
  }
}

class AlbumCardBodySection extends StatelessWidget {
  final Album album;
  AlbumCardBodySection({@required this.album});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 36.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(album.author),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    album.id.toString(),
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 25.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
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
                              album.genres[index],
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
                  Text(
                    album.mainDescription,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Icon(
                Icons.menu,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumCardImageSection extends StatelessWidget {
  final Album album;
  AlbumCardImageSection({@required this.album});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        itemCount: 1,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                album.coverPath,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
