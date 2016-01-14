	.data
n:	.word	0
strin:	.asciz	"%d"
strout:	.asciz	"%d\n"
	.align	3
last:	.asciz	"There are %d prime numbers less than %d\n"
strprt:	.asciz	"Enter a positive integer greater than 1:"


	.text
	.global main

	@@This function finds if a given number is prime
	@@loops to check each value of
	@@2 or greater to see if it n
	@@is a multiple of it. Ends when
	@@r2 is greater than half of n.
	@@Returns 1 in r4 if prime, and 0 in r4 if not.

isprme:	stmfd	sp!, {lr}
	lsr	r6, r7, #1	@moves m/2 into r6
	mov	r9, #2		@starts divisor at 2
	mov	r4, #1		@sets prime til found to not be
primlp:	cmp	r6, r9		@start of loop
	blt	prmend
	mov	r0, r7
	mov	r1, r9
	bl	udiv32		@professor provided division
	cmp	r1, #0		@function. It returns the value
	moveq	r4, #0		@in r0 and the remainder in r1.
	beq	prmend
	add	r9, r9, #1
	b	primlp
prmend:	ldmfd	sp!, {lr}
	mov	pc, lr

main:	stmfd sp!, {r4-r9,lr}

	ldr	r0, =strprt	@promts for input
	bl	printf

	ldr	r0, =strin	@grabs input
	ldr	r1, =n
	bl	scanf

	ldr	r5, =n		@loads input for isprme funtion
	ldr	r5, [r5]
	mov	r7, #2		@the first number m to check if prime
	mov	r8, #0		@tracks number of primes

alprm:	cmp	r7, r5		@loops through all #s less than n
	bge	alend		@to check if they are prime
	bl	isprme		@and counts all primes
	cmp	r4, #1
	addeq	r8, r8, #1
	ldreq	r0, =strout
	moveq	r1, r7
	bleq	printf
	add	r7, r7, #1
	b	alprm
alend:	ldr	r0, =last
	mov	r1, r8
	mov	r2, r5
	bl	printf

	ldmfd sp!, {r4-r9,lr}
	mov	r0, $0
	mov	pc, lr
	.end
	
