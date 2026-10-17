
overaligned_automatic_beside_sp_read.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	mov	x1, #0xa                // =10
               	strb	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0xa
               	str	w1, [x0]
               	ret

<reads_sp>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x0, sp
               	mov	x1, #0x3                // =3
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x16, x29, #0x8
               	stur	x16, [x29, #-0x30]
               	mov	x0, sp
               	ldur	x16, [x29, #-0x30]
               	str	x0, [x16]
               	stur	x19, [x29, #-0x20]
               	mov	x19, xzr
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	mov	x26, xzr
               	mov	x27, xzr
               	mov	x28, xzr
               	ldur	x19, [x29, #-0x20]
               	mov	x0, sp
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	mov	x0, sp
               	ldur	x2, [x29, #-0x8]
               	and	x1, x0, #0x3f
               	cmp	w1, #0x0
               	cset	x1, ne
               	ldrb	w3, [sp, #0x3f]
               	eor	x3, x3, #0x3
               	cmp	w3, #0x0
               	cset	x3, ne
               	orr	x3, x1, x3, lsl #1
               	cmp	x0, x2
               	mov	x1, #0x1                // =1
               	b.lo	<addr>
               	sub	x0, x0, x2
               	mov	x17, #0x1000            // =4096
               	cmp	x0, x17
               	cset	x1, hi
               	orr	x0, x3, x1, lsl #2
               	sub	sp, x29, #0x80
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<reads_sp_inlined>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x0, sp
               	mov	x1, #0x3                // =3
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	stur	x19, [x29, #-0x30]
               	mov	x19, xzr
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	mov	x26, xzr
               	mov	x27, xzr
               	mov	x28, xzr
               	ldur	x19, [x29, #-0x30]
               	sub	x16, x29, #0x8
               	stur	x16, [x29, #-0x20]
               	mov	x0, sp
               	ldur	x16, [x29, #-0x20]
               	str	x0, [x16]
               	ldur	x20, [x29, #-0x8]
               	mov	x0, sp
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	mov	x0, sp
               	and	x1, x0, #0x3f
               	cmp	w1, #0x0
               	cset	x1, ne
               	ldrb	w2, [sp, #0x3f]
               	eor	x2, x2, #0x3
               	cmp	w2, #0x0
               	cset	x2, ne
               	orr	x2, x1, x2, lsl #1
               	cmp	x0, x20
               	mov	x1, #0x1                // =1
               	b.lo	<addr>
               	sub	x0, x0, x20
               	mov	x17, #0x1000            // =4096
               	cmp	x0, x17
               	cset	x1, hi
               	orr	x0, x2, x1, lsl #2
               	sub	sp, x29, #0x80
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
