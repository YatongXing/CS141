#include <malloc.h>
#include <iostream>
using namespace std;

typedef double (*double_method_type)(void *);
typedef void (*void_method_type)(void *);

typedef union {
    double_method_type double_method;
    void_method_type void_method;
} VirtualTableEntry;

typedef VirtualTableEntry * VTableType;

#define PRINT_INDEX 0
#define DRAW_INDEX 1
#define AREA_INDEX 2

#define PI 3.14159

// Shape
struct Shape {
    VTableType VPointer;
    string name;
};

void print(Shape *s)      { s->VPointer[PRINT_INDEX].void_method(s); }
void draw(Shape *s)       { s->VPointer[DRAW_INDEX].void_method(s); }
double area(Shape *s)     { return s->VPointer[AREA_INDEX].double_method(s); }

// Circle
struct Circle {
    VTableType VPointer;
    string name;
    int radius;
};

void Circle_print(Circle * _this) {
    printf("%s(%d) : %.2f\n", _this->name.c_str(), _this->radius, area((Shape*)_this));
}

void Circle_draw(Circle * _this) {
    //
}

double Circle_area(Circle * _this) {
    return PI * _this->radius * _this->radius;
}

VirtualTableEntry Circle_VTable[] = {
    {.void_method=(void_method_type)Circle_print},
    {.void_method=(void_method_type)Circle_draw},
    {.double_method=(double_method_type)Circle_area}
};

Circle * Circle_Circle(Circle * _this, const string& nm, int r) {
    _this->VPointer = Circle_VTable;
    _this->name = nm;
    _this->radius = r;
    return _this;
}

// Triangle
struct Triangle {
    VTableType VPointer;
    string name;
    int base;
    int height;
};

void Triangle_print(Triangle * _this) {
    printf("%s(%d, %d) : %.2f\n", _this->name.c_str(), _this->base, _this->height, area((Shape*)_this));
}

void Triangle_draw(Triangle * _this) {
    //
}

double Triangle_area(Triangle * _this) {
    return 0.5 * _this->base * _this->height;
}

VirtualTableEntry Triangle_VTable[] = {
    {.void_method=(void_method_type)Triangle_print},
    {.void_method=(void_method_type)Triangle_draw},
    {.double_method=(double_method_type)Triangle_area}
};

Triangle * Triangle_Triangle(Triangle * _this, const string& nm, int b, int h) {
    _this->VPointer = Triangle_VTable;
    _this->name = nm;
    _this->base = b;
    _this->height = h;
    return _this;
}

//Square
struct Square {
    VTableType VPointer;
    string name;
    int side;
};

void Square_print(Square * _this) {
    printf("%s(%d) : %.2f\n", _this->name.c_str(), _this->side, area((Shape*)_this));
}

void Square_draw(Square * _this) {
    //
}

double Square_area(Square * _this) {
    return _this->side * _this->side;
}

VirtualTableEntry Square_VTable[] = {
    {.void_method=(void_method_type)Square_print},
    {.void_method=(void_method_type)Square_draw},
    {.double_method=(double_method_type)Square_area}
};

Square * Square_Square(Square * _this, const string& nm, int s) {
    _this->VPointer = Square_VTable;
    _this->name = nm;
    _this->side = s;
    return _this;
}

// Rectangle
struct Rectangle {
    VTableType VPointer;
    string name;
    int side;
    int width;
};

void Rectangle_print(Rectangle * _this) {
    printf("%s(%d, %d) : %.2f\n", _this->name.c_str(), _this->side, _this->width, area((Shape*)_this));
}

void Rectangle_draw(Rectangle * _this) {
    //
}

double Rectangle_area(Rectangle * _this) {
    return _this->side * _this->width;
}

VirtualTableEntry Rectangle_VTable[] = {
    {.void_method=(void_method_type)Rectangle_print},
    {.void_method=(void_method_type)Rectangle_draw},
    {.double_method=(double_method_type)Rectangle_area}
};

Rectangle * Rectangle_Rectangle(Rectangle * _this, const string& nm, int s, int w) {
    Square_Square((Square*) _this, nm, s);
    _this->VPointer = Rectangle_VTable;
    _this->width = w;
    return _this;
}

// Picture as free functions on arrray
void printAll(Shape ** arr, int n) {
    for (int i=0;i<n;i++) print(arr[i]);
    printf("\n");
}
void drawAll(Shape ** arr, int n) {
    for (int i=0;i<n;i++) draw(arr[i]);
}
double totalArea(Shape ** arr, int n) {
    double sum=0.0;
    for (int i=0;i<n;i++) sum += area(arr[i]);
    return sum;
}

int main(int argc, char **argv) {
    int arg1 = std::max(1, atoi(argv[1]));
    int arg2 = std::max(1, atoi(argv[2]));
    int arg1b = std::max(1, arg1 - 1);
    int arg2b = std::max(1, arg2 - 1);

    Shape * a[] = {
        (Shape*) Triangle_Triangle((Triangle*)malloc(sizeof(Triangle)), "FirstTriangle", arg1, arg2),
        (Shape*) Triangle_Triangle((Triangle*)malloc(sizeof(Triangle)), "SecondTriangle", arg1b, arg2b),

        (Shape*) Circle_Circle((Circle*)malloc(sizeof(Circle)), "FirstCircle", arg1),
        (Shape*) Circle_Circle((Circle*)malloc(sizeof(Circle)), "SecondCircle", arg1b),

        (Shape*) Square_Square((Square*)malloc(sizeof(Square)), "FirstSquare", arg1),
        (Shape*) Square_Square((Square*)malloc(sizeof(Square)), "SecondSquare", arg1b),

        (Shape*) Rectangle_Rectangle((Rectangle*)malloc(sizeof(Rectangle)), "FirstRectangle", arg1, arg2),
        (Shape*) Rectangle_Rectangle((Rectangle*)malloc(sizeof(Rectangle)), "SecondRectangle", arg1b, arg2b)
    };

    printAll(a, 8);
    drawAll(a, 8);
    printf("Total : %.2f\n", totalArea(a, 8));
    return 0;
}
