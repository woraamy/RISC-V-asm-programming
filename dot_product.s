# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};

# int main() {
#     int i, sop = 0;
    
#     for (i = 0; i < 5; i++) {
#         sop += a[i] * b[i];
#     }
    
#     printf("The dot product is: %d\n", sop);
#     return 0;
# }

.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
str_line: .string "The dot product is: "

.text
main:
    addi x5, x0, 0 # let x5 be sop and set to 0
    addi x6, x0, 0 # let x6 be i and set to 0
    addi x9, x0, 5 # set boundry to 5
    la x7, a # loading address of a into x7
    la x8, b # loading address of b into x8
    
loop:
   bge x6, x9, exit # check condition
   slli x10, x6, 2 # set x10 to i*4 
   add x18, x10, x7 # add i*4 to the base address of a and put it to x18
   add x19, x10, x8 # add i*4 to the base address of a and put it to x18
   
   # load value
   lw x21 0(x18)
   lw x22 0(x19)
   
   mul x20, x21, x22 # multiply x21 and x22 store it in x20
   add x5, x5, x20
   addi x6, x6, 1 # i++
   j loop
   
exit:
   # print a new line character; use print_string (a1)
   addi a0, x0, 4
   la a1, str_line
   ecall
   
   # print_int; sop
   addi a0, x0, 1
   add a1, x0, x5
   ecall
    
   addi a0, x0, 10
   ecall