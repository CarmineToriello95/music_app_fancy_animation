import 'package:rxdart/rxdart.dart';

import '../constants.dart';
import '../models/album.dart';

class Bloc {
  final BehaviorSubject<List<Album>> _bStackAlbumList = BehaviorSubject();
  final BehaviorSubject<int> _bStackCarouselIndex = BehaviorSubject();
  List<Album> _lStackAlbumList;

  Bloc() {
    _initStackAlbumList();
  }

  _initStackAlbumList() {
    _lStackAlbumList = List();
    for (int i = 0; i < 3; i++) {
      _lStackAlbumList.add(hardCodedAlbums[i]);
    }
    _bStackAlbumList.sink.add(_lStackAlbumList);
  }

  Stream<List<Album>> get sStackAlbums => _bStackAlbumList.stream;
  Stream<int> get sStackCarouselIndex => _bStackCarouselIndex.stream;

  List<Album> get stackAlbumList => _lStackAlbumList;

  stackSwipedToLeft() {
    _lStackAlbumList.removeAt(0);
    _lStackAlbumList.add(hardCodedAlbums[_lStackAlbumList.last.id + 1]);
    _bStackAlbumList.sink.add(_lStackAlbumList);
  }

  stackSwipedToRight() {
    _lStackAlbumList.insert(0, hardCodedAlbums[_lStackAlbumList.first.id - 1]);
    _lStackAlbumList.removeAt(_lStackAlbumList.length - 1);
    _bStackAlbumList.sink.add(_lStackAlbumList);
  }

  dispose() {
    _bStackAlbumList.close();
    _bStackCarouselIndex.close();
  }
}
