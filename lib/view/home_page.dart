import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:step1/provider/post_asyncnotifier_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomePage> {
  int oldLength = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final asyncTodos = ref.watch(postAsyncnotifierProviderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: asyncTodos.when(
        // 投稿のロード状態に応じて表示を変更
        data: (asyncTodos) => Consumer(
          builder: (ctx, watch, child) {
            //.notifierはインスタンへのアクセス許可・.stateはプロ杯だの現在の状態を取得
            //ref.watchはプロバイダーを監視するやつ(値も得るよ)
            oldLength = asyncTodos.posts?.length ?? 0; // ロード前の投稿数を取得
            //todo:この部分Freezedを使えばスッキリできるぞ！！！
            if (asyncTodos.posts == null) {
              // ロード前の投稿がない場合
              if (asyncTodos.isLoading == false) {
                // ロード中でない場合
                return const Center(
                  child: Text('error'),
                );
              }
              return const _Loading();
            }
            //上からひっぱた時に更新させるやつ
            return RefreshIndicator(
              //refresh()を実行
              onRefresh: () async {
                ref.invalidate(postAsyncnotifierProviderProvider);
              },
              child: NotificationListener<ScrollNotification>(
                //スクロールした際に実行するやつ
                onNotification: (ScrollNotification scrollNotification) {
                  // リストの最後までスクロールした場合
                  if (scrollNotification is ScrollEndNotification) {
                    final before =
                        scrollNotification.metrics.extentBefore; //スクロールした距離
                    final max =
                        scrollNotification.metrics.maxScrollExtent; //最大スクロール距離
                    if (before == max) {
                      //スクロールした距離と最大スクロール距離が同じ場合
                      //取得したデータの数が前回取得したデータの数と同じ場合実行
                      //todo:！マークいらないようにする
                      if (oldLength ==
                          ref
                              .read(postAsyncnotifierProviderProvider)
                              .value!
                              .posts!
                              .length!) {
                        ref
                            .read(postAsyncnotifierProviderProvider.notifier)
                            .loadMorePost();
                      }
                      return true; // trueを返すとonRefreshが実行される
                    }
                  }
                  return false; // falseを返すとonRefreshが実行されない
                },
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: asyncTodos.posts?.length ?? 0, //リストに表示するデータの個数
                    itemBuilder: (ctx, index) {
                      // 現在ビルドされているリストのアイテムの位置を示す番号らしい。
                      //ctxはcontextの略
                      // 最後の要素（プログレスバー、エラー、または最後の要素に到達した場合はDone!とする）
                      //todo:indexじゃなくてboolで判定した方がいいかも
                      //todo: isLoadingを[true]にするコードを追加する。
                      if (isLoading == (asyncTodos.posts?.length ?? 0)) {                        }
                        return const LinearProgressIndicator();
                      }
                      return Card(
                        child: ListTile(
                          title: Text(
                            //todo:！マークいらないようにする
                            asyncTodos.posts![index].login,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(asyncTodos.posts![index].url),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  asyncTodos.posts![index].avater)),
                          trailing: Text(asyncTodos.posts![index].id),
                          onTap: () {
                            context.go('/subpage',
                                extra: asyncTodos.posts![index].url);
                          },
                        ),
                      );
                    }),
              ),
            );
          },
        ),
        error: (err, stack) => const Text('error'),
        loading: () =>
            const _Loading(), //ローディング中はこいつを実行させてCircularProgressIndicatorを出す
      ),
    );
  }
}

//起動した時にローディング表示
class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
