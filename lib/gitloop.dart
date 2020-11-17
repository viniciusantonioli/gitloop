import 'dart:io';
import 'dart:async';
import 'package:dotenv/dotenv.dart' show load, clean, isEveryDefined, env;

void welcome() {
  var name = 'GitLoop';
  var ver = 'v0.0.3';
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

bool is_staged(String git_process_output) {
  if (git_process_output.contains('Changes not staged for commit')) {
    return false;
  } else {
    return true;
  }
}

void command(String cmd, List<String> args) {
  Process.run(cmd, args).then((ProcessResult results) {
    var outputlocal = results.stdout.toString();

    if (!is_staged(outputlocal)) {
      command('git', ['add', '-A']);
      command('git',
          ['commit', '-m', '\"Implantado automaticamente pelo GitLoop.\"']);
      terminal_log('Commit realizado', ' -> ', time());
      command('git', ['push']);
      terminal_log('Push enviado', ' -> ', time());
      terminal_log('Procurando por novas alterações...', '', '');
    } else {
      terminal_log('Procurando por alterações...', '', '');
    }
  });
}

void dump_database() {
  load();
  if (env['DB_TYPE'] == 'mysql') {
    command('mysql', [
      '-h',
      env['DB_HOST'],
      '-u',
      env['DB_USER'],
      '-p',
      env['DB_PASSWORD'],
      env['DB_NAME'],
      '>',
      env['DUMP_NAME'] + '.sql'
    ]);
  }
  if (env['DB_TYPE'] == 'postgresql') {
    command('pg_dump', [
      '--dbname=postgresql://' +
          env['DB_USER'] +
          ':' +
          env['DB_PASSWORD'] +
          '@' +
          env['DB_HOST'] +
          ':5432/' +
          env['DB_NAME'],
      '>',
      env['DUMP_NAME'] + '.sql'
    ]);
  }
  if (env['DB_TYPE'] == 'sqlserver') {
    command('sqlcmd', [
      '-S' +
      env['DB_HOST'],
      '-U' +
      env['DB_USER'],
      '-P' +
      env['DB_PASSWORD'],
      '-Q',
      '"BACKUP DATABASE [' +
      env['DB_NAME'] +
      '] TO DISK = N\'./' +
      env['DUMP_NAME'] +
      '.bak\'  WITH NOFORMAT, NOINIT, NAME = \'' +
      env['DUMP_NAME'] +
      '-full\', SKIP, NOREWIND, NOUNLOAD, STATS = 10"'
  ]);
  }
}

void init(int mins) async {
  await Future.delayed(Duration(minutes: mins));
  command(
      'git', ['commit', '-m', '\"Implantado automaticamente pelo GitLoop.\"']);
}
