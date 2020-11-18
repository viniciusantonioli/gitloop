import 'dart:io';

void main() {
  Process.run('dart2native', ['bin/main.dart', '-o', 'build/gitloop'])
      .then((ProcessResult results) {
    print('Compilado com sucesso!');
  });
}
