
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

<lane>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	mov	x1, x0
               	sxtw	x1, w1
               	sub	x0, x29, #0x20
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x530
               	sub	x2, x29, #0x530
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x520
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x4, x29, #0x510
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	sub	x0, x29, #0x500
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	add	x2, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x2, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x2]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x500
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x10              // =16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x500
               	add	x0, x0, #0x10
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x500
               	add	x0, x0, #0x10
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x500
               	add	x0, x0, #0x20
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x500
               	add	x0, x0, #0x20
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x38              // =56
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	sub	x2, x29, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	sub	x2, x29, #0x520
               	add	x3, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	sub	x2, x29, #0x510
               	add	x3, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x10              // =16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x4d0
               	add	x0, x0, #0x10
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x4d0
               	add	x0, x0, #0x10
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x4d0
               	add	x0, x0, #0x20
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x4d0
               	add	x0, x0, #0x20
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x38              // =56
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x4a0
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	sub	x2, x29, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	sub	x2, x29, #0x520
               	add	x3, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	sub	x2, x29, #0x510
               	add	x3, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x4a0
               	add	x0, x0, #0x20
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x38              // =56
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	sub	x2, x29, #0x510
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x470
               	add	x0, x0, #0x10
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x470
               	add	x0, x0, #0x20
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x440
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	str	x2, [x0, #0x10]
               	str	x2, [x0, #0x18]
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
               	sub	x1, x29, #0x520
               	add	x3, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	ldr	q0, [x0]
               	mov	x0, x2
               	bl	<addr>
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x440
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x440
               	add	x0, x0, #0x10
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x440
               	add	x0, x0, #0x10
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
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
               	sub	x1, x29, #0x530
               	add	x2, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x1, #0x7                // =7
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x420
               	add	x0, x0, #0x10
               	mov	x1, #0x7                // =7
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x400
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	sub	x2, x29, #0x530
               	add	x3, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	sub	x2, x29, #0x520
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x400
               	add	x0, x0, #0x20
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x400
               	add	x0, x0, #0x10
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x400
               	add	x0, x0, #0x10
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x3d0
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	sub	x2, x29, #0x510
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	add	x2, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x2, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x3d0
               	add	x0, x0, #0x10
               	mov	x1, #0x9                // =9
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x32              // =50
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x3d0
               	add	x0, x0, #0x20
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x38              // =56
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x3a0
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	sub	x2, x29, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x0
               	sub	x3, x29, #0x520
               	add	x4, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	sub	x3, x29, #0x510
               	add	x4, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	add	x3, x0, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x3a0
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x10
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x15              // =21
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x3a0
               	add	x0, x0, #0x20
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x3a0
               	add	x0, x0, #0x30
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x10              // =16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x360
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	x1, [x0, #0x40]
               	str	x1, [x0, #0x48]
               	str	x1, [x0, #0x50]
               	str	x1, [x0, #0x58]
               	sub	x2, x29, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x0
               	sub	x3, x29, #0x520
               	add	x4, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x510
               	add	x5, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x5]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x5, x0, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x5]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x5
               	add	x4, x0, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	add	x3, x0, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x360
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x20
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x360
               	add	x0, x0, #0x30
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x360
               	add	x0, x0, #0x50
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x300
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	sub	x2, x29, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	mov	x2, #0x5                // =5
               	str	w2, [x0, #0x10]
               	sub	x2, x29, #0x520
               	add	x3, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x30]
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x300
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x5
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x20
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x24              // =36
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x300
               	ldrsw	x0, [x0, #0x30]
               	cmp	w0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2c0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x2c0
               	add	x0, x0, #0x10
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	mov	x1, #0x0                // =0
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xf                // =15
               	ldr	q0, [x0]
               	mov	x0, x1
               	bl	<addr>
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x530
               	ldp	x29, x30, [sp], #0x10
               	ret
