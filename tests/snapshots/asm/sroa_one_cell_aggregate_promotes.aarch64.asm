
sroa_one_cell_aggregate_promotes.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x3, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	w4, w0
               	add	x3, x3, x4
               	mov	w1, w1
               	cmp	x1, #0x2
               	b.lo	<addr>
               	mov	x1, #0x0                // =0
               	mov	x4, x1
               	b	<addr>
               	mov	w0, w0
               	mov	w1, w2
               	add	x0, x0, x1
               	mov	x1, #0x2                // =2
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	w4, w1
               	cmp	x4, #0x0
               	b.ne	<addr>
               	add	x0, x2, #0x7
               	sxth	x0, w0
               	mov	x17, #0xff              // =255
               	and	x1, x2, x17
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x4, x1, x17
               	lsl	x1, x0, #1
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	add	x1, x1, x4
               	add	x1, x1, #0x3
               	sxtw	x1, w1
               	add	x0, x1, x0
               	lsl	x0, x0, #1
               	add	x6, x3, x0
               	sxth	x5, w2
               	add	x0, x2, #0x1
               	sxth	x1, w0
               	lsl	x0, x2, #1
               	sxth	x3, w0
               	sub	x0, x2, #0x3
               	sxth	x4, w0
               	lsl	x1, x1, #1
               	add	x1, x5, x1
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	add	x0, x1, x4
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x6, x6, x0
               	mov	x3, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	w4, w0
               	add	x3, x3, x4
               	mov	w1, w1
               	cmp	x1, #0x2
               	b.lo	<addr>
               	mov	x1, #0x0                // =0
               	mov	x4, x1
               	b	<addr>
               	mov	w0, w0
               	mov	w1, w2
               	add	x0, x0, x1
               	mov	x1, #0x2                // =2
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	w4, w1
               	cmp	x4, #0x0
               	b.ne	<addr>
               	cmp	x3, #0xd
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x0, x2, #0x7
               	sxth	x0, w0
               	mov	x17, #0xff              // =255
               	and	x1, x2, x17
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	lsl	x1, x0, #1
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	add	x1, x1, x3
               	add	x1, x1, #0x3
               	sxtw	x1, w1
               	add	x0, x1, x0
               	cmp	x0, #0x83
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x0, x2, #0x1
               	sxth	x1, w0
               	lsl	x0, x2, #1
               	sxth	x3, w0
               	sub	x0, x2, #0x3
               	sxth	x4, w0
               	lsl	x1, x1, #1
               	add	x1, x5, x1
               	mov	x17, #0x3               // =3
               	mul	x2, x3, x17
               	add	x1, x1, x2
               	add	x0, x1, x4
               	sxtw	x0, w0
               	cmp	x0, #0x1d
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x6, #0x16a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
