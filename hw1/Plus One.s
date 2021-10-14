.data
carry:    .word 0
nd:       .word 3
digits:   .word 1 2 4
newdigits: .word 0 0 0 0
str1:     .string "Plus One"
str2:     .string " is "

.text
main:
        lw    s1, carry    # carry = 0
        lw    s2, nd        # nd = 3
        la    s3, digits    # digits[] = {1,2,4}
        la    s4, newdigits #newdigits[] = {0,0,0,0}
        
        li    t0, 4        # t0 = 4
        mul   t0, s2, t0    # t0 = 4 * nd
        addi  t0, t0, -4    # t0 = t0 - 4
        add   t0, t0, s3
        lw    t1, 0(t0)    # t1 = digits[nd-1]
        addi  t1, t1, 1    # t1 =  digits[nd-1] + 1
        sw    t1, 0(t0)    #digits[nd-1] = digits[nd-1] + 1

        addi  t1, s2, -1    # t1(i) = s2(nd) - 1
for:
        li    t2, 10    # t2 = 10
        lw    t3, 0(t0)    # t3 = digits[i]
        bne   t3, t2, elseBreak  # t3(digits[i]) != 10 brach to elseBreak  
        li    t3, 0        # t3(digits[i]) = 0
        sw    t3,0(t0)    # digits[i] = t0
        bne   t1,x0, else2    # t1(i) != 0 branch to else2
        li    s1, 1    # s1(carry) = 1
        j     forend
else2:
        addi  t0, t0, -4    # t0 = &digits[i] - 4 = &digits[i-1]
        lw    t3, 0(t0)    # t3 = digits[i-1]
        addi  t3, t3, 1    # t3 = t3 - 1
        sw    t3, 0(t0)    # digits[i-1] = t3
forend:
        addi  t1, t1, -1    # t1(i) = t1(i) - 1
        bge   t1, x0, for       # if t1(i) >= 0 branch to for
elseBreak:
    
        beq   s1, x0, printDigits    # s1(carry) == 0 branch to else3
        li    t0, 1    # t0 = 1
        sw    t0, 0(s4)    # newdigits[0] = 1
        li    t1, 0    # t1(i) = 0
        add   t0, s3, x0    # t0 = &digits[0]
        addi   t3, s4, 4    # t3 = &newdigits[1]
for2:
        lw    t2, 0(t0)    # t2 = digits[i]
        sw    t2, 0(t3)    #newdigits[i+1] = digits[i]
        addi  t0, t0, 4
        addi  t3, t3, 4
        addi  t1, t1, 1
        bgt   t1, s2, for2
        j     printNewdigits    
printDigits:  
        li    t1, 0
        add   t0, s3, x0
for3:
        lw    a0, 0(t0)
        li    a7, 1
        ecall
        addi  t1, t1, 1
        addi  t0, t0, 4
        blt   t1, s2, for3 
        j    end    
printNewdigits:
        li    t1, 0
        add   t0, s4, x0
        addi  t2, s2, 1
for4:
        lw    a0, 0(t0)
        li    a7, 1
        ecall
        addi  t1, t1, 1
        addi  t0, t0, 4
        blt   t1, t2, for4
end:
    li a7, 10
    ecall 