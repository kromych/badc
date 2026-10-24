
value_builtins.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldursw	x1, [x29, #-0x8]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, x1
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x10]
               	fcmp	s0, s1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x20]
               	stur	d0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x20]
               	mov	x17, #0x7ff8000000000000 // =9221120237041090560
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	stur	x0, [x29, #-0x20]
               	stur	d0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x20]
               	mov	x17, #0x10              // =16
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x1]
               	stur	w0, [x29, #-0x18]
               	stur	s0, [x29, #-0x18]
               	ldur	w1, [x29, #-0x18]
               	mov	x17, #0x7               // =7
               	movk	x17, #0x7fc0, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	stur	x0, [x29, #-0x20]
               	stur	d0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x20]
               	mov	x17, #0x8               // =8
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x14]
               	stur	w0, [x29, #-0x18]
               	stur	s0, [x29, #-0x18]
               	ldur	w1, [x29, #-0x18]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x7fc0, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7fffffffffffffff // =9223372036854775807
               	fmov	d0, x16
               	stur	x0, [x29, #-0x20]
               	stur	d0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x20]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #-0x12c             // =-300
               	stur	w1, [x29, #-0x10]
               	b	<addr>
               	ldursw	x1, [x29, #-0x10]
               	sub	x1, x1, #0x30
               	cmp	x1, #0xa
               	cset	x1, lo
               	ldursw	x2, [x29, #-0x10]
               	ldursw	x3, [x29, #-0x10]
               	and	x3, x3, #0xffffffffffffff80
               	cmp	x3, #0x0
               	cset	x3, eq
               	madd	x1, x1, x2, x3
               	ldursw	x2, [x29, #-0x10]
               	and	x2, x2, #0x7f
               	add	x1, x1, x2
               	add	x0, x0, x1
               	ldursw	x1, [x29, #-0x10]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x12c
               	b.lt	<addr>
               	mov	x17, #0x9761            // =38753
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
