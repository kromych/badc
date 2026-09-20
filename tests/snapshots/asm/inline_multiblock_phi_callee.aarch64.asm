
inline_multiblock_phi_callee.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x0                // =0
               	mov	x0, #-0x4               // =-4
               	mov	x3, #-0x3               // =-3
               	mov	x4, #-0x2               // =-2
               	mov	x5, #0x0                // =0
               	mov	x6, #0x3                // =3
               	sub	x1, x0, #0x3
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	add	x1, x0, #0x3
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	mul	x1, x0, x3
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	eor	x1, x0, #0xfffffffffffffffd
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	sub	x1, x0, #0x2
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	add	x1, x0, #0x2
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	mul	x1, x0, x4
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	eor	x1, x0, #0xfffffffffffffffe
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	sub	x1, x0, #0x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	add	x1, x0, #0x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x7, x2, x1
               	neg	x1, x0
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x2, x1
               	lsl	x8, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	add	x7, x7, x2
               	mvn	x2, x0
               	cmp	w2, #0x0
               	b.ge	<addr>
               	neg	x2, x2
               	lsl	x8, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	sxtw	x2, w2
               	add	x7, x7, x2
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x2, x1
               	lsl	x8, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	add	x7, x7, x2
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x2, x1
               	lsl	x8, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	add	x7, x7, x2
               	mul	x2, x0, x5
               	cmp	w2, #0x0
               	b.ge	<addr>
               	neg	x2, x2
               	lsl	x8, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	sxtw	x2, w2
               	add	x7, x7, x2
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x2, x1
               	lsl	x8, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	add	x7, x7, x2
               	add	x2, x0, #0x1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	neg	x2, x2
               	lsl	x8, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	add	x7, x7, x2
               	sub	x2, x0, #0x1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	neg	x2, x2
               	lsl	x8, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	add	x2, x7, x2
               	cmp	w0, #0x0
               	b.ge	<addr>
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	eor	x1, x0, #0x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	add	x1, x0, #0x2
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	sub	x1, x0, #0x2
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	lsl	x1, x0, #1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	eor	x1, x0, #0x2
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	add	x1, x0, #0x3
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	sub	x1, x0, #0x3
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	add	x2, x2, x1
               	mul	x1, x0, x6
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	eor	x1, x0, #0x3
               	cmp	w1, #0x0
               	b.ge	<addr>
               	neg	x1, x1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	lsl	x7, x1, #1
               	and	x1, x1, #0x1
               	add	x1, x7, x1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.le	<addr>
               	cmp	x2, #0x620
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
