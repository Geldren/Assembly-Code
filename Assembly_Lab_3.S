	.data
str1:	.asciz	"%d"
	.align	2
str2:	.asciz	"Enter 3 integers separated by the enter key.\n"
	.align	2
str3:	.asciz	"The largest number you entered was %d\n"
	.align	2
str4:	.asciz	"You entered %d negative numbers.\n"
	.align	2
str5:	.asciz	"You entered %d positive numbers.\n"
	.align 	2
str6:	.asciz	"The smallest number you entered was %d\n"
	.align	2
n:	.word	0
m:	.word	0
o:	.word	0

	.text
	.globl main
main:	stmfd	sp!, {lr}

	ldr	r0, =str2
	bl	printf

	ldr	r0, =str1
	ldr	r1, =n
	bl	scanf

	ldr	r0, =str1
	ldr	r1, =m
	bl	scanf

	ldr	r0, =str1
	ldr	r1, =o
	bl	scanf

	ldr	r0, =n
	ldr	r0, [r0]
	cmp	r0, #0

	mov	r4, #0
	mov	r5, #0

	addlt	r4, #1
	addgt	r5, #1

        ldr     r0, =m
        ldr     r0, [r0]
        cmp     r0, #0

        addlt   r4, #1
        addgt   r5, #1

        ldr     r0, =o
        ldr     r0, [r0]
        cmp     r0, #0

        addlt   r4, #1
        addgt   r5, #1

	ldr	r0, =str4
	mov	r1, r4
	bl	printf

	ldr	r0, =str5
	mov	r1, r5
	bl	printf

	ldr	r0, =n
	ldr	r0, [r0]
	ldr	r1, =m
	ldr	r1, [r1]
	ldr	r2, =o
	ldr	r2, [r2]
	cmp	r0, r1
	movlt	r6, r0
	movgt	r6, r1
	cmp	r6, r2
	movgt	r6, r2
	cmp	r0, r1
	movlt	r7, r1
	movgt	r7, r0
	cmp	r7, r2
	movlt	r7, r2

	ldr	r0, =str3
	mov	r1, r7
	bl	printf

	ldr	r0, =str6
	mov	r1, r6
	bl	printf

	ldmfd	sp!, {lr}
	mov	r0, #0
	mov	pc, lr
	.end
