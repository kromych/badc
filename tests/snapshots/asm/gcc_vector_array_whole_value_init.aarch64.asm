
gcc_vector_array_whole_value_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	sub	x1, x29, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x4, x0, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	add	x5, x0, #0x20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	ldrb	w6, [x0]
               	eor	x6, x6, #0x1
               	cbnz	w6, <addr>
               	ldrb	w0, [x0, #0xf]
               	eor	x0, x0, #0x10
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x4]
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x4, #0xf]
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x5]
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x5, #0xf]
               	eor	x0, x0, #0x38
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x4, x0, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	add	x5, x0, #0x20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	ldrb	w6, [x0]
               	eor	x6, x6, #0x1
               	cbnz	w6, <addr>
               	ldrb	w0, [x0, #0xf]
               	eor	x0, x0, #0x10
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x4]
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x4, #0xf]
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x5]
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x5, #0xf]
               	eor	x0, x0, #0x38
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x1, x0, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x1, x0, #0x20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldrb	w0, [x0]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0xf]
               	eor	x0, x0, #0x38
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	mov	x1, #0x7                // =7
               	strb	w1, [x0]
               	strb	w1, [x0, #0x1]
               	strb	w1, [x0, #0x2]
               	strb	w1, [x0, #0x3]
               	strb	w1, [x0, #0x4]
               	strb	w1, [x0, #0x5]
               	strb	w1, [x0, #0x6]
               	strb	w1, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w1, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	strb	w1, [x0, #0xc]
               	strb	w1, [x0, #0xd]
               	strb	w1, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	add	x1, x0, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldrb	w0, [x0]
               	eor	x0, x0, #0x7
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x60
               	ldrb	w1, [x0, #0xf]
               	eor	x1, x1, #0x7
               	cbz	w1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x10
               	ldrb	w1, [x0]
               	mov	x17, #0x15              // =21
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	strb	w1, [x0, #0x1]
               	strb	w1, [x0, #0x2]
               	strb	w1, [x0, #0x3]
               	strb	w1, [x0, #0x4]
               	strb	w1, [x0, #0x5]
               	strb	w1, [x0, #0x6]
               	strb	w1, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w1, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	strb	w1, [x0, #0xc]
               	strb	w1, [x0, #0xd]
               	strb	w1, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x90
               	add	x2, x0, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrb	w0, [x0, #0x7]
               	eor	x0, x0, #0x3
               	cbnz	w0, <addr>
               	ldrb	w0, [x2, #0x7]
               	eor	x0, x0, #0x8
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	add	x3, x0, #0x20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x2, x29, #0x80
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x3]
               	eor	x0, x0, #0x1
               	cbz	w0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	sub	x3, x29, #0x70
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	add	x4, x0, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	add	x5, x0, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x5]
               	ldrb	w0, [x0]
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x4, #0x9]
               	mov	x17, #0x32              // =50
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x5, #0xf]
               	eor	x0, x0, #0x38
               	cbz	w0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x4, x0, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	add	x5, x0, #0x20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x6, x0, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x6]
               	ldrb	w0, [x0]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	ldrb	w0, [x4]
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x5]
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x6, #0xf]
               	eor	x0, x0, #0x10
               	cbz	w0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x4, x0, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	add	x4, x0, #0x20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x4]
               	add	x5, x0, #0x30
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x3, x0, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	add	x2, x0, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrb	w0, [x0]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	ldrb	w0, [x4]
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x5]
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x2]
               	eor	x0, x0, #0x1
               	cbz	w0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x10]
               	sub	x2, x29, #0x80
               	add	x1, x0, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x30]
               	ldrb	w2, [x0]
               	eor	x2, x2, #0x1
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1, #0xf]
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x10
               	ldrb	w1, [x1]
               	mov	x17, #0x9               // =9
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0xf]
               	cbz	w0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
