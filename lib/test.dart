import 'dart:io';

void main() {
  int a = 4;
  int b = 5;

  // if (a == b) {
  //   print("a and b are equal ");
  // } else {
  //   if (a > b) {
  //     print("a is greter");
  //   } else {
  //     print("b is lesser");
  //   }
  // }\
/////////////////Solid rectangle////////////////
  // for (int i = 1; i <= a; i++) {
  //   for (int j = 1; j <= b; j++) {
  //     stdout.write("*");
  //   }
  //   print("");
  // }

//////////Hollow Rectangle///////////////////

  // //outloop
  // for (int i = 1; i <= a; i++) {
  //   //inner loop
  //   for (int j = 1; j <= b; j++) {
  //     // Print '*' for the first and last row, or first and last column
  //     if (i == 1 || i == a || j == 1 || j == b) {
  //       stdout.write("*");
  //     } else {
  //       stdout.write(" "); // Leave space for the hollow part
  //     }
  //   }
  //   print(""); // Move to the next line after each row
  // }

  // half pyramid

  // for (int i = a; i >= 1; i--) {
  //   for (int j = 1; j <= i; j++) {
  //     stdout.write("*");
  //   }
  //   print("");
  // }

  //  ///////////////////////////

  // for (int i = 1; i <= a; i++) {
  //   for (int k = 1; k <= a - i; k++) {
  //     stdout.write(" ");
  //   }
  //   for (int j = 1; j <= i; j++) {
  //     stdout.write(j);
  //   }
  //   print("");
  // }

  // for (int i = 1; i <= a; i++) {
  //   for (int j = 1; j < b - i + 1; j++) {
  //     stdout.write(j);
  //   }
  //   print("");
  // }

  // int n = 5;
  // for (int i = 1; i <= n; i++) {
  //   for (int j = 1; j <= i; j++) {
  //     int sum = 1 + j;
  //     if (sum % 2 == 0) {
  //       stdout.write("1");
  //     } else {
  //       stdout.write("0");
  //     }
  //   }
  //   print("");
  // }

  int n = 5;
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= n - i; j++) {
      stdout.write(" ");
    }
    for (int k = 1; k <= n; k++) {
      stdout.write("*");
    }
    print(" ");
  }
}
