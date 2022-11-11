/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/service/local_file_servicer.dart
 * Created Date: 2021-08-29 00:08:53
 * Last Modified: 2021-12-23 16:38:10
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path;

class LocalFileService {
  factory LocalFileService() => _sharedInstance();
  static LocalFileService? _instance;
  LocalFileService._() {
    //
  }
  static LocalFileService _sharedInstance() {
    if (_instance == null) {
      _instance = LocalFileService._();
    }
    return _instance!;
  }

  Future<Directory?> getLocalDirectory() async {
    return Platform.isAndroid
        ? await path.getExternalStorageDirectory()
        : await path.getApplicationSupportDirectory();
  }

  Future<String?> dirctoryPath(String dirName) async {
    Directory? tempDir = await getLocalDirectory();
    Directory directory;
    if (tempDir != null) {
      directory = new Directory('${tempDir.path}/$dirName');
      return directory.path;
    }
  }

  Future<Directory?> getDir(String dirName) async {
    Directory? tempDir = await getLocalDirectory();
    Directory directory;
    if (tempDir != null) {
      directory = new Directory('${tempDir.path}/$dirName');
      return directory;
    }
  }

  Future<void> deleteDirectory(
    String directoryName,
  ) async {
    Directory? tempDir = await getLocalDirectory();
    Directory directory;
    if (tempDir != null) {
      directory = new Directory('${tempDir.path}/$directoryName');
      if (directory.existsSync()) {
        List<FileSystemEntity> files = directory.listSync();
        if (files.length > 0) {
          files.forEach((file) {
            file.deleteSync();
            print('=== Delete file : ${file.path}');
          });
        }
      } else {
        throw Exception('Directory not find');
      }
      directory.deleteSync();
    }
  }

  Future<void> deleteFile(
    String path,
  ) async {
    File file = File(path);
    if (file.existsSync()) {
      List<FileSystemEntity> files = file.parent.listSync();
      if (files.length > 0) {
        files.forEach((f) {
          if (f.path == file.path) {
            f.deleteSync();
            print('== delete success  ${file.path} ===>>>>');
          }
        });
      }
    } else {
      throw Exception('fail to delete ${file.path} ===>>>>');
    }
  }

  Future<bool> checkFileExits(String fullpath) async {
    return File(fullpath).exists();
  }

  Future<bool> checkDirectoryExits(String dirName) async {
    Directory? temDir = await getLocalDirectory();

    if (temDir != null) {
      Directory directory = Directory('${temDir.path}/$dirName');
      return directory.exists();
    }
    return false;
  }

  Future<void> saveDataToFile(Map<String, dynamic> data, File file) async {
    try {
      file.writeAsStringSync(convert.json.encode(data));
      print('== write data success ${convert.json.encode(data)} ===>>>>');
    } catch (e) {
      print(e);
    }
  }

  Future<File> createFile(String fullPath) async {
    File file = File(fullPath);
    bool fileExits = await checkFileExits(fullPath);
    if (fileExits) {
      deleteFile(fullPath);
      file.createSync();
    } else {
      await checkDirectoryExits(file.parent.path).then((exists) {
        print(exists);
        if (exists) {
          file.createSync();
        } else {
          try {
            file.createSync(recursive: true);
          } catch (e) {
            print(e);
          }
        }
      });
    }
    print('== create file success === $fullPath>>>>');
    return file;
  }

  Future<Directory?> createDirectory(String dirName) async {
    Directory? temDir = await getLocalDirectory();
    if (temDir != null) {
      Directory directory = Directory('${temDir.path}/$dirName');
      bool exists = await checkDirectoryExits(directory.path);
      if (exists) {
        return directory;
      } else {
        return await directory.create().catchError((e) {
          print(e);
        });
      }
    }
  }

  Future<Null> deleteAll(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await deleteAll(child);
      }
    }
    await file.delete();
  }
}
