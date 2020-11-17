import 'package:dotenv/dotenv.dart' show load, env;
import './main.dart';

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
      '-S' + env['DB_HOST'],
      '-U' + env['DB_USER'],
      '-P' + env['DB_PASSWORD'],
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
  if (env['DB_TYPE'] == 'oracle') {}
}

void restore_database() {}
