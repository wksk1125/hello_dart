// 성적 처리 프로그램 v3
// 이름, 국어, 영어, 수학을 입력받아
// sqlite에 처리한 성적 데이터 저장
// 성적데이터는 클래스를 이용한 모델 사용

import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:hello_dart2/student.dart';
import 'package:sqlite3/sqlite3.dart';

void main(){
  Student std01 =  Student(name: '혜교', kor: 99, eng: 98, math: 99);
  print(std01);

  // sqlite3 dll 메모리에 적재
  // 현재 프로젝트 경로 가져오기
  final projectDir = Directory.current.path;
  // dll, db 파일 경로 설정
  final dllPath = path.join(projectDir, 'lib\\sqlite3.dll');
  final dbPath = path.join(projectDir, 'lib\\sungjuk.db');
  // sqlite3 로드
  DynamicLibrary.open(dllPath);

  // sql 버전확인
  print('Using sqlite3 ${sqlite3.version}');
  try {
    // 데이터베이스 연결
    final db = sqlite3.open(dbPath);

    // 필요시 테이블 생성
    db.execute('''
      CREATE TABLE IF NOT EXISTS sungjuk (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          kor INTEGER,
          eng INTEGER,
          math INTEGER,
          tot INTEGER,
          avg DOUBLE,
          grd TEXT
      )
    ''');

    // 성적 데이터 추가
    var sql = 'insert into sungjuk (name, kor, eng, math, tot, avg, grd) values (?, ?, ?, ?, ?, ?, ?)';
    var stmt = db.prepare(sql);
    stmt.execute([std01.name, std01.kor, std01.eng, std01.math, std01.tot, std01.avg, std01.grd]);
    stmt.dispose();
    print('성적 데이터 저장 성공');

    // 성적 데이터 조회
    sql = 'select id, name, kor, eng, math from sungjuk';
    final ResultSet rs = db.select(sql);
    for (final Row row in rs){
      print('${row['name']} ${row['kor']} ${row['eng']} ${row['math']}');
    }

    // 데이터베이스 닫기
    db.dispose();
  } catch(e, stackTrace){
    print('오류 발생 : $e');
    print('오류 추적 : $stackTrace');
  }
}
