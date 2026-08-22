
runtime_anon_struct_init.aarch64:	file format elf64-littleaarch64

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

<check_anon_struct>:
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x22, x0
               	mov	x23, x1
               	sub	x1, x29, #0x20
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	mov	x21, #0x1               // =1
               	sub	x1, x29, #0x20
               	str	w21, [x1]
               	sub	x1, x29, #0x20
               	str	x22, [x1, #0x8]
               	sub	x1, x29, #0x20
               	str	x23, [x1, #0x10]
               	mov	x2, #0x7                // =7
               	sub	x1, x29, #0x20
               	str	w2, [x1, #0x18]
               	sub	x1, x29, #0x40
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0x40
               	str	w0, [x1]
               	sub	x0, x29, #0x40
               	str	x22, [x0, #0x8]
               	sub	x0, x29, #0x40
               	str	x23, [x0, #0x10]
               	mov	x1, #0x8                // =8
               	sub	x0, x29, #0x40
               	str	w1, [x0, #0x18]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	bl	<addr>
               	ldrsw	x1, [x20]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x20, #0x8]
               	cmp	x1, x22
               	cset	x21, ne
               	mov	x1, #0x1                // =1
               	cbnz	x21, <addr>
               	ldr	x1, [x20, #0x10]
               	cmp	x1, x23
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x20, #0x18]
               	cmp	x1, #0x7
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	ldrsw	x1, [x0]
               	cmp	x1, #0x2
               	mov	x2, #0x1                // =1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x22
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldr	x1, [x0, #0x10]
               	cmp	x1, x23
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x8
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_nested>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x21, x0
               	mov	x22, x1
               	sub	x0, x29, #0x28
               	mov	x20, #0x0               // =0
               	str	x20, [x0]
               	str	x20, [x0, #0x8]
               	str	x20, [x0, #0x10]
               	str	x20, [x0, #0x18]
               	str	x20, [x0, #0x20]
               	mov	x0, #0x9                // =9
               	sub	x1, x29, #0x28
               	str	w0, [x1]
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x28
               	str	x21, [x0, #0x10]
               	sub	x0, x29, #0x28
               	str	x22, [x0, #0x18]
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x28
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x9
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x4
               	cset	x20, eq
               	mov	x2, #0x0                // =0
               	cbz	x20, <addr>
               	ldr	x1, [x0, #0x10]
               	cmp	x1, x21
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldr	x1, [x0, #0x18]
               	cmp	x1, x22
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x5
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x4                // =4
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x10               // =16
               	stur	x0, [x29, #-0x18]
               	ldur	x20, [x29, #-0x20]
               	ldur	x1, [x29, #-0x18]
               	mov	x0, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0x10
               	str	w0, [x1]
               	sub	x0, x29, #0x10
               	str	x20, [x0, #0x8]
               	sub	x0, x29, #0x10
               	bl	<addr>
               	mov	x1, x0
               	ldrsw	x0, [x1]
               	cmp	x0, #0x3
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldr	x0, [x1, #0x8]
               	cmp	x0, x20
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x18               // =24
               	stur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x18]
               	mov	x0, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	b	<addr>
