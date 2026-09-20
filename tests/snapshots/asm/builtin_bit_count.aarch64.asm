
builtin_bit_count.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0xff               // =255
               	movk	x0, #0xff, lsl #16
               	stur	w0, [x29, #-0x10]
               	ldur	w1, [x29, #-0x10]
               	fmov	s16, w1
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w1, s16
               	cmp	w1, #0x10
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x10]
               	clz	w1, w1
               	cmp	w1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x10]
               	rbit	w1, w1
               	clz	w1, w1
               	cbz	w1, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	fmov	d16, x0
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w0, s16
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	rbit	x0, x0
               	clz	x0, x0
               	cbz	w0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
