
anon_union_braced_init.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0xa0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x50]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	stur	x20, [x29, #-0x48]
               	ldursw	x21, [x29, #-0x50]
               	ldur	x22, [x29, #-0x48]
               	sub	x0, x29, #0x60
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	w21, [x0]
               	str	x22, [x0, #0x8]
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, x1
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, w21
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x22
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	str	x20, [x0, #0x8]
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, x1
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x20
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x8]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2a
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x63
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	str	x20, [x0, #0x8]
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x0, x1
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x20
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
