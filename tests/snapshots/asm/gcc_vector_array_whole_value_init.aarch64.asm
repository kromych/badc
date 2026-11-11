
gcc_vector_array_whole_value_init.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x80
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x70
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x60
               	stp	xzr, xzr, [x3]
               	stp	xzr, xzr, [x3, #0x10]
               	stp	xzr, xzr, [x3, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	add	x4, x3, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	add	x3, x3, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	sub	x3, x29, #0x60
               	stp	xzr, xzr, [x3]
               	stp	xzr, xzr, [x3, #0x10]
               	stp	xzr, xzr, [x3, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	add	x4, x3, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	add	x3, x3, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	sub	x3, x29, #0x60
               	stp	xzr, xzr, [x3]
               	stp	xzr, xzr, [x3, #0x10]
               	stp	xzr, xzr, [x3, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	add	x0, x3, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x0, x3, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	mov	x0, #0x7                // =7
               	sturb	w0, [x29, #-0x60]
               	sturb	w0, [x29, #-0x5f]
               	sturb	w0, [x29, #-0x5e]
               	sturb	w0, [x29, #-0x5d]
               	sturb	w0, [x29, #-0x5c]
               	sturb	w0, [x29, #-0x5b]
               	sturb	w0, [x29, #-0x5a]
               	sturb	w0, [x29, #-0x59]
               	sturb	w0, [x29, #-0x58]
               	sturb	w0, [x29, #-0x57]
               	sturb	w0, [x29, #-0x56]
               	sturb	w0, [x29, #-0x55]
               	sturb	w0, [x29, #-0x54]
               	sturb	w0, [x29, #-0x53]
               	sturb	w0, [x29, #-0x52]
               	sturb	w0, [x29, #-0x51]
               	sub	x2, x29, #0x80
               	add	x0, x1, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldurb	w0, [x29, #-0x60]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x51]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x60
               	stp	xzr, xzr, [x3]
               	stp	xzr, xzr, [x3, #0x10]
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x60]
               	sturb	w0, [x29, #-0x5f]
               	sturb	w0, [x29, #-0x5e]
               	sturb	w0, [x29, #-0x5d]
               	sturb	w0, [x29, #-0x5c]
               	sturb	w0, [x29, #-0x5b]
               	sturb	w0, [x29, #-0x5a]
               	sturb	w0, [x29, #-0x59]
               	sturb	w0, [x29, #-0x58]
               	sturb	w0, [x29, #-0x57]
               	sturb	w0, [x29, #-0x56]
               	sturb	w0, [x29, #-0x55]
               	sturb	w0, [x29, #-0x54]
               	sturb	w0, [x29, #-0x53]
               	sturb	w0, [x29, #-0x52]
               	sturb	w0, [x29, #-0x51]
               	sub	x1, x29, #0x90
               	add	x0, x3, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldurb	w0, [x29, #-0x59]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	add	x3, x0, #0x20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	sub	x2, x29, #0x70
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	add	x3, x0, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	add	x3, x0, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x3, x29, #0x80
               	add	x4, x0, #0x10
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x4]
               	add	x4, x0, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	add	x0, x0, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x4, x0, #0x10
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x4]
               	add	x4, x0, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	add	x4, x0, #0x30
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x4]
               	add	x2, x0, #0x40
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	add	x0, x0, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	sub	x1, x29, #0x90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x50]
               	add	x0, x0, #0x20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	mov	x0, #0x6                // =6
               	stur	w0, [x29, #-0x30]
               	ldursw	x0, [x29, #-0x50]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x10
               	ldrb	w1, [x1]
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrb	w0, [x0, #0xf]
               	cbz	w0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
