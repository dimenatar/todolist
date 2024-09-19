abstract class Shape {
  double calculateArea();
}

class Square extends Shape implements PerimeterCalculator {
  double side;

  Square.fromSize(double size) : this(size);
  Square(this.side);

  @override
  double calculateArea() {
  return side * side;
  }

  @override
  double calculatePerimeter() {
    return side * 4;
  }
}

class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double calculateArea() {
    return width * height;
  }

  double getWidth() => width;
  double getHeight() => height;

  void setWidth(double newWidth) 
  { 
    if (newWidth < 0) {
      throw new Exception("width cannot be negative");
    }
    width = newWidth;
  }
  void setHeight(double newHeight) => height = newHeight;
}

class Circle extends Shape {
  static const pi = 3.14159;

  double radius;

  Circle(this.radius);

  @override
  double calculateArea() { 
    return pi * radius * radius;
  }

  static double calculateCircumference(double radius) 
  { 
    return  2 * pi * radius;
  }
}

abstract class PerimeterCalculator {
  double calculatePerimeter();
}

mixin PrintDetailsMixin {
  void printDetails() {
    if (this is Shape)
    {
      print('Area: ${((this as Shape).calculateArea())}');
    }
    if (this is PerimeterCalculator) {
      print('Perimeter: ${(this as PerimeterCalculator).calculatePerimeter()}');
    }
    if (this is Circle) {
      print('Radius: ${(this as Circle).radius}');
    }
  }
}

abstract class Shape3D {
  double calculateVolume();
}

class Cube extends Shape3D {
  double side;

  Cube(this.side);

  @override
  double calculateVolume()
  {
    return side * side * side;
  }
}

class Sphere extends Shape3D {

  static const pi = 3.14159;

  double radius;

  Sphere(this.radius);

  @override
  double calculateVolume() 
  { 
    return (4 / 3) * pi * radius * radius * radius;
  }
}

class Lab1 {
  static void proceed(){
    {
  List<Shape> shapes = [
  Square(5),
  Rectangle(3, 4),
  Circle(2)
];

for (Shape shape in shapes) {
  print(shape.calculateArea());
}

Square duble = Square(5);

Set<Square> squareSet = {
  duble,
  Square(3),
  duble
};

print("sets");
for (Shape shape in squareSet) {
  print(shape.calculateArea());
}

for (int i = 0; i < 10; i++) {
  if (i % 2 == 0) {
    continue;
  }
  print(i);
}

for (int i = 0; i < 10; i++) {
  if (i == 5) {
    break;
  }
  print(i);
}
}
  }
}