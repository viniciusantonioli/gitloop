import 'dart:io';
import 'package:gitloop/gitloop.dart' as gitloop;
import 'package:args/args.dart';

ArgResults argResults;

void main(List<String> args) async {
  exitCode = 0;
  final parser = ArgParser()
    ..addFlag('restore', negatable: false, abbr: 'r', defaultsTo: false)
    ..addOption('type',
        allowed: ['mysql', 'postgresql', 'sqlserver'],
        defaultsTo: 'mysql',
        abbr: 't');
  var params = parser.parse(args);
  gitloop.welcome();
  gitloop.init();
}
