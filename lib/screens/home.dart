import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../view_model/provider.dart';
import '../model/user.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(listProvider); //取得したAPIデータの監視
    return Scaffold(
      appBar: AppBar(
        title: const Text('user List'),
      ),
      body: Center(
        child: asyncValue.when(
          data: (data) {
            return data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index] as User;
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            context.go('/subpage', extra: user.html_url!);
                          },
                          child: ListTile(
                            title: Text(user.login!),
                            subtitle: Text(user.html_url!),
                            trailing: const Icon(Icons.chevron_right),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatar_url!),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Text('Data is empty.');
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(error.toString()),
        ),
      ),
    );
  }
}
