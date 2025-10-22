#include "vector.h"

int main() // Here is a start:
{
    Vector<int>    intVec{1, 3, 5, 7, 9};
    Vector<double> doubleVec{1.5, 2.5, 3.5, 4.5};
    Vector<int>    iv{intVec};
    Vector<double> dv{doubleVec};

    cout << "intVec" << intVec << endl;
    // "intVec(1, 3, 5, 7, 9)"
    cout << "iv" << iv << endl;
    // "iv(1, 3, 5, 7, 9)"
    cout << "doubleVec" << doubleVec << endl;
    // "doubleVec(1.5, 2.5, 3.5, 4.5)"
    cout << "dv" << dv << endl;
    // "dv(1.5, 2.5, 3.5, 4.5)"

    // add at least one test case for each method defined in Vector

    // size()
    cout << "intVec.size()=" << intVec.size() << endl;
    cout << "doubleVec.size()=" << doubleVec.size() << endl;

    // operator[] (read/write) + const read
    cout << "iv[2](before)=" << iv[2] << endl;   // expect 5
    iv[2] = 100;
    cout << "iv(after iv[2]=100)=" << iv << endl; // (1, 3, 100, 7, 9)
    cout << "const read iv[1]=" << static_cast<const Vector<int>&>(iv)[1] << endl;

    // copy assignment (deep copy)
    Vector<int> asg(0);
    asg = intVec;
    cout << "asg(intVec copied with operator=) " << asg << endl;
    cout << "asg==intVec? " << (asg == intVec) << endl;
    
    // equality / inequality
    cout << "iv==intVec? " << (iv == intVec) << endl;
    cout << "iv!=intVec? " << (iv != intVec) << endl;
    
    // dot product (*) uses min length
    //Vector<int> shortv{2,2};
    //cout << "intVec * shortv = " << (intVec * shortv) << "  // expect 8" << endl;
    
    // vector addition (+) uses max length and copies tail from longer
    //Vector<int> a{1,2,3};
    //Vector<int> b{4,5,6,7};
    //cout << "a+b = " << (a + b) << "  // expect (5, 7, 9, 7)" << endl;
    
    // scalar * vector
    //cout << "20 * a = " << (20 * a) << "  // expect (20, 40, 60)" << endl;
    
    // scalar + vector
    //cout << "20 + a = " << (20 + a) << "  // expect (21, 22, 23)" << endl;
    
    // operator[] bounds checking (catch exception; program keeps running)
    /*try {
        cout << "iv[-1]=" << iv[-1] << endl; // should throw
    } catch (const std::out_of_range& e) {
        cout << "caught out_of_range (iv[-1])" << endl;
    }
    try {
        cout << "iv[999]=" << iv[999] << endl; // should throw
    } catch (const std::out_of_range& e) {
        cout << "caught out_of_range (iv[999])" << endl;
    }*/
    
    return 0;
}
