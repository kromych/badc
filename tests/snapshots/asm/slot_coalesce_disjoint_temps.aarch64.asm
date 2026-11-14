
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
               	mov	x3, x0
               	mov	x4, x0
               	b	<addr>
               	add	x2, x5, x2
               	add	x1, x2, x1
               	add	x3, x3, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.ge	<addr>
               	and	x5, x0, #0x1
               	add	x1, x0, x0, lsl #1
               	add	x2, x0, #0x7
               	cmp	x5, #0x0
               	csel	x2, x1, x2, ne
               	cmp	w2, #0xa
               	b.le	<addr>
               	cmp	w2, #0x64
               	b.ge	<addr>
               	sub	x1, x2, #0x1
               	sxtw	x6, w1
               	lsr	x7, x6, #63
               	add	x6, x6, x7
               	and	x6, x6, #0x1
               	sub	x6, x6, x7
               	cbz	w6, <addr>
               	cmp	w1, #0x32
               	b.le	<addr>
               	lsl	x6, x1, #1
               	add	x2, x6, x2
               	add	x1, x2, x1
               	add	x4, x4, x1
               	add	x1, x0, x0, lsl #1
               	add	x2, x0, #0x7
               	cmp	x5, #0x0
               	csel	x2, x1, x2, ne
               	cmp	w2, #0xa
               	b.le	<addr>
               	cmp	w2, #0x64
               	b.ge	<addr>
               	sub	x1, x2, #0x1
               	sxtw	x5, w1
               	lsr	x6, x5, #63
               	add	x5, x5, x6
               	and	x5, x5, #0x1
               	sub	x5, x5, x6
               	cbz	w5, <addr>
               	cmp	w1, #0x32
               	b.le	<addr>
               	lsl	x5, x1, #1
               	b	<addr>
               	mov	x5, x1
               	b	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	mov	x6, x1
               	b	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	cmp	w4, w3
               	csel	x0, x0, x1, eq
               	ret
