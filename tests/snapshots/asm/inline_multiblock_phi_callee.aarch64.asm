
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
               	mov	x3, #0x0                // =0
               	mov	x2, #0xfffc             // =65532
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	b	<addr>
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	add	x1, x2, x0
               	sxtw	x1, w1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	lsl	x4, x1, #1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x4, x1
               	sxtw	x1, w1
               	add	x4, x3, x1
               	sub	x1, x2, x0
               	sxtw	x1, w1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	lsl	x3, x1, #1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x3, x1
               	sxtw	x1, w1
               	add	x4, x4, x1
               	mul	x1, x2, x0
               	sxtw	x1, w1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	lsl	x3, x1, #1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x3, x1
               	sxtw	x1, w1
               	add	x5, x4, x1
               	sxtw	x1, w2
               	sxtw	x4, w0
               	eor	x1, x1, x4
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	lsl	x3, x1, #1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x3, x1
               	sxtw	x1, w1
               	add	x3, x5, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x4, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	cmp	w2, #0x4
               	b.le	<addr>
               	cmp	x3, #0x620
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
