
slot_coalesce_disjoint_temps.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	mov	x6, #0x1                // =1
               	mov	x8, #0x3                // =3
               	mov	x4, x0
               	mov	x5, x0
               	b	<addr>
               	sxtw	x7, w0
               	and	x9, x7, x6
               	cbz	x9, <addr>
               	mul	x1, x0, x8
               	sxtw	x1, w1
               	cmp	w1, #0xa
               	b.le	<addr>
               	cmp	w1, #0x64
               	cset	x2, lt
               	cbz	x2, <addr>
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	sxtw	x3, w2
               	asr	x10, x3, #63
               	lsr	x10, x10, #63
               	add	x11, x3, x10
               	and	x11, x11, x6
               	sub	x10, x11, x10
               	cbz	x10, <addr>
               	cmp	w2, #0x32
               	cset	x10, gt
               	cbz	x10, <addr>
               	lsl	x3, x2, #1
               	sxtw	x3, w3
               	add	x1, x3, x1
               	add	x1, x1, x2
               	add	x5, x5, x1
               	cbz	x9, <addr>
               	mul	x1, x0, x8
               	sxtw	x1, w1
               	cmp	w1, #0xa
               	b.le	<addr>
               	cmp	w1, #0x64
               	cset	x2, lt
               	cbz	x2, <addr>
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	sxtw	x3, w2
               	asr	x9, x3, #63
               	lsr	x9, x9, #63
               	add	x10, x3, x9
               	and	x10, x10, x6
               	sub	x9, x10, x9
               	cbz	x9, <addr>
               	cmp	w2, #0x32
               	cset	x9, gt
               	cbz	x9, <addr>
               	lsl	x3, x2, #1
               	sxtw	x3, w3
               	add	x1, x3, x1
               	add	x1, x1, x2
               	add	x4, x4, x1
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	b	<addr>
               	add	x1, x0, #0x7
               	sxtw	x1, w1
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	b	<addr>
               	add	x1, x0, #0x7
               	sxtw	x1, w1
               	b	<addr>
               	add	x0, x7, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	cmp	w5, w4
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
