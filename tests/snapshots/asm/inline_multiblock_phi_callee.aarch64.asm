
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
               	mov	x0, #0xfff4             // =65524
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0xc                // =12
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x1                // =1
               	mov	x0, #0x3                // =3
               	mov	x0, #0xfff1             // =65521
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0xf                // =15
               	mov	x5, #0x0                // =0
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x6, #0xfffd             // =65533
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x7, #0xfffe             // =65534
               	movk	x7, #0xffff, lsl #16
               	movk	x7, #0xffff, lsl #32
               	movk	x7, #0xffff, lsl #48
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x8, #0x0                // =0
               	mov	x2, #0x1                // =1
               	mov	x10, #0x2               // =2
               	mov	x9, #0x3                // =3
               	b	<addr>
               	sub	x3, x0, #0x3
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x4, x3, #1
               	and	x3, x3, x2
               	add	x3, x4, x3
               	sxtw	x3, w3
               	add	x5, x5, x3
               	add	x3, x0, #0x3
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x4, x3, #1
               	and	x3, x3, x2
               	add	x3, x4, x3
               	sxtw	x3, w3
               	add	x5, x5, x3
               	mul	x3, x0, x6
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x4, x3, #1
               	and	x3, x3, x2
               	add	x3, x4, x3
               	sxtw	x3, w3
               	add	x11, x5, x3
               	sxtw	x4, w0
               	eor	x3, x4, x6
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	sub	x3, x0, #0x2
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	add	x3, x0, #0x2
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	mul	x3, x0, x7
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	eor	x3, x4, x7
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	sub	x3, x0, #0x1
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	add	x3, x0, #0x1
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	mul	x3, x0, x1
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	mvn	x3, x4
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	add	x3, x0, #0x0
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	sub	x3, x0, #0x0
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	mul	x3, x0, x8
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	eor	x3, x4, x8
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	add	x3, x0, #0x1
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	sub	x3, x0, #0x1
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	lsr	x3, x0, #0
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	eor	x3, x4, x2
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	add	x3, x0, #0x2
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	sub	x3, x0, #0x2
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	lsl	x3, x0, #1
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	eor	x3, x4, x10
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	add	x3, x0, #0x3
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	sub	x3, x0, #0x3
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	mul	x3, x0, x9
               	sxtw	x3, w3
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x11, x11, x3
               	eor	x3, x4, x9
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mul	x3, x3, x1
               	sxtw	x3, w3
               	lsl	x5, x3, #1
               	and	x3, x3, x2
               	add	x3, x5, x3
               	sxtw	x3, w3
               	add	x5, x11, x3
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x4, #0x1
               	cmp	w0, #0x4
               	b.le	<addr>
               	cmp	x5, #0x620
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
