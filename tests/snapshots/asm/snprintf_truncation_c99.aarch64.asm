
snprintf_truncation_c99.aarch64:	file format elf64-littleaarch64

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

<wrap>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x20, [sp, #-0x50]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x20, x29, #0x20
               	add	x0, x29, #0x20
               	mov	x16, x20
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	ldur	x0, [x29, #0x10]
               	ldursw	x1, [x29, #0x18]
               	ldur	x2, [x29, #0x20]
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x20, x29, #0x8
               	mov	x21, #0x41              // =65
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x1, #0x4                // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0xe240             // =57920
               	movk	x3, #0x1, lsl #16
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	sub	x20, x29, #0x8
               	mov	x21, #0x4               // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x1206             // =4614
               	movk	x3, #0xf, lsl #16
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x1, #0x8                // =8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2a               // =42
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	b	<addr>
