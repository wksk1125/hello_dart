class Student{
  // 필드, 멤버변수
  final String name; // private
  final int kor;
  final int eng;
  final int math;

  // 생성자
  //  중괄호{}를 사용해서 named 매개변수를 정의할 수 있음
  // required : 해당 매개변수는 필수로 제공되어야 함을 의미
  // Student(this.name, this.kor, this.eng, this.math);
  Student({required this.name, required this.kor, required this.eng, required this.math});

  // getter/setter
  int get tot => kor + eng + math;
  double get avg => tot / 3;
  String get grd {
    String grd = '가';
    if(avg>=90) {grd='수';}
    else if (avg>=80) {grd='우';}
    else if (avg>=70) {grd='미';}
    else if (avg>=60) {grd='양';}
    return grd;
  }

  // 학생 정보 출력 메서드
  @override
  String toString() {
    String result = '$name $kor $eng $math \n';
    result += '$tot ${avg.toStringAsFixed(2)} $grd';
    return result;
  }
}