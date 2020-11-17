import 'package:gitloop/gitloop.dart' as gitloop;

void main() async {
  gitloop.welcome();
  var init = true;
  if (init == true) {
    gitloop.terminal_log('GitLoop inicializado!', ' | ', gitloop.time() + '\n');
  }
  while (init == true) {
    gitloop.init();
  }
}
