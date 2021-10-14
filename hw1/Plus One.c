#include<stdio.h>
int main() {

    int carry = 0, nd = 3;
    int digits[] = {1,2,4};
    int newdigits[nd+1];

    digits[nd-1] += 1;
    for(int i = nd-1; i >= 0 ; i--) {
        if(digits[i] == 10) {
            digits[i] = 0;
            if(i == 0)
                carry = 1;
            else
                digits[i-1] += 1;
        }
        else
            break;
    }
    if(carry) {
        newdigits[0] = 1;
        for(int i = 0; i < nd; i++) {
            newdigits[i+1] = digits[i];
        }
        for(int i = 0; i < nd+1; i++) {
            printf("%d",newdigits[i]);
        }
    }
    else {
        for(int i = 0; i < nd; i++) 
            printf("%d",digits[i]);
    }
}