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

struct Shape{
    VTableType VPointer;
    string name;
} Shape;

static inline void print(Shape *s)      { s->VPointer[PRINT_INDEX].void_method(s); }
static inline void draw(Shape *s)       { s->VPointer[DRAW_INDEX].void_method(s); }
static inline double area(Shape *s)     { return s->VPointer[AREA_INDEX].double_method(s); }


