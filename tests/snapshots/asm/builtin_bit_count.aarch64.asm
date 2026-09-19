
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
               	lsr	x2, x1, #1
               	and	w2, w2, #0x55555555
               	sub	x1, x1, x2
               	and	w2, w1, #0x33333333
               	lsr	x1, x1, #2
               	and	w1, w1, #0x33333333
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	and	w1, w1, #0xf0f0f0f
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	and	x1, x1, #0x7f
               	cmp	w1, #0x10
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x10]
               	lsr	x2, x1, #1
               	orr	x1, x1, x2
               	lsr	x2, x1, #2
               	orr	x1, x1, x2
               	lsr	x2, x1, #4
               	orr	x1, x1, x2
               	lsr	x2, x1, #8
               	orr	x1, x1, x2
               	lsr	x2, x1, #16
               	orr	x1, x1, x2
               	lsr	x2, x1, #1
               	and	w2, w2, #0x55555555
               	sub	x1, x1, x2
               	and	w2, w1, #0x33333333
               	lsr	x1, x1, #2
               	and	w1, w1, #0x33333333
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	and	w1, w1, #0xf0f0f0f
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	and	x1, x1, #0x7f
               	mov	x2, #0x20               // =32
               	sub	x1, x2, x1
               	cmp	w1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x10]
               	sub	x2, x1, #0x1
               	mvn	x1, x1
               	and	x1, x2, x1
               	mov	w1, w1
               	lsr	x2, x1, #1
               	and	w2, w2, #0x55555555
               	sub	x1, x1, x2
               	and	w2, w1, #0x33333333
               	lsr	x1, x1, #2
               	and	w1, w1, #0x33333333
               	add	x1, x2, x1
               	lsr	x2, x1, #4
               	add	x1, x1, x2
               	and	w1, w1, #0xf0f0f0f
               	lsr	x2, x1, #8
               	add	x1, x1, x2
               	lsr	x2, x1, #16
               	add	x1, x1, x2
               	and	x1, x1, #0x7f
               	cbz	w1, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #1
               	and	x1, x1, #0x5555555555555555
               	sub	x0, x0, x1
               	and	x1, x0, #0x3333333333333333
               	lsr	x0, x0, #2
               	and	x0, x0, #0x3333333333333333
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	and	x0, x0, #0xf0f0f0f0f0f0f0f
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	and	x0, x0, #0x7f
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	sub	x1, x0, #0x1
               	mvn	x0, x0
               	and	x0, x1, x0
               	lsr	x1, x0, #1
               	and	x1, x1, #0x5555555555555555
               	sub	x0, x0, x1
               	and	x1, x0, #0x3333333333333333
               	lsr	x0, x0, #2
               	and	x0, x0, #0x3333333333333333
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	and	x0, x0, #0xf0f0f0f0f0f0f0f
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	and	x0, x0, #0x7f
               	cbz	w0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
