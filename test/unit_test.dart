import 'package:test/test.dart';
import 'package:xshop_mobile/services/signin_test.dart';

void main() {
  test('sign in with good credentials', () async{
    final signin =SignIn();
    expect(await signin.signIn('01010092182','hEVFzCK8r3gpm5h')!=null,true );

  });
  test('sign in with bad credentials', () async{
    final signin =SignIn();
    expect(await signin.signIn('055555555555','hEVFzCKw-WRONG'), null);

  });


}
