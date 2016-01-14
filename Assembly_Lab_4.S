	.data
buffer:	.skip	4096
Prompt:	.asciz	"Enter text (ctrl-D to end)\n"
Outstr:	.asciz	"\nThe checksum is %08X\n"
inForm:	.asciz	"\n%c"
max:	.word	4096

	.text
	.global main
chksum: mov     r7, #0
        mov     r1, #0

chklp:	ldr     r0, =buffer
        ldrb    r0, [r0,r7]
        add     r1, r1, r0
        add     r7, r7, #1
        cmp     r0, #0
        bne     chklp
        mov     pc, lr

main:	stmfd	sp!, {lr}

	ldr r0, =Prompt
	bl printf

	mov	r7, #0

loop:	bl	getchar
	ldr     r1, =buffer
	strb	r0, [r1, r7]
	add	r7, r7, #1
	cmp	r0, #-1
	beq	next1
	ldr	r8, =max
	ldr	r8, [r8]
	cmp	r7, r8
	beq	next1
	b loop

next1:	ldr	r0, =buffer
	mov	r3, #0
	strb	r3, [r0, r7]
	mov	r7, #0

	bl	chksum
	ldr	r0, =Outstr
	bl	printf

	bl	chksum
        ldr     r0, =Outstr
        bl      printf

	ldmfd	sp!, {lr}
	mov	r0, $0
	mov	pc, lr
