
anon_member_designated_init.aarch64:	file format elf64-littleaarch64

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

<opaque>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xc0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x70]
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x88]
               	mov	x0, #0x10               // =16
               	stur	x0, [x29, #-0x80]
               	sub	x0, x29, #0x70
               	stur	x0, [x29, #-0x78]
               	ldursw	x20, [x29, #-0x88]
               	ldur	x21, [x29, #-0x78]
               	ldur	x22, [x29, #-0x80]
               	sub	x0, x29, #0x18
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	w20, [x0]
               	str	x21, [x0, #0x8]
               	str	x22, [x0, #0x10]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, w20
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x21
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x10]
               	cmp	x0, x22
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x68
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	sub	x1, x29, #0x70
               	str	x1, [x0, #0x8]
               	mov	x1, #0x8                // =8
               	str	x1, [x0, #0x10]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	sub	x2, x29, #0x70
               	cmp	x1, x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x10]
               	mov	x1, #0x9                // =9
               	str	w1, [x0, #0x18]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	sub	x2, x29, #0x70
               	cmp	x1, x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	cmp	x1, #0x4
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x18]
               	cmp	w0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2a
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
