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

#define PRINT_INDEX=0
#define DRAW_INDEX=1
#define AREA_INDEX=2

#define PI 3.14159

struct Shape
{
    VTableType VPointer;
    string name;
};

void print(Shape *s)      { s->VPointer[PRINT_INDEX].void_method(s); }
void draw(Shape *s)       { s->VPointer[DRAW_INDEX].void_method(s); }
double area(Shape *s)     { return s->VPointer[AREA_INDEX].double_method(s); }

struct Circle
{
    VTableType VPointer;
    string name;
    int radius;
};

void Circle_print(Circle * _this) {
    printf("%s(%d) : %.2f\n", _this->name.c_str(), _this->radius, area((Shape*)_this));
}

void Circle_draw(Circle * _this) {
    
}

