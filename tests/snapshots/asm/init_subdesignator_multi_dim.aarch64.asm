
init_subdesignator_multi_dim.aarch64:	file format elf64-littleaarch64

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

<check>:
               	mov	x1, #0x0                // =0
               	ldrh	w2, [x0]
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrh	w1, [x0, #0x2]
               	mov	x17, #0x2               // =2
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrh	w1, [x0, #0xa]
               	mov	x17, #0x7               // =7
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0x24]
               	cmp	x1, #0x5
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrsw	x1, [x0, #0x2c]
               	cmp	x1, #0x6
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0x98]
               	cmp	x1, #0x9
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrh	w1, [x0, #0x6]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0x18]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x1, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x0, [x0, #0x3c]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	sxtw	x0, w1
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1f0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x0, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x2, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x2, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x2, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x2, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x2, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x2, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x2, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x2, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x2, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x2, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [x2, #0x80]
               	str	x10, [x0, #0x80]
               	ldr	x10, [x2, #0x88]
               	str	x10, [x0, #0x88]
               	ldr	x10, [x2, #0x90]
               	str	x10, [x0, #0x90]
               	ldrb	w10, [x2, #0x98]
               	strb	w10, [x0, #0x98]
               	ldrb	w10, [x2, #0x99]
               	strb	w10, [x0, #0x99]
               	ldrb	w10, [x2, #0x9a]
               	strb	w10, [x0, #0x9a]
               	ldrb	w10, [x2, #0x9b]
               	strb	w10, [x0, #0x9b]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x140
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
               	str	x1, [x0, #0x60]
               	str	x1, [x0, #0x68]
               	str	x1, [x0, #0x70]
               	str	x1, [x0, #0x78]
               	str	x1, [x0, #0x80]
               	str	x1, [x0, #0x88]
               	str	x1, [x0, #0x90]
               	str	w1, [x0, #0x98]
               	sub	x0, x29, #0xa0
               	ldrh	w0, [x0]
               	sub	x1, x29, #0x140
               	strh	w0, [x1]
               	sub	x0, x29, #0xa0
               	ldrh	w1, [x0, #0x2]
               	sub	x0, x29, #0x140
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0xa0
               	ldrh	w1, [x0, #0xa]
               	sub	x0, x29, #0x140
               	strh	w1, [x0, #0xa]
               	sub	x0, x29, #0xa0
               	ldrsw	x1, [x0, #0x24]
               	sub	x0, x29, #0x140
               	str	w1, [x0, #0x24]
               	sub	x0, x29, #0xa0
               	ldrsw	x1, [x0, #0x2c]
               	sub	x0, x29, #0x140
               	str	w1, [x0, #0x2c]
               	sub	x0, x29, #0xa0
               	ldrsw	x1, [x0, #0x98]
               	sub	x0, x29, #0x140
               	str	w1, [x0, #0x98]
               	sub	x0, x29, #0x1e0
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
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x1, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x1, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x1, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x1, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x1, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x1, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [x1, #0x80]
               	str	x10, [x0, #0x80]
               	ldr	x10, [x1, #0x88]
               	str	x10, [x0, #0x88]
               	ldr	x10, [x1, #0x90]
               	str	x10, [x0, #0x90]
               	ldrb	w10, [x1, #0x98]
               	strb	w10, [x0, #0x98]
               	ldrb	w10, [x1, #0x99]
               	strb	w10, [x0, #0x99]
               	ldrb	w10, [x1, #0x9a]
               	strb	w10, [x0, #0x9a]
               	ldrb	w10, [x1, #0x9b]
               	strb	w10, [x0, #0x9b]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x140
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x1f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1e0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x1f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	ldrsw	x0, [x0, #0x54]
               	cmp	x0, #0x4
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x6c]
               	cmp	x0, #0x3
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0, #0x8]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x98]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x1f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1f0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
