.data
a:  .word 1, 2, 3, 4, 5      # Array a elements
b:  .word 6, 7, 8, 9, 10     # Array b elements
str_line: .string "The dot product is: \n"

.text
main:
    la a0, a                # Load address of array a
    la a1, b                # Load address of array b
    addi a2, x0, 5          # size set to a2
    jal dot_product_recursive
    
    # print_string
    addi a0, x0, 4
    la a1, str_line
    ecall
    
    # Print result
    mv a1, a0               # Move result to a1 for printing
    addi a0, x0, 1          # Syscall number for print_int
    ecall
    
    # Exit
    addi a0, x0, 10         
    ecall

dot_product_recursive:
    addi t0, x0, 1          
    beq a2, x0, exit        # Base case: if size == 0, return 0
    
    lw t1, 0(a0)            # Load a[0]
    lw t2, 0(a1)            # Load b[0]
    mul t3, t1, t2          # t3 = a[0] * b[0]
    
    addi a0, a0, 2          
    addi a1, a1, 2         
    addi a2, a2, -1         # size - 1
    jal dot_product_recursive # Recursive call
    
    add a0, a0, t3
    jal dot_product_recursive # Add current product to result of recursive call
    
exit:
    jr ra                   # Return from function
