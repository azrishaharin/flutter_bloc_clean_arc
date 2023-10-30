import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tdd/src/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_tdd/src/presentation/widgets/add_user_dialog.dart';
import 'package:flutter_bloc_tdd/src/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthenticationBloc>().add(const GetUsersEvent());
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? const LoadingColumn(message: 'Fetching Users')
              : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating User')
                  : state is UserLoaded
                      ? Center(
                          child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                final user = state.users[index];
                                return ListTile(
                                  title: Text(user.name),
                                  subtitle:
                                      Text(user.createdAt.substring(0, 10)),
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                    user.avatar,
                                  )),
                                );
                              }),
                        )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => AddUserDialog(
                          nameController: nameController,
                        ));
              },
              icon: const Icon(Icons.add),
              label: const Text('Add User')),
        );
      },
    );
  }
}
