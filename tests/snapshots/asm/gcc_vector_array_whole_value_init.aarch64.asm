
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
               	sub	sp, sp, #0x4d0
               	sub	x4, x29, #0x4d0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x4c0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x5, x29, #0x4b0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x5]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x4a0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x1, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x3, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x5]
               	str	x10, [x3]
               	ldr	x10, [x5, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w6, [x0]
               	eor	x6, x6, #0x1
               	cbnz	w6, <addr>
               	ldrb	w6, [x0, #0xf]
               	eor	x6, x6, #0x10
               	cbz	w6, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w6, [x1]
               	mov	x17, #0x15              // =21
               	eor	x6, x6, x17
               	cbnz	w6, <addr>
               	ldrb	w1, [x1, #0xf]
               	mov	x17, #0x24              // =36
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x3]
               	mov	x17, #0x29              // =41
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x3, #0xf]
               	eor	x0, x0, #0x38
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x1, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x3, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x5]
               	str	x10, [x3]
               	ldr	x10, [x5, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w6, [x0]
               	eor	x6, x6, #0x1
               	cbnz	w6, <addr>
               	ldrb	w6, [x0, #0xf]
               	eor	x6, x6, #0x10
               	cbz	w6, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w6, [x1]
               	mov	x17, #0x15              // =21
               	eor	x6, x6, x17
               	cbnz	w6, <addr>
               	ldrb	w1, [x1, #0xf]
               	mov	x17, #0x24              // =36
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x3]
               	mov	x17, #0x29              // =41
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x3, #0xf]
               	eor	x0, x0, #0x38
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x440
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x1, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x1, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x5]
               	str	x10, [x1]
               	ldr	x10, [x5, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w3, [x0]
               	eor	x3, x3, #0x1
               	cbnz	w3, <addr>
               	ldrb	w0, [x1, #0xf]
               	eor	x0, x0, #0x38
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x3e0
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
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w0, [x0]
               	eor	x0, x0, #0x7
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x3e0
               	ldrb	w1, [x0, #0xf]
               	eor	x1, x1, #0x7
               	cbz	w1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x10
               	ldrb	w2, [x1]
               	mov	x17, #0x15              // =21
               	eor	x2, x2, x17
               	cbnz	w2, <addr>
               	ldrb	w0, [x1, #0xf]
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x3c0
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
               	sub	x1, x29, #0x4d0
               	add	x2, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w3, [x0, #0x7]
               	eor	x3, x3, #0x3
               	cbnz	w3, <addr>
               	ldrb	w0, [x2, #0x7]
               	eor	x0, x0, #0x8
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x3a0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	add	x3, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x4c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w4, [x0]
               	mov	x17, #0x15              // =21
               	eor	x4, x4, x17
               	cbnz	w4, <addr>
               	ldrb	w0, [x3]
               	eor	x0, x0, #0x1
               	cbz	w0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x370
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	sub	x3, x29, #0x4b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x4, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x5, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x5]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w6, [x0]
               	mov	x17, #0x29              // =41
               	eor	x6, x6, x17
               	cbnz	w6, <addr>
               	ldrb	w4, [x4, #0x9]
               	mov	x17, #0x32              // =50
               	eor	x4, x4, x17
               	cbnz	w4, <addr>
               	ldrb	w0, [x5, #0xf]
               	eor	x0, x0, #0x38
               	cbz	w0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x340
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x4, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x4]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x5, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x5]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x6, x0, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x6]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w7, [x0]
               	eor	x7, x7, #0x1
               	cbnz	w7, <addr>
               	ldrb	w4, [x4]
               	mov	x17, #0x15              // =21
               	eor	x4, x4, x17
               	cbz	w4, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w4, [x5]
               	mov	x17, #0x29              // =41
               	eor	x4, x4, x17
               	cbnz	w4, <addr>
               	ldrb	w0, [x6, #0xf]
               	eor	x0, x0, #0x10
               	cbz	w0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x300
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x4, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x4]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x4, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x5, x0, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x5]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x3, x0, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x2, x0, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrb	w3, [x0]
               	eor	x3, x3, #0x1
               	cbnz	w3, <addr>
               	ldrb	w3, [x4]
               	mov	x17, #0x29              // =41
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w3, [x5]
               	mov	x17, #0x29              // =41
               	eor	x3, x3, x17
               	cbnz	w3, <addr>
               	ldrb	w0, [x2]
               	eor	x0, x0, #0x1
               	cbz	w0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2a0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x10]
               	sub	x2, x29, #0x4c0
               	add	x1, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x30]
               	ldrb	w2, [x0]
               	eor	x2, x2, #0x1
               	cbnz	w2, <addr>
               	ldrsw	x2, [x0, #0x10]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1, #0xf]
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldrb	w0, [x0]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0xf]
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
