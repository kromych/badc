
overaligned_automatic_beside_callee_saved_clobbers.aarch64:	file format elf64-littleaarch64

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
               	and	x2, x1, #0xff
               	strb	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x1, x2, x1
               	str	w1, [x0]
               	ret

<beside_vla>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	stp	x21, x22, [sp]
               	stp	x23, x24, [sp, #0x10]
               	stp	x25, x26, [sp, #0x20]
               	stp	x27, x28, [sp, #0x30]
               	str	x20, [sp, #0x40]
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x20, sp
               	add	x0, x20, #0x0
               	mov	x1, #0x3                // =3
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	mov	x2, #0xa                // =10
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x16, sp
               	sub	x16, x16, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x16
               	stur	x16, [x29, #-0x18]
               	mov	x1, #0x4                // =4
               	ldur	x0, [x29, #-0x18]
               	bl	<addr>
               	mov	x1, #0xa                // =10
               	ldur	x0, [x29, #-0x18]
               	bl	<addr>
               	stur	x20, [x29, #-0x30]
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	mov	x26, xzr
               	mov	x27, xzr
               	mov	x28, xzr
               	ldur	x20, [x29, #-0x30]
               	add	x0, x20, #0x0
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	add	x0, x20, #0x0
               	and	x0, x0, #0x3f
               	cmp	w0, #0x0
               	cset	x0, ne
               	ldrb	w1, [x20, #0x3f]
               	eor	x1, x1, #0x3
               	cmp	w1, #0x0
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #1
               	ldur	x16, [x29, #-0x18]
               	ldrb	w1, [x16, #0x9]
               	eor	x1, x1, #0x4
               	cmp	w1, #0x0
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #2
               	sub	sp, x29, #0x80
               	ldr	x20, [sp, #0x40]
               	ldp	x27, x28, [sp, #0x30]
               	ldp	x25, x26, [sp, #0x20]
               	ldp	x23, x24, [sp, #0x10]
               	ldp	x21, x22, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<output_after_the_writes>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	stp	x21, x22, [sp]
               	stp	x23, x24, [sp, #0x10]
               	stp	x25, x26, [sp, #0x20]
               	stp	x27, x28, [sp, #0x30]
               	str	x20, [sp, #0x40]
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffff80
               	mov	x20, sp
               	mov	x2, #0xa                // =10
               	mov	x0, #0x5                // =5
               	str	x0, [x20, #0x40]
               	add	x0, x20, #0x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x16, sp
               	sub	x16, x16, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x16
               	stur	x16, [x29, #-0x18]
               	mov	x1, #0x6                // =6
               	ldur	x0, [x29, #-0x18]
               	bl	<addr>
               	mov	x1, #0xa                // =10
               	ldur	x0, [x29, #-0x18]
               	bl	<addr>
               	stur	x20, [x29, #-0x30]
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	mov	x26, xzr
               	mov	x27, xzr
               	mov	x28, xzr
               	mov	x0, #0x4d               // =77
               	ldur	x20, [x29, #-0x30]
               	str	x0, [x20, #0x40]
               	add	x0, x20, #0x0
               	add	x1, x0, #0x10
               	stur	x20, [x29, #-0x28]
               	stur	x1, [x29, #-0x30]
               	mov	x20, xzr
               	mov	x21, xzr
               	mov	x22, xzr
               	mov	x23, xzr
               	mov	x24, xzr
               	mov	x25, xzr
               	mov	x26, xzr
               	mov	x27, xzr
               	mov	x28, xzr
               	mov	x0, #0x4d               // =77
               	ldur	x16, [x29, #-0x30]
               	str	x0, [x16]
               	ldur	x20, [x29, #-0x28]
               	add	x0, x20, #0x40
               	and	x0, x0, #0x3f
               	cmp	w0, #0x0
               	cset	x0, ne
               	add	x1, x20, #0x0
               	and	x1, x1, #0x7f
               	cmp	w1, #0x0
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #1
               	ldr	x1, [x20, #0x40]
               	cmp	x1, #0x4d
               	cset	x1, ne
               	orr	x1, x0, x1, lsl #2
               	ldr	x0, [x20, #0x10]
               	cmp	x0, #0x4d
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldr	x0, [x20, #0x18]
               	cmp	x0, #0x4
               	cset	x0, ne
               	orr	x0, x1, x0, lsl #3
               	ldur	x16, [x29, #-0x18]
               	ldrb	w1, [x16, #0x9]
               	eor	x1, x1, #0x6
               	cmp	w1, #0x0
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	sub	sp, x29, #0x80
               	ldr	x20, [sp, #0x40]
               	ldp	x27, x28, [sp, #0x30]
               	ldp	x25, x26, [sp, #0x20]
               	ldp	x23, x24, [sp, #0x10]
               	ldp	x21, x22, [sp]
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
