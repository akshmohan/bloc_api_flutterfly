import 'package:bloc_api/application/core/services/theme_services.dart';
import 'package:bloc_api/application/features/posts/postbloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PostWrapper extends StatelessWidget {
  const PostWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => PostBloc(), child: PostsPage());
  }
}

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text("PostApp Using Bloc", style: themeData.textTheme.titleMedium),
        actions: [
          Switch(
              value: Provider.of<ThemeServiceProvider>(context).isDarkModeOn,
              onChanged: (_) {
                Provider.of<ThemeServiceProvider>(context, listen: false)
                    .toggleTheme();
              }),
          IconButton(
              onPressed: () {
                BlocProvider.of<PostBloc>(context).add(PostRequestedEvent());
              },
              icon: Icon((Icons.refresh)))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text("All posts", style: themeData.textTheme.displayLarge),
            Expanded(child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostInitial) {
                  return Text("Posts are waiting to be loaded");
                } else if (state is PostStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink,
                    ),
                  );
                } else if (state is PostStateLoaded) {
                  return ListView.builder(
                      itemCount: state.posts?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Center(
                                child: Text("${index + 1}"),
                              ),
                            ),
                            title: Text("${state.posts![index].title}"),
                            subtitle: Text("${state.posts![index].body}"),
                          ),
                        );
                      });
                } else if (state is PostStateError) {
                  return Center(
                    child: Text(state.message.toString()),
                  );
                } else {
                  return Center(
                    child: Text("Some error has occurred"),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}

//BLAAAAAAA
