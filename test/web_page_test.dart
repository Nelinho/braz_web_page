import 'package:flutter_test/flutter_test.dart';
import 'package:braz_web_page/braz_web_page.dart';

 /// How test me on web? Answer: flutter test --platform chrome

void main() {
  test('Testing singleton store changes status correctly: iddle to busy', () {
    // testing a singleton is no worse than testing nothing :)
    expect(BrazWebPageStore().status, WebPageStatus.idle);    
    BrazWebPageStore().setBusy();
    expect(BrazWebPageStore().status, WebPageStatus.busy);
  });
}
