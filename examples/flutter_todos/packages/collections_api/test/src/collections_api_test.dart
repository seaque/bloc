import 'package:collections_api/collections_api.dart';
import 'package:test/test.dart';

class TestCollectionsApi extends CollectionsApi {
  TestCollectionsApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('CollectionsApi', () {
    test('can be constructed', () {
      expect(TestCollectionsApi.new, returnsNormally);
    });
  });
}
