import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:step1/main.dart' as app;

void main() {
// これは最初に必要。IntegrationTest用に初期化する。
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // テストをいろいろ書くところ(まずは起動できているかをチェック)
  testWidgets(
    'failing test example',
    (tester) async {
      // 2. app.main();
      app.main();

      // 3. tester.pumpAndSettle();
      await tester.pumpAndSettle(); //描画処理を待つ

      expect(find.text('Posts'), findsOneWidget); //postsが見つかるかどうかをチェック
      //ここにスクロールやら何やらの処理を追記していく
    },
  );
}
