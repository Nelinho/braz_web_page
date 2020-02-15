import 'package:flutter_test/flutter_test.dart';
import 'package:braz_web_page/web_page.dart';

void main() {
  group('Test web_utils features', () {
    test('Get params from url with success: id = 213, name = emanuel braz', () {
      String id = '123';
      String name = 'emanuel braz';
      var params = WebUtils.getQueryParams(
          url: 'http://meudominio.com?id=$id&name=$name');
      expect(params['name'], name);
      expect(params['id'], id);
    });

    test('Get name from query params with success: name = emanuel braz', () {
      String name = 'emanuel braz';
      var nameValue = WebUtils.getQueryParam('name',
          url: 'http://meudominio.com?name=$name');
      expect(nameValue, name);
    });
  });
}
