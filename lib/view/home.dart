import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:step1/provider/post_asyncnotifier_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int oldLength = 0;

  @override
  Widget build(BuildContext context) {
    final asyncTodos = ref.watch(postAsyncnotifierProviderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: asyncTodos.when(
        data: (asyncTodos) => Consumer(
          builder: (ctx, watch, child) {
            oldLength = asyncTodos.posts!.length;

            if (asyncTodos.posts == null) {
              if (asyncTodos.isLoading == false) {
                return const Center(
                  child: Text('error'),
                );
              }
              return const _Loading();
            }

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
                    itemCount: asyncTodos.posts!.length + 1,
                    itemBuilder: (ctx, index) {
                      if (index == asyncTodos.posts!.length) {
                        if (asyncTodos.isLoadMoreError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }

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
                              trailing: Text(asyncTodos.posts![index].id),
                              onTap: () {
                                context.go(
                                  '/subpage',
                                  extra: asyncTodos.posts![index].url,
                                );
                              },
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
        loading: () => const _Loading(),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
