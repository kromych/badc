
posix_timers_and_conversion.aarch64:	file format elf64-littleaarch64

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

<doubled>:
               	add	x0, x0, x0
               	sxtw	x0, w0
               	ret

<declared_only>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x180
               	str	x20, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x15               // =21
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x29               // =41
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x170
               	str	w0, [x17]
               	sub	x0, x29, #0x170
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x170
               	ldr	w0, [x16]
               	cmp	w0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x168
               	mov	x1, #0x7a               // =122
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x168
               	ldrb	w0, [x0]
               	mov	x17, #0x7a              // =122
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x160
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x160
               	bl	<addr>
               	cbz	x0, <addr>
               	ldrb	w0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x160
               	ldrsw	x1, [x0, #0x14]
               	cmp	w1, #0x7c
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x20, x17
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x128
               	mov	x1, #0x68               // =104
               	strb	w1, [x0]
               	mov	x1, #0x69               // =105
               	strb	w1, [x0, #0x1]
               	sub	x17, x29, #0x118
               	str	x0, [x17]
               	sub	x0, x29, #0x120
               	sub	x17, x29, #0x110
               	str	x0, [x17]
               	mov	x0, #0x2                // =2
               	sub	x17, x29, #0x108
               	str	x0, [x17]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x100]
               	sub	x1, x29, #0x118
               	sub	x2, x29, #0x108
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x108
               	ldr	x0, [x16]
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x100]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x120
               	ldrb	w1, [x0]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xf8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x1, x29, #0xf8
               	mov	x0, #0x1                // =1
               	str	w0, [x1, #0xc]
               	sub	x2, x29, #0xb8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xb0
               	mov	x1, #0x0                // =0
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	mov	x0, #0xe10              // =3600
               	str	x0, [x2, #0x10]
               	str	x1, [x2, #0x18]
               	ldur	x0, [x29, #-0xb8]
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x90
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	ldur	x0, [x29, #-0xb8]
               	sub	x1, x29, #0x90
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x90
               	ldr	x1, [x0, #0x10]
               	cmp	x1, #0x0
               	b.le	<addr>
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0xe10
               	b.le	<addr>
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0xb8]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0xb8]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x1, [x0]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	ldr	x1, [x0, #0x20]
               	cbz	x1, <addr>
               	ldr	w0, [x0, #0x68]
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.lt	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x20, x0
               	b.ge	<addr>
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfa               // =250
               	bl	<addr>
               	mov	x20, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x20, x17
               	b.eq	<addr>
               	mov	x0, #0xf9               // =249
               	bl	<addr>
               	cmp	x20, x0
               	b.ge	<addr>
               	mov	x0, #0x18               // =24
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
