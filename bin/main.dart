import 'package:gitloop/gitloop.dart' as gitloop;
import "dart:async";
import '../bin/config.dart' as config_file;

Map<String, String> config = config_file.db();

void main() async{
  print(gitloop.welcome());
  bool init = true;
  if (init == true){
    gitloop.terminal_log('Inicialização permitida no build\nGitLoop inicializado!', ' | ', gitloop.time() + '\n');
  }
  while (init == true) {
    await Future.delayed(const Duration(seconds : 15 * 60));
    gitloop.command('git', ['commit', '-m', '\"Implantado automaticamente pelo GitLoop.\"']);
    if (config['DB_TYPE'] == 'mysql') {
      gitloop.command('mysql', ['-h', config['DB_HOST'], '-u', config['DB_USER'], '-p', config['DB_PASSWORD'], config['DB_NAME'] ,'>', config['DUMP_NAME'] + '.sql']);
    }
  }
}