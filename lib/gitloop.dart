import 'dart:io';

String welcome() {
  String name = 'GitLoop';
  String ver = 'v0.0.1';
  String vtype = 'Debug';
  String welcome = name + " | " + ver + ' ' + vtype;
  return welcome;
}
String time(){
  var timeNow = DateTime.now().toString();
  return timeNow;
}
void command(String cmd, List<String> args) {
  Process.run(cmd, args).then((ProcessResult results) {
    String outputlocal = results.stdout.toString();

    if (outputlocal.contains('Changes not staged for commit')) {
      command('git', ['add', '-A']);
      command('git', ['commit', '-m', '\"Implantado automaticamente pelo GitLoop.\"']);
      terminal_log('Commit realizado', ' -> ', time());
      command('git', ['push']);
      terminal_log('Push enviado', ' -> ', time());
      terminal_log('Procurando por novas alterações...', null, null);
    } else {
      terminal_log('Procurando por alterações...', null, null);
    }
  });
}
void terminal_log(String msg, String sep, var fun){
  String logprefix = 'GitLoop_> ';
  print(logprefix + msg + sep + fun);
}