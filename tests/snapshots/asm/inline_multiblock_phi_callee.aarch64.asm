
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
               	mov	x1, #0x0                // =0
               	mov	x0, #-0x4               // =-4
               	mov	x3, #-0x3               // =-3
               	mov	x4, #-0x2               // =-2
               	mov	x5, #0x0                // =0
               	sub	x2, x0, #0x3
               	neg	x6, x2
               	cmp	w2, #0x0
               	csel	x2, x6, x2, lt
               	and	x6, x2, #0x1
               	add	x2, x6, x2, lsl #1
               	add	x2, x1, x2
               	add	x1, x0, #0x3
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	mul	x1, x0, x3
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	eor	x1, x0, #0xfffffffffffffffd
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	sub	x1, x0, #0x2
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	add	x1, x0, #0x2
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	mul	x1, x0, x4
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	eor	x1, x0, #0xfffffffffffffffe
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	sub	x1, x0, #0x1
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	add	x1, x0, #0x1
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x6, x2, x1
               	neg	x1, x0
               	cmp	w1, #0x0
               	csel	x2, x0, x1, lt
               	and	x7, x2, #0x1
               	add	x2, x7, x2, lsl #1
               	add	x6, x6, x2
               	mvn	x2, x0
               	neg	x7, x2
               	cmp	w2, #0x0
               	csel	x2, x7, x2, lt
               	and	x7, x2, #0x1
               	add	x2, x7, x2, lsl #1
               	add	x6, x6, x2
               	cmp	w0, #0x0
               	csel	x2, x1, x0, lt
               	and	x7, x2, #0x1
               	add	x2, x7, x2, lsl #1
               	add	x6, x6, x2
               	cmp	w0, #0x0
               	csel	x2, x1, x0, lt
               	and	x7, x2, #0x1
               	add	x2, x7, x2, lsl #1
               	add	x6, x6, x2
               	mul	x2, x0, x5
               	neg	x7, x2
               	cmp	w2, #0x0
               	csel	x2, x7, x2, lt
               	and	x7, x2, #0x1
               	add	x2, x7, x2, lsl #1
               	sxtw	x2, w2
               	add	x6, x6, x2
               	cmp	w0, #0x0
               	csel	x2, x1, x0, lt
               	and	x7, x2, #0x1
               	add	x2, x7, x2, lsl #1
               	add	x6, x6, x2
               	add	x2, x0, #0x1
               	neg	x7, x2
               	cmp	w2, #0x0
               	csel	x2, x7, x2, lt
               	and	x7, x2, #0x1
               	add	x2, x7, x2, lsl #1
               	add	x6, x6, x2
               	sub	x2, x0, #0x1
               	neg	x7, x2
               	cmp	w2, #0x0
               	csel	x2, x7, x2, lt
               	and	x7, x2, #0x1
               	add	x2, x7, x2, lsl #1
               	add	x2, x6, x2
               	cmp	w0, #0x0
               	csel	x1, x1, x0, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	eor	x1, x0, #0x1
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	add	x1, x0, #0x2
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	sub	x1, x0, #0x2
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	lsl	x1, x0, #1
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	eor	x1, x0, #0x2
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	add	x1, x0, #0x3
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	sub	x1, x0, #0x3
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x2, x2, x1
               	add	x1, x0, x0, lsl #1
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	sxtw	x1, w1
               	add	x2, x2, x1
               	eor	x1, x0, #0x3
               	neg	x6, x1
               	cmp	w1, #0x0
               	csel	x1, x6, x1, lt
               	and	x6, x1, #0x1
               	add	x1, x6, x1, lsl #1
               	add	x1, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.le	<addr>
               	cmp	x1, #0x620
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
