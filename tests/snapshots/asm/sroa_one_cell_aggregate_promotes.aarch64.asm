
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
               	ldr	x2, [x0, #0x18]
               	mov	x4, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x3, x4
               	mov	w5, w0
               	add	x3, x3, x5
               	add	x5, x0, x2
               	mov	x6, #0x2                // =2
               	cmp	w1, #0x2
               	csel	x0, x5, x0, lo
               	csel	x1, x6, x4, lo
               	cbnz	w1, <addr>
               	add	x0, x2, #0x7
               	sxth	x0, w0
               	and	x1, x2, #0xff
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	add	x1, x1, x0, lsl #1
               	add	x1, x1, #0x3
               	add	x0, x1, x0
               	add	x0, x3, x0, lsl #1
               	sxth	x7, w2
               	add	x1, x2, #0x1
               	sxth	x1, w1
               	lsl	x3, x2, #1
               	sxth	x3, w3
               	sub	x4, x2, #0x3
               	sxth	x4, w4
               	add	x1, x7, x1, lsl #1
               	add	x3, x3, x3, lsl #1
               	add	x1, x1, x3
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x1, x1, x1, lsl #1
               	add	x8, x0, x1
               	mov	x4, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x3, x4
               	mov	w5, w0
               	add	x3, x3, x5
               	add	x5, x0, x2
               	mov	x6, #0x2                // =2
               	cmp	w1, #0x2
               	csel	x0, x5, x0, lo
               	csel	x1, x6, x4, lo
               	cbnz	w1, <addr>
               	cmp	x3, #0xd
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x0, x2, #0x7
               	sxth	x0, w0
               	and	x1, x2, #0xff
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	add	x1, x1, x0, lsl #1
               	add	x1, x1, #0x3
               	add	x0, x1, x0
               	cmp	w0, #0x83
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x0, x2, #0x1
               	sxth	x0, w0
               	lsl	x1, x2, #1
               	sxth	x1, w1
               	sub	x2, x2, #0x3
               	sxth	x2, w2
               	add	x0, x7, x0, lsl #1
               	add	x1, x1, x1, lsl #1
               	add	x0, x0, x1
               	add	x0, x0, x2
               	cmp	w0, #0x1d
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x8, #0x16a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
