	.data
strin:	.ascii	"Enter the number of pennies, nickles, dimes, and quarters for"
	.asciz	" the week:"
	.align	2
strfrm:	.asciz	"%d%d%d%d"
	.align	2
coin:	.ascii	"Over four weeks you have collected %d pennies, %d nickles %d "
	.asciz	"dimes, and %d quarters.\n"
total:	.asciz	"This comes to $%d.%d\n"
	.align	2
avrge:	.asciz	"Your weekly average is $%d.%d\n"
	.align	2
year:	.asciz	"Your estimated yearly savings is $%d.%d\n"
	.align	2
penny:	.word	0
nickel:	.word	0
dime:	.word	0
quartr:	.word	0


	.text
	.global main

main:	stmfd	sp!, {r4-r10,lr}

	mov	r4, #0
	mov	r5, #0
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
	mov	r9, #0

readlp:	cmp	r4, #4
	beq	redend

	ldr	r0, =strin
	bl	printf

	ldr	r1, =quartr
	str	r1, [sp,#-4]!
	ldr	r0, =strfrm
	ldr	r1, =penny
	ldr	r2, =nickel
	ldr	r3, =dime
	bl	scanf

	ldr	r10, [sp,#4]!

	add	r4, r4, #1

	ldr	r1, =penny
	ldr	r1, [r1]
	add	r5, r1, r5

	ldr	r1, =nickel
	ldr	r1, [r1]
	add	r6, r1, r6

	ldr	r1, =dime
	ldr	r1, [r1]
	add	r7, r1, r7

	ldr	r1, =quartr
	ldr	r1, [r1]
	add	r8, r1, r8
	b	readlp
redend:	

	str	r8, [sp,#-4]!	
	ldr	r0, =coin
	mov	r1, r5
	mov	r2, r6
	mov	r3, r7
	bl	printf
	ldr	r10, [sp,#4]!

	add	r9, r9, r5

	add	r0, r6, r6, lsl #2
	add	r9, r9, r0

	add	r0, r7, r7, lsl #2
	lsl	r0, r0, #1
	add	r9, r9, r0

	add	r0, r8, r8, lsl #2
	add	r0, r0, r0, lsl #2
	add	r9, r9, r0

	mov	r8, #656
	mul	r10, r9, r8
	lsr	r10, #16
	mov	r8, #100
	mul	r8, r10, r8
	sub	r7, r9, r8
	
	ldr	r0, =total
	mov	r1, r10
	mov	r2, r7
	bl	printf

	lsr	r6, r9, #2
	mov	r8, #656
	mul	r10, r6, r8
	lsr	r10, #16
	mov	r8, #100
	mul	r8, r10, r8
	sub	r7, r6, r8

	ldr	r0, =avrge
	mov	r1, r10
	mov	r2, r7
	bl	printf

	lsl	r8, r9, #2
	add	r6, r8, r8, lsl #1
	add	r6, r9, r6
	mov	r8, #656
	mul	r10, r6, r8
	lsr	r10, #16
	mov	r8, #100
	mul	r8, r10, r8
	sub	r7, r6, r8

	ldr	r0, =avrge
	mov	r1, r10
	mov	r2, r7
	bl	printf

	ldmfd	sp!, {r4-r10,lr}
	mov	r0, $0
	mov	pc, lr
