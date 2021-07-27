#! /bin/bash

echo "Welcome!!!!"

echo "Enter project name: "
read project_name
echo "Your project name: $project_name"


echo "Enter file prefix: "
read prefix
echo "Your prefix: $prefix"


echo "Enter class name: "
read class_name
echo "Your class name: $class_name"
mkdir $prefix
cd $prefix

# VIEW
touch `pwd`/$prefix'_view.dart'
echo "
import 'package:flutter/material.dart';
import 'package:${project_name}/base/base_state_bloc.dart';

class ${class_name} extends StatefulWidget {
  const ${class_name}({Key? key}) : super(key: key);

  @override
  _${class_name}State createState() => _${class_name}State();
}

class _${class_name}State extends BaseStateBloc<${class_name},${class_name}Bloc> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

" >>  `pwd`/$prefix'_view.dart'

# BLOC
touch `pwd`/$prefix'_bloc.dart'
echo "
import 'package:${project_name}/repo/user_repo.dart';
import 'package:${project_name}/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ${class_name}Bloc extends BaseBloc {
  final UserRepo userRepo;

  ${class_name}Bloc({
    required this.userRepo,
  });

  @override
  void dispose() {
    super.dispose();
  }
}
" >>  `pwd`/$prefix'_bloc.dart'


# ROUTE
touch `pwd`/$prefix'_route.dart'
echo "
import 'package:${project_name}/repo/user_repo.dart';
import 'package:provider/provider.dart';

var ${class_name}Route = ProxyProvider<UserRepo, ${class_name}Bloc>(
  create: (context) {
      ${class_name}Bloc bloc =
        $NAME$Bloc(userRepo: Provider.of<UserRepo>(context, listen: false));
    return bloc;
  },
  update: (context, userRepo, bloc) {
    if (bloc != null) return bloc;
    return ${class_name}Bloc(
      userRepo: userRepo,
    );
  },
  dispose: (context, bloc) => bloc.dispose(),
  child: ${class_name}(),
);

" >>  `pwd`/$prefix'_route.dart'
