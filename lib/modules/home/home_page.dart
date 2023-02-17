import 'package:flutter/material.dart';

import '../../modules/home/home_controller.dart';
import '../../shared/extensions/build_context_extension.dart';
import '../../shared/theme/app_text_styles.dart';
import '../../shared/utils/app_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController()..getChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Chats',
          style: AppTextStyles.heading28(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: _controller.loggedOut,
            builder: (_, bool state, __) {
              if (state) {
                Future.delayed(Duration.zero).whenComplete(
                  () => Navigator.of(context).pushReplacementNamed('/login'),
                );
              }
              return IconButton(
                onPressed: _controller.logout,
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SafeArea(
            child: ValueListenableBuilder(
              valueListenable: _controller.state,
              builder: (_, AppState state, __) {
                if (state == AppState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state == AppState.error) {
                  context.handleError(message: _controller.failure.value);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _controller.chats,
                      builder: (_, List<String> chats, ___) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    '/chat',
                                    arguments: {'id': chats[index]},
                                  );
                                },
                                title: Text(
                                  chats[index],
                                  style: AppTextStyles.bodyLarge(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.handleError(
            message: 'Falha ao realizar cadastro!',
          );
        },
      ),
    );
  }
}
