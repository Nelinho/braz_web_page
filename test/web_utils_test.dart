import 'package:flutter_test/flutter_test.dart';
import 'package:braz_web_page/braz_web_page.dart';

void main() {
  group('Test web_utils features', () {
    test('Get params from url successfully: id = 213, name = emanuel braz', () {
      
      String id = '123';
      String name = 'emanuel braz';
      String url = 'http://meudominio.com?id=$id&name=$name';

      var params = BrazWebUtils.getQueryParams(url: url);
      expect(params['name'], name);
      expect(params['id'], id);

      url = 'http://meudominio.com/?id=$id&name=$name#/MyCustomRoutePage';
      expect(params['name'], name);
      expect(params['id'], id);

    });

    test('Get value by key, from query params successfully: key(name) = emanuel braz', () {
      String name = 'emanuel braz';
      var nameValue = BrazWebUtils.getQueryParam('name',
          url: 'http://meudominio.com?name=$name');
      expect(nameValue, name);
    });
    
    test('Get current route successfully: expect(/MyCustomRoutePage)', () {

      String routeName = '/MyCustomRoutePage';
      String url = 'http://meudominio.com/#$routeName';

      var currentRoute = BrazWebUtils.getCurrentRoute(url: url);
      expect(currentRoute, routeName);

      url = 'http://meudominio.com/?id=123&name=emanuel#$routeName';
      currentRoute = BrazWebUtils.getCurrentRoute(url: url);
      expect(currentRoute, routeName);

    });
  });
}
