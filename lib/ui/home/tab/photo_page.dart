import 'package:flutter/material.dart';
import 'package:flutter_sample/api.dart';
import 'dart:convert';
import 'dart:math';

class PhotoTabPage extends StatefulWidget {
  final List<_Photo> _items = [];
  final List<String> _randomKeyword = [
    'night view',
    'newyork',
    'paris',
    'pizza',
    'balloon',
    'super car',
    'space',
    'university',
    'apple',
    'orange',
    'forest',
    'flowers',
    'shoes',
    'sand',
    'sea',
    'sky'
  ];

  String _currentKeyword;

  @override
  State createState() {
    return _PhotoTabPageState();
  }
}

class _PhotoTabPageState extends State<PhotoTabPage> {

  void _getImages() async {
    var response = await FlickrApi.getImages(widget._currentKeyword);
    setState(() {
      final cutBody = response.body.substring(14, response.body.length - 1);
      var responseBody = (json.decode(cutBody) as Map<String, dynamic>);
      var result = _FlickrResult.fromJson(responseBody['photos']);
      widget._items.clear();
      widget._items.addAll(result.photo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        children: _buildGridTiles(),
        controller: ScrollController(

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          final index = Random.secure().nextInt(widget._randomKeyword.length-1);
          widget._currentKeyword = widget._randomKeyword[index];
          _getImages();
        },
      ),
    );
  }

  List<Widget> _buildGridTiles() {
    List<GridTile> tiles = List<GridTile>.generate(widget._items.length,
    (index) {
      final item = widget._items[index];
      final Widget image = Image.network(item.thumbnailUrl, fit: BoxFit.cover);

      return GridTile(
        child: GestureDetector(
          child: image,
          onTap: () { _showPhotoDetail(item.photoUrl); },
        )
      );
    });
    return tiles;
  }

  void _showPhotoDetail(String photoUrl) {
    final route = MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget._currentKeyword),
            ),
            body: Container(
              color: Colors.black,
              child: Center(
                child: Image.network(
                  photoUrl,
                  fit: BoxFit.fitWidth
                ),
              ),
            ),
          );
        }
    );
    Navigator.of(context).push(route);
  }
}

class _FlickrResult {
  int page;
  int pages;
  int perpage;
  String total;
  List<_Photo> photo;

  _FlickrResult(this.page, this.pages, this.perpage, this.total, this.photo);

  _FlickrResult.fromJson(Map map)
      : page = map['page'] as int,
        pages = map['pages'] as int,
        perpage = map['perpage'] as int,
        total = map['total'] as String,
        photo = (map['photo'] as Iterable)
            .map((obj) => _Photo.fromJson(obj))
            .toList();
}

class _Photo {
  String id;
  String secret;
  String server;
  int farm;

  _Photo(this.id, this.secret, this.server, this.farm);

  _Photo.fromJson(Map json)
      : id = json['id'],
        secret = json['secret'],
        server = json['server'],
        farm = json['farm'];

  String get thumbnailUrl {
    return 'http://farm${this.farm}.staticflickr.com/${this.server}/${this.id}_${this.secret}_t.jpg';
  }

  String get photoUrl {
    return 'http://farm${this.farm}.staticflickr.com/${this.server}/${this.id}_${this.secret}_b.jpg';
  }
}