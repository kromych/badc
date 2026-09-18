
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
               	cmp	w1, #0xa
               	b.le	<addr>
               	cmp	w1, #0x64
               	cset	x2, lt
               	cbz	x2, <addr>
               	sub	x2, x1, #0x1
               	sxtw	x3, w2
               	lsr	x8, x3, #63
               	add	x3, x3, x8
               	and	x3, x3, #0x1
               	sub	x3, x3, x8
               	cbz	x3, <addr>
               	cmp	w2, #0x32
               	cset	x3, gt
               	cbz	x3, <addr>
               	lsl	x3, x2, #1
               	add	x1, x3, x1
               	add	x1, x1, x2
               	add	x5, x5, x1
               	cbz	x7, <addr>
               	mul	x1, x0, x6
               	cmp	w1, #0xa
               	b.le	<addr>
               	cmp	w1, #0x64
               	cset	x2, lt
               	cbz	x2, <addr>
               	sub	x2, x1, #0x1
               	sxtw	x3, w2
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	and	x3, x3, #0x1
               	sub	x3, x3, x7
               	cbz	x3, <addr>
               	cmp	w2, #0x32
               	cset	x3, gt
               	cbz	x3, <addr>
               	lsl	x3, x2, #1
               	add	x1, x3, x1
               	add	x1, x1, x2
               	add	x4, x4, x1
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	add	x2, x1, #0x1
               	b	<addr>
               	add	x1, x0, #0x7
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	add	x2, x1, #0x1
               	b	<addr>
               	add	x1, x0, #0x7
               	b	<addr>
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
