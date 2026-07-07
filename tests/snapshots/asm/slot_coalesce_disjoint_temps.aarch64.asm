
slot_coalesce_disjoint_temps.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	mov	x4, x0
               	mov	x5, x0
               	b	<addr>
               	mov	x17, #0x1               // =1
               	and	x1, x6, x17
               	cbz	x1, <addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	sxtw	x1, w1
               	sxtw	x3, w1
               	cmp	x3, #0xa
               	cset	x2, gt
               	cbz	x2, <addr>
               	cmp	x3, #0x64
               	cset	x2, lt
               	cbz	x2, <addr>
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	sxtw	x3, w2
               	asr	x7, x3, #63
               	lsr	x7, x7, #63
               	add	x8, x3, x7
               	mov	x17, #0x1               // =1
               	and	x8, x8, x17
               	sub	x7, x8, x7
               	cmp	x7, #0x0
               	cset	x7, eq
               	cbnz	x7, <addr>
               	cmp	x3, #0x32
               	cset	x7, gt
               	cbz	x7, <addr>
               	lsl	x3, x2, #1
               	sxtw	x3, w3
               	add	x1, x3, x1
               	add	x1, x1, x2
               	add	x5, x5, x1
               	mov	x17, #0x1               // =1
               	and	x1, x6, x17
               	cbz	x1, <addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	sxtw	x1, w1
               	sxtw	x3, w1
               	cmp	x3, #0xa
               	cset	x2, gt
               	cbz	x2, <addr>
               	cmp	x3, #0x64
               	cset	x2, lt
               	cbz	x2, <addr>
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	sxtw	x3, w2
               	asr	x7, x3, #63
               	lsr	x7, x7, #63
               	add	x8, x3, x7
               	mov	x17, #0x1               // =1
               	and	x8, x8, x17
               	sub	x7, x8, x7
               	cmp	x7, #0x0
               	cset	x7, eq
               	cbnz	x7, <addr>
               	cmp	x3, #0x32
               	cset	x7, gt
               	cbz	x7, <addr>
               	lsl	x3, x2, #1
               	sxtw	x3, w3
               	add	x1, x3, x1
               	add	x1, x1, x2
               	add	x4, x4, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	b	<addr>
               	b	<addr>
               	add	x1, x0, #0x7
               	sxtw	x1, w1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	b	<addr>
               	b	<addr>
               	add	x1, x0, #0x7
               	sxtw	x1, w1
               	b	<addr>
               	add	x0, x6, #0x1
               	sxtw	x6, w0
               	cmp	x6, #0x40
               	b.lt	<addr>
               	sxtw	x0, w5
               	sxtw	x1, w4
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
