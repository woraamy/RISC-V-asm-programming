.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
print_text: .asciiz "The dot product is: "

.text
main:
    # a0 = a, a1 = b, a2 = size
    la a0 a
    la a1 b
    addi a2 x0 5
    jal dot_product_recursive # dot_project_recursive(a0, a1, a2)
    j exit

dot_product_recursive:
    addi sp sp -16 # Prepare Stack Pointer
    sw ra 0(sp) # Save ra into stack
    sw a0 4(sp) # Save ra into stack
    sw a1 8(sp) # Save ra into stack
    sw a2 12(sp) # Save ra into stack
    addi t0 x0 1 # t0 = temporary 1
    bne a2 t0 return # If size != 1 then we will call function recursively
    # Base Case
    addi sp sp 16 # Reset stack pointer
    lw t1 0(a0) # a[0]
    lw t2 0(a1) # b[0]
    mul a0 t1 t2 # a[0]*b[0]
    jr ra
    
return:
    # call dot_product_recursive(a+1, b+1, size-1)
    addi a0 a0 4 # a + 1
    addi a1 a1 4 # b + 1
    addi a2 a2 -1 # size - 1
    jal dot_product_recursive
    lw ra 0(sp) # load ra
    lw t0 4(sp) # load t0 = a
    lw t1 8(sp) # load t1 = b
    lw t2 12(sp) # load t2 = size
    addi sp sp 16 # Reset stack pointer
    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    lw t3 0(t0) # load value of a[0]
    lw t4 0(t1) # load value of b[0]
    mul t5 t3 t4 # a[0]*b[0] 
    add a0 a0 t5 # dot_product_recursive(a+1, b+1, size-1)
    jr ra
    
exit:
    mv t0 a0

    addi a0 x0 4
    la a1 print_text
    ecall

    mv a1 t0
    addi a0 x0 1
    ecall

    addi a0 x0 10
    ecall