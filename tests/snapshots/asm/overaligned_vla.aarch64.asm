
overaligned_vla.aarch64:	file format elf64-littleaarch64

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

<element_aligned>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x24, #0x0               // =0
               	mov	x20, #0x1               // =1
               	mov	x27, sp
               	mov	x17, #0x3               // =3
               	mul	x0, x20, x17
               	add	x0, x0, #0x1
               	sxtw	x21, w0
               	add	x17, x21, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x22, sp
               	sub	x22, x22, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x22
               	mov	x1, #0x5a               // =90
               	mov	x0, x22
               	mov	x2, x21
               	bl	<addr>
               	add	x0, x20, #0x3
               	lsl	x25, x0, #6
               	add	x0, x25, #0x30
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	add	x0, x0, #0x3f
               	and	x23, x0, #0xffffffffffffffc0
               	mov	x0, x23
               	mov	x2, x25
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	mov	x2, #0x60               // =96
               	mov	x0, #0x70               // =112
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	add	x0, x0, #0x1f
               	and	x26, x0, #0xffffffffffffffe0
               	add	x1, x20, #0x1
               	mov	x0, x26
               	bl	<addr>
               	and	x1, x23, #0x3f
               	mov	x0, #0x1                // =1
               	cbnz	w1, <addr>
               	add	x1, x23, #0x40
               	and	x1, x1, #0x3f
               	cmp	w1, #0x0
               	cset	x1, ne
               	orr	x2, x24, x1
               	and	x1, x26, #0x1f
               	cbnz	w1, <addr>
               	add	x1, x20, #0x3
               	lsl	x1, x1, #6
               	cmp	w25, w1
               	cset	x1, ne
               	orr	x2, x2, x1
               	add	x1, x20, #0x3
               	sub	x1, x1, #0x1
               	add	x1, x23, x1, lsl #6
               	ldrb	w1, [x1, #0x3f]
               	eor	x1, x1, x20
               	cbnz	w1, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x0, x21
               	b.hs	<addr>
               	ldrb	w1, [x22, x0]
               	cmp	w1, #0x5a
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	x0, x21
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x0
               	cset	x0, eq
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	orr	x24, x2, x0
               	mov	sp, x27
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.le	<addr>
               	mov	x0, x24
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret

<declaration_aligned>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x24, #0x0               // =0
               	mov	x21, #0x1               // =1
               	mov	x26, sp
               	mov	x17, #0x5               // =5
               	mul	x0, x21, x17
               	add	x0, x0, #0x1
               	sxtw	x20, w0
               	add	x17, x20, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x22, sp
               	sub	x22, x22, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x22
               	mov	x1, #0x5a               // =90
               	mov	x0, x22
               	mov	x2, x20
               	bl	<addr>
               	add	x25, x21, #0x3
               	add	x0, x25, #0x70
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	add	x0, x0, #0x7f
               	and	x23, x0, #0xffffffffffffff80
               	mov	x0, x23
               	mov	x2, x25
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	and	x1, x23, #0x7f
               	mov	x0, #0x1                // =1
               	cbnz	w1, <addr>
               	add	x1, x21, #0x3
               	cmp	w25, w1
               	cset	x1, ne
               	orr	x2, x24, x1
               	add	x1, x21, #0x3
               	sub	x1, x1, #0x1
               	ldrb	w1, [x23, x1]
               	eor	x1, x1, x21
               	cbnz	w1, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x0, x20
               	b.hs	<addr>
               	ldrb	w1, [x22, x0]
               	cmp	w1, #0x5a
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	x0, x20
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x0
               	cset	x0, eq
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	orr	x24, x2, x0
               	mov	sp, x26
               	add	x21, x21, #0x1
               	cmp	w21, #0x4
               	b.le	<addr>
               	mov	x0, x24
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
