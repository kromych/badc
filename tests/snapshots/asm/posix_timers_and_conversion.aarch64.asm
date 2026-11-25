
posix_timers_and_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	ret

<declared_only>:
               	add	x0, x0, #0x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x180
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x15               // =21
               	blr	x1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	mov	x0, #0x29               // =41
               	blr	x1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
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
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [sp, #0x10]
               	sub	x0, x29, #0x170
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [sp, #0x10]
               	cmp	w0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
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
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [sp, #0x18]
               	cmp	w0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0xe8]
               	stur	xzr, [x29, #-0xe0]
               	stur	xzr, [x29, #-0xd8]
               	stur	xzr, [x29, #-0xd0]
               	stur	xzr, [x29, #-0xc8]
               	stur	xzr, [x29, #-0xc0]
               	stur	xzr, [x29, #-0xb8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0xe8
               	bl	<addr>
               	cbz	x0, <addr>
               	ldrb	w0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0xd4]
               	cmp	w0, #0x7c
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xd8]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xdc]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x5, x0
               	cmn	x5, #0x1
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x160
               	mov	x1, #0x6968             // =26984
               	strh	w1, [sp, #0x20]
               	str	x0, [sp, #0x30]
               	sub	x0, x29, #0x158
               	str	x0, [sp, #0x38]
               	mov	x0, #0x2                // =2
               	str	x0, [sp, #0x40]
               	mov	x0, #0x8                // =8
               	str	x0, [sp, #0x48]
               	str	x5, [sp]
               	mov	x0, x5
               	sub	x1, x29, #0x150
               	sub	x2, x29, #0x140
               	sub	x3, x29, #0x148
               	sub	x4, x29, #0x138
               	bl	<addr>
               	ldr	x5, [sp]
               	cmn	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp, #0x40]
               	cbnz	x0, <addr>
               	ldr	x0, [sp, #0x48]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [sp, #0x28]
               	cmp	w0, #0x68
               	b.ne	<addr>
               	ldrb	w0, [sp, #0x29]
               	cmp	w0, #0x69
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x5
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0xb0]
               	mov	x1, #0x100000000        // =4294967296
               	stur	xzr, [x29, #-0xa0]
               	stur	xzr, [x29, #-0x98]
               	stur	xzr, [x29, #-0x90]
               	stur	xzr, [x29, #-0x88]
               	stur	xzr, [x29, #-0x80]
               	stur	xzr, [x29, #-0x78]
               	stur	x1, [x29, #-0xa8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0xb0
               	sub	x2, x29, #0x130
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	x1, [sp, #0x58]
               	str	x1, [sp, #0x60]
               	mov	x0, #0xe10              // =3600
               	str	x0, [sp, #0x68]
               	str	x1, [sp, #0x70]
               	ldr	x0, [sp, #0x50]
               	mov	x3, x1
               	sub	x2, x29, #0x128
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	xzr, [sp, #0x78]
               	stur	xzr, [x29, #-0x100]
               	stur	xzr, [x29, #-0xf8]
               	stur	xzr, [x29, #-0xf0]
               	ldr	x0, [sp, #0x50]
               	sub	x1, x29, #0x108
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0xf8]
               	cmp	x0, #0x0
               	b.le	<addr>
               	cmp	x0, #0xe10
               	b.le	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp, #0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp, #0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x70]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	ldur	w0, [x29, #-0x8]
               	cbnz	w0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.lt	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	str	x0, [sp, #0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x16, [sp, #0x8]
               	cmp	x16, x0
               	b.ge	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfa               // =250
               	bl	<addr>
               	mov	x1, x0
               	cmn	x1, #0x1
               	b.eq	<addr>
               	str	x1, [sp]
               	mov	x0, #0xf9               // =249
               	bl	<addr>
               	ldr	x1, [sp]
               	cmp	x1, x0
               	b.ge	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
