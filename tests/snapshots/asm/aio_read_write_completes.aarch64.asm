
aio_read_write_completes.aarch64:	file format elf64-littleaarch64

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

<finish>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, x0
               	mov	x23, x1
               	sub	x21, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	sub	x22, x29, #0x18
               	stur	x20, [x29, #-0x18]
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x22
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x73
               	b.eq	<addr>
               	mov	x2, #0x1                // =1
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, x23
               	cset	x2, ne
               	mov	x0, x2
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2f0
               	str	x20, [sp]
               	sub	x0, x29, #0x2b8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldrb	w16, [x1, #0x14]
               	strb	w16, [x0, #0x14]
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2b8
               	bl	<addr>
               	sub	x0, x29, #0x1f8
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa8               // =168
               	bl	<addr>
               	sub	x0, x29, #0x1f8
               	str	w20, [sp, #0xf8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [sp, #0x108]
               	mov	x1, #0xc                // =12
               	str	x1, [sp, #0x110]
               	str	xzr, [sp, #0x178]
               	mov	x1, #0x1                // =1
               	str	w1, [sp, #0x124]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1f8
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa8               // =168
               	bl	<addr>
               	sub	x0, x29, #0x150
               	str	w20, [sp, #0x1a0]
               	sub	x1, x29, #0x2d8
               	str	x1, [sp, #0x1b0]
               	mov	x1, #0x8                // =8
               	str	x1, [sp, #0x1b8]
               	stur	xzr, [x29, #-0xd0]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x2d8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa8               // =168
               	bl	<addr>
               	stur	w20, [x29, #-0xa8]
               	sub	x0, x29, #0x2d0
               	stur	x0, [x29, #-0x98]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x90]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x28]
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0xa4]
               	sub	x0, x29, #0x2a0
               	mov	x2, #0xa8               // =168
               	bl	<addr>
               	sub	x3, x29, #0x2a0
               	str	w20, [sp, #0x50]
               	mov	x2, #0x2                // =2
               	str	w2, [sp, #0x54]
               	sub	x1, x29, #0x2c8
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0xa8
               	str	x4, [sp, #0x28]
               	str	x3, [sp, #0x30]
               	mov	x3, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	sub	x0, x29, #0x2d0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1000             // =4096
               	movk	x0, #0x10, lsl #16
               	sub	x1, x29, #0x1f8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1f8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2a0
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x2f0
               	ldp	x29, x30, [sp], #0x10
               	ret
