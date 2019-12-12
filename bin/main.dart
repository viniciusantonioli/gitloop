import 'package:gitloop/gitloop.dart' as gitloop;
import "dart:async";

void main() async{
print(gitloop.welcome());
bool init = true;
if (init == true){
  gitloop.terminal_log('Inicialização permitida pelo build\nGitLoop inicializado!', ' | ', gitloop.time() + '\n');
}
while (init == true) {
  await Future.delayed(const Duration(seconds : 10));
  gitloop.command('git', ['commit', '-m', '\"Implantado automaticamente pelo GitLoop.\"']);
}
}