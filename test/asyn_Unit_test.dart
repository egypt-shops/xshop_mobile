import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/services/signin.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

main() {
  SignIn signin = SignIn();
  group('Post', () {
    test('returns a User if the http request completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post("https://dev-egshops.herokuapp.com/api/users/token/",
              body: {'mobile': '01010092182', 'password': 'hEVFzCK8r3gpm5h'}))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

      expect(
          await signin.signIn('01010092182', 'hEVFzCK8r3gpm5h'), isA<User>());
    });

    test('returns null if the http call completes with a failed auth.',
        () async {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.post("https://dev-egshops.herokuapp.com/api/users/token/",
              body: {'mobile': '01010092182', 'password': 'hEVFzCK8r3gpm5h'}))
          .thenAnswer((_) async => http.Response('faied auth', 400));

      expect(await signin.signIn('01010092182', 'hEVFzC3gpm5h'), null);
    });
  });
}
