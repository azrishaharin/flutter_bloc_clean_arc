import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tdd/src/presentation/bloc/bloc/authentication_bloc.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'username')),
              ElevatedButton(
                  child: const Text('Add User'),
                  onPressed: () {
                    final name = nameController.text.trim();
                    context.read<AuthenticationBloc>().add(CreateUserEvent(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar: 'https://picsum.photos/id/237/200/300'));
                    Navigator.of(context).pop();
                  })
            ]),
          ),
        ));
  }
}
