
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
               	mov	x2, #0xfffc             // =65532
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x7, #0xfffd             // =65533
               	movk	x7, #0xffff, lsl #16
               	movk	x7, #0xffff, lsl #32
               	movk	x7, #0xffff, lsl #48
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x4, #0x1                // =1
               	b	<addr>
               	mov	x1, x7
               	b	<addr>
               	add	x0, x2, x1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mul	x0, x0, x3
               	sxtw	x0, w0
               	lsl	x6, x0, #1
               	and	x0, x0, x4
               	add	x0, x6, x0
               	sxtw	x0, w0
               	add	x6, x5, x0
               	sub	x0, x2, x1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mul	x0, x0, x3
               	sxtw	x0, w0
               	lsl	x5, x0, #1
               	and	x0, x0, x4
               	add	x0, x5, x0
               	sxtw	x0, w0
               	add	x6, x6, x0
               	mul	x0, x2, x1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mul	x0, x0, x3
               	sxtw	x0, w0
               	lsl	x5, x0, #1
               	and	x0, x0, x4
               	add	x0, x5, x0
               	sxtw	x0, w0
               	add	x8, x6, x0
               	sxtw	x0, w2
               	sxtw	x6, w1
               	eor	x0, x0, x6
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mul	x0, x0, x3
               	sxtw	x0, w0
               	lsl	x5, x0, #1
               	and	x0, x0, x4
               	add	x0, x5, x0
               	sxtw	x0, w0
               	add	x5, x8, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x1, x6, #0x1
               	cmp	x1, #0x3
               	b.le	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	cmp	x2, #0x4
               	b.le	<addr>
               	cmp	x5, #0x620
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
