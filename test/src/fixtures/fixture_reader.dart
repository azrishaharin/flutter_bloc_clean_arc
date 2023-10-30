import 'dart:io';

String fixture(String filename) =>
    File('test/src/fixtures/$filename').readAsStringSync();
