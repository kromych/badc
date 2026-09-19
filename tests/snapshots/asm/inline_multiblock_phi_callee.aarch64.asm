
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
               	mov	x0, #0x7                // =7
               	mov	x0, #-0xc               // =-12
               	mov	x0, #0xc                // =12
               	mov	x0, #-0x1               // =-1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x3                // =3
               	mov	x0, #-0xf               // =-15
               	mov	x0, #0xf                // =15
               	mov	x3, #0x0                // =0
               	mov	x0, #-0x4               // =-4
               	mov	x6, #-0x3               // =-3
               	mov	x7, #-0x2               // =-2
               	mov	x1, #-0x1               // =-1
               	mov	x4, #0x0                // =0
               	mov	x8, #0x3                // =3
               	cmp	w0, #0x4
               	b.gt	<addr>
               	sub	x2, x0, #0x3
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x5, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x5, x2
               	sxtw	x2, w2
               	add	x5, x3, x2
               	add	x2, x0, #0x3
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	mul	x2, x0, x6
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	eor	x2, x0, #0xfffffffffffffffd
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	sub	x2, x0, #0x2
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	add	x2, x0, #0x2
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	mul	x2, x0, x7
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	eor	x2, x0, #0xfffffffffffffffe
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	sub	x2, x0, #0x1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	add	x2, x0, #0x1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	mul	x2, x0, x1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	mvn	x2, x0
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	add	x2, x0, #0x0
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	sub	x2, x0, #0x0
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	mul	x2, x0, x4
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	eor	x2, x0, x4
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	add	x2, x0, #0x1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	sub	x2, x0, #0x1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	lsr	x2, x0, #0
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	eor	x2, x0, #0x1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	add	x2, x0, #0x2
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	sub	x2, x0, #0x2
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	lsl	x2, x0, #1
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	eor	x2, x0, #0x2
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	add	x2, x0, #0x3
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	sub	x2, x0, #0x3
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	mul	x2, x0, x8
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x5, x5, x2
               	eor	x2, x0, #0x3
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mul	x2, x2, x1
               	lsl	x3, x2, #1
               	and	x2, x2, #0x1
               	add	x2, x3, x2
               	sxtw	x2, w2
               	add	x3, x5, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.le	<addr>
               	cmp	x3, #0x620
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
