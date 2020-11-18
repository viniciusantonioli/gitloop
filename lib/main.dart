import 'dart:io';
import 'dart:async';

import 'package:dotenv/dotenv.dart' show load, env;
import 'package:path/path.dart';
import 'package:watcher/watcher.dart';
import './git.dart';

void welcome() {
  var name = 'GitLoop';
  var ver = 'v0.0.4';
  var vtype = 'Debug';
  var welcome = name + ' | ' + ver + ' ' + vtype;
  return print(welcome);
}

String time() {
  var timeNow = DateTime.now().toString();
  return timeNow;
}

void terminal_log(String msg, String sep, var fun) {
  var logprefix = 'GitLoop_> ';
  print(logprefix + msg + sep + fun);
}

void command(String cmd, List<String> args) {
  Process.run(cmd, args).then((ProcessResult results) {
    var outputlocal = results.stdout.toString();

    if (!is_staged(outputlocal)) {
      command('git', ['add', '-A']);
      command('git',
          ['commit', '-m', '\"Implantado automaticamente pelo GitLoop.\"']);
      terminal_log('Commit realizado', ' -> ', time());
      command('git', ['push', 'origin', 'master']);
      terminal_log('Push enviado', ' -> ', time());
      terminal_log('Procurando por novas alterações...', '', '');
    } else {
      terminal_log('Procurando por alterações...', '', '');
    }
  });
}

void init() async {
  load();
  var watcher = DirectoryWatcher(absolute('') + '/lib');
  watcher.events.listen((event) {
    command('git',
        ['commit', '-m', '\"Implantado automaticamente pelo GitLoop.\"']);
  });
  // await Future.delayed(Duration(minutes: int.parse(env['DELAY_MINUTES'])));
}
