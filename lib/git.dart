import './main.dart';
import 'package:dotenv/dotenv.dart' show load, env;

bool is_staged(String git_process_output) {
  if (git_process_output.contains('Changes not staged for commit')) {
    return false;
  } else {
    return true;
  }
}

void get_dump_from_git() {
  load();
  var ext = 'sql';
  if (env['DB_TYPE'] == 'sqlserver') ext = 'bak';
  command('wget', [env['GIT_REPOSITORY'] + '/blob/master/.' + ext]);
}
