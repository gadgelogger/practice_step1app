import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step1/view_model/post_asyncnotifier_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final ScrollController _controller = ScrollController();
  int oldLength = 0;

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
            // sync oldLength with post.length to make sure ListView has newest
            // data, so loadMore will work correctly
            //?.の部分はNullにならないので.だけにする
            //posts.length ?? 0;は左側がNullの場合に備えているが、Nullになることはないので、「0」は削除。
            oldLength = asyncTodos.posts!.length;
            // init data or error
            //（この部分わからんのでとりあえず誤魔化す）
            // ignore: unnecessary_null_comparison
            if (asyncTodos.posts! == null) {
              // error case
              if (asyncTodos.isLoading == false) {
                return const Center(
                  child: Text('error'),
                );
              }
              return const _Loading();
            }
            //上からひっぱた時に更新させるやつ
            return RefreshIndicator(
              onRefresh: () {
                return ref
                    .read(postAsyncnotifierProviderProvider.notifier)
                    .refresh();
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    final before = scrollNotification.metrics.extentBefore;
                    final max = scrollNotification.metrics.maxScrollExtent;
                    if (before == max) {
                      if (oldLength ==
                          ref
                              .read(postAsyncnotifierProviderProvider)
                              .value!
                              .posts!
                              .length) {
                        setState(() {
                          ref
                              .read(postAsyncnotifierProviderProvider.notifier)
                              .loadMorePost();
                        });
                      }
                      return true;
                    }
                  }
                  return false;
                },
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    controller: _controller,
                    itemCount: asyncTodos.posts!.length + 1, //リストに表示するデータの個数
                    itemBuilder: (ctx, index) {
                      // 現在ビルドされているリストのアイテムの位置を示す番号らしい。
                      //ctxはcontextの略
                      // 最後の要素（プログレスバー、エラー、または最後の要素に到達した場合はDone!とする）
                      if (index == asyncTodos.posts!.length) {
                        // さらにロードしてエラーが出た際に実行
                        if (asyncTodos.isLoadMoreError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                        // ロードしまくって最後の部分に到達した際に実行させる
                        if (asyncTodos.isLoadMoreDone) {
                          return const Center(
                            child: Text(
                              'Done!',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ),
                          );
                        }
                        return const LinearProgressIndicator();
                      }
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                asyncTodos.posts![index].login,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(asyncTodos.posts![index].url),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      asyncTodos.posts![index].avater)),
                            ),
                          ],
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
