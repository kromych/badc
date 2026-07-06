
slot_coalesce_disjoint_temps.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x2, x1
               	b	<addr>
               	mov	x17, #0x1               // =1
               	and	x4, x3, x17
               	cbz	x4, <addr>
               	mov	x17, #0x3               // =3
               	mul	x4, x1, x17
               	sxtw	x5, w4
               	sxtw	x4, w5
               	cmp	x4, #0xa
               	cset	x7, gt
               	cbz	x7, <addr>
               	cmp	x4, #0x64
               	cset	x7, lt
               	cbz	x7, <addr>
               	sub	x4, x5, #0x1
               	sxtw	x6, w4
               	sxtw	x8, w6
               	asr	x4, x8, #63
               	lsr	x4, x4, #63
               	add	x7, x8, x4
               	mov	x17, #0x1               // =1
               	and	x7, x7, x17
               	sub	x4, x7, x4
               	cmp	x4, #0x0
               	cset	x7, eq
               	cbnz	x7, <addr>
               	cmp	x8, #0x32
               	cset	x7, gt
               	cbz	x7, <addr>
               	lsl	x4, x6, #1
               	sxtw	x8, w4
               	add	x4, x8, x5
               	add	x4, x4, x6
               	add	x2, x2, x4
               	mov	x17, #0x1               // =1
               	and	x4, x3, x17
               	cbz	x4, <addr>
               	mov	x17, #0x3               // =3
               	mul	x4, x1, x17
               	sxtw	x5, w4
               	sxtw	x4, w5
               	cmp	x4, #0xa
               	cset	x7, gt
               	cbz	x7, <addr>
               	cmp	x4, #0x64
               	cset	x7, lt
               	cbz	x7, <addr>
               	sub	x4, x5, #0x1
               	sxtw	x6, w4
               	sxtw	x8, w6
               	asr	x4, x8, #63
               	lsr	x4, x4, #63
               	add	x7, x8, x4
               	mov	x17, #0x1               // =1
               	and	x7, x7, x17
               	sub	x4, x7, x4
               	cmp	x4, #0x0
               	cset	x7, eq
               	cbnz	x7, <addr>
               	cmp	x8, #0x32
               	cset	x7, gt
               	cbz	x7, <addr>
               	lsl	x4, x6, #1
               	sxtw	x8, w4
               	add	x4, x8, x5
               	add	x4, x4, x6
               	add	x0, x0, x4
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x4, x5, #0x1
               	sxtw	x6, w4
               	b	<addr>
               	b	<addr>
               	add	x4, x1, #0x7
               	sxtw	x5, w4
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x4, x5, #0x1
               	sxtw	x6, w4
               	b	<addr>
               	b	<addr>
               	add	x4, x1, #0x7
               	sxtw	x5, w4
               	b	<addr>
               	add	x1, x3, #0x1
               	sxtw	x3, w1
               	cmp	x3, #0x40
               	b.lt	<addr>
               	sxtw	x1, w2
               	sxtw	x0, w0
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
