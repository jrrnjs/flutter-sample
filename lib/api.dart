import 'package:http/http.dart' as http;
import 'dart:async';

const baseUrl = 'https://secure.flickr.com';
const defaultHeader = {
  'Content-Type': 'application/json'
};


const apiKey = '290f2c2d43dab6755e291a6e8062a5e1';


class FlickrApi {
  static Future<http.Response> getImages(String searchText, int page) {
    var url = baseUrl + '/services/rest/?method=flickr.photos.search&api_key=${apiKey}&text=${searchText}&safe_search=1&content_type=1&sort=interestingness-desc&per_page=60&format=json&page=${page}';
    return http.get(url, headers: defaultHeader);
  }
}