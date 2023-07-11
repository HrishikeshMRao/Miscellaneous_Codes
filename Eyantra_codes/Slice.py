import sys
def rev(L,Len):
    for j in range(Len):
        k=L[Len-j]
        L[Len-j]=L[j]
        L[j]=k
    print(L)  
def thrive(L,Len):
    for j in range(Len):
        if((j+1)%3==0):
          print(L[j]+3+"is a "+(j+1)+"th third no.")
        if(((j+1)%5==0)):
          print(L[j]-7+"is a "+(j+1)+"th fifth no.")
        for k in range(3,8):  
          if((j+1)%k==0):
            sum=sum+L[j]
                 
def main () :
    T=input("Enter no. of test cases")
    for i in range(T):
        Len=input("Enter the length of your string")
        L=input("String with spaces")
        rev(L,Len)  
        