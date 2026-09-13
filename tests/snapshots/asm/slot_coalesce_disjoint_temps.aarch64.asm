
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
               	mov	x6, #0x3                // =3
               	mov	x4, x0
               	mov	x5, x0
               	b	<addr>
               	and	x7, x0, #0x1
               	cbz	x7, <addr>
               	mul	x1, x0, x6
               	sxtw	x1, w1
               	cmp	w1, #0xa
               	b.le	<addr>
               	cmp	w1, #0x64
               	cset	x2, lt
               	cbz	x2, <addr>
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	sxtw	x3, w2
               	asr	x8, x3, #63
               	lsr	x8, x8, #63
               	add	x9, x3, x8
               	and	x9, x9, #0x1
               	sub	x8, x9, x8
               	cbz	x8, <addr>
               	cmp	w2, #0x32
               	cset	x8, gt
               	cbz	x8, <addr>
               	lsl	x3, x2, #1
               	sxtw	x3, w3
               	add	x1, x3, x1
               	add	x1, x1, x2
               	add	x5, x5, x1
               	cbz	x7, <addr>
               	mul	x1, x0, x6
               	sxtw	x1, w1
               	cmp	w1, #0xa
               	b.le	<addr>
               	cmp	w1, #0x64
               	cset	x2, lt
               	cbz	x2, <addr>
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	sxtw	x3, w2
               	asr	x7, x3, #63
               	lsr	x7, x7, #63
               	add	x8, x3, x7
               	and	x8, x8, #0x1
               	sub	x7, x8, x7
               	cbz	x7, <addr>
               	cmp	w2, #0x32
               	cset	x7, gt
               	cbz	x7, <addr>
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
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	cmp	w5, w4
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
