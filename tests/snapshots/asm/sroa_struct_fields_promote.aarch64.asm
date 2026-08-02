
sroa_struct_fields_promote.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x17, #0x5               // =5
               	mul	x0, x2, x17
               	add	x1, x2, #0x1
               	lsl	x3, x2, #1
               	add	x4, x0, x3
               	add	x0, x2, #0x7
               	sxth	x3, w0
               	mov	x17, #0xff              // =255
               	and	x0, x2, x17
               	mov	x17, #0x7a              // =122
               	eor	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x5, x0, x17
               	add	x0, x2, #0x1
               	add	x1, x1, x0
               	lsl	x6, x0, #1
               	add	x4, x4, x6
               	add	x3, x3, x0
               	sxth	x3, w3
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	eor	x0, x5, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x1, w1
               	add	x1, x1, x4
               	add	x1, x1, x3
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x1, x1, x0
               	asr	x0, x2, #1
               	lsl	x0, x0, #4
               	add	x0, x2, x0
               	sxtw	x0, w0
               	add	x0, x0, x2
               	lsl	x0, x0, #1
               	add	x0, x1, x0
               	mov	x17, #0x7               // =7
               	mul	x1, x2, x17
               	add	x1, x1, #0x9
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x6, x0, x1
               	mov	x3, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x1, #0x5                // =5
               	b	<addr>
               	add	x3, x3, x1
               	mov	w4, w0
               	cmp	x4, #0x2
               	b.lo	<addr>
               	cmp	x4, #0x2
               	b.eq	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x4, x0
               	b	<addr>
               	add	x1, x1, x2
               	mov	x0, #0x2                // =2
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	w4, w0
               	cmp	x4, #0x0
               	b.ne	<addr>
               	mov	x17, #0x5               // =5
               	mul	x0, x3, x17
               	add	x6, x6, x0
               	mov	x17, #0x5               // =5
               	mul	x0, x2, x17
               	add	x1, x2, #0x1
               	lsl	x3, x2, #1
               	add	x4, x0, x3
               	add	x0, x2, #0x7
               	sxth	x3, w0
               	mov	x17, #0xff              // =255
               	and	x0, x2, x17
               	mov	x17, #0x7a              // =122
               	eor	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x5, x0, x17
               	add	x0, x2, #0x1
               	add	x1, x1, x0
               	lsl	x7, x0, #1
               	add	x4, x4, x7
               	add	x3, x3, x0
               	sxth	x3, w3
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	eor	x0, x5, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x1, w1
               	add	x1, x1, x4
               	add	x1, x1, x3
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x1, x0
               	cmp	x0, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	asr	x0, x2, #1
               	lsl	x0, x0, #4
               	add	x0, x2, x0
               	sxtw	x0, w0
               	add	x0, x0, x2
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x17, #0x7               // =7
               	mul	x0, x2, x17
               	add	x0, x0, #0x9
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x3, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x1, #0x5                // =5
               	b	<addr>
               	add	x3, x3, x1
               	mov	w4, w0
               	cmp	x4, #0x2
               	b.lo	<addr>
               	cmp	x4, #0x2
               	b.eq	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x4, x0
               	b	<addr>
               	add	x1, x1, x2
               	mov	x0, #0x2                // =2
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	w4, w0
               	cmp	x4, #0x0
               	b.ne	<addr>
               	cmp	x3, #0xd
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	cmp	x6, #0x177
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
