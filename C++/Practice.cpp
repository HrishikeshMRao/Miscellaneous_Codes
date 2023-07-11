#include <iostream>
#include <vector>
#include <string>
#include <bits/stdc++.h>
#include <chrono>

using namespace std;

void fun()
{
    //vector<string> msg {"Hello", "C++", "World", "from", "VS Code", "and the C++ extension!"};
    volatile short int row,column;
    for (column=0;column<5;column++)
    {
    for (row=0;row<4;row++)     
    {
        if ((column==0)||(column==4))
        cout << "*" << " ";
        else if ((row==0)||(row==3))
        cout<<"*"<<" ";
        else 
        cout<<"  ";
    }
    cout<<endl;
    }
    //cout<<endl<<sizeof(row);
    //cout<<endl<<sizeof(b);
    //cout << endl;
}
int main()
{
    auto start = chrono::high_resolution_clock::now();
 
    // unsync the I/O of C and C++.
    ios_base::sync_with_stdio(false);
 
    fun();
 
    auto end = chrono::high_resolution_clock::now();
 
    // Calculating total time taken by the program.
    double time_taken =
      chrono::duration_cast<chrono::nanoseconds>(end - start).count();
 
    time_taken *= 1e-9;
 
    cout << "Time taken by program is : " << fixed
         << time_taken << setprecision(9);
    cout << " sec" << endl;
    return 0;
}