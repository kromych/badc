
sroa_struct_fields_promote.aarch64:	file format elf64-littleaarch64

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
               	mov	x17, #0x5               // =5
               	mul	x1, x2, x17
               	add	x0, x2, #0x1
               	add	x1, x1, x2, lsl #1
               	add	x3, x2, #0x7
               	sxth	x3, w3
               	and	x4, x2, #0xff
               	mov	x17, #0x7a              // =122
               	eor	x4, x4, x17
               	add	x5, x0, x0
               	add	x1, x1, x0, lsl #1
               	add	x3, x3, x0
               	sxth	x3, w3
               	and	x0, x0, #0xff
               	eor	x0, x4, x0
               	sxtw	x4, w5
               	add	x1, x4, x1
               	add	x1, x1, x3
               	add	x0, x1, x0
               	asr	x1, x2, #1
               	add	x1, x2, x1, lsl #4
               	sxtw	x1, w1
               	add	x1, x1, x2
               	add	x0, x0, x1, lsl #1
               	mov	x17, #0x7               // =7
               	mul	x1, x2, x17
               	add	x1, x1, #0x9
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x5, x0, x1
               	mov	x4, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x3, x4
               	add	x3, x3, x0
               	cmp	w1, #0x2
               	b.lo	<addr>
               	mov	x1, x4
               	b	<addr>
               	add	x0, x0, x2
               	mov	x1, #0x2                // =2
               	cbnz	w1, <addr>
               	mov	x17, #0x5               // =5
               	mul	x0, x3, x17
               	add	x5, x5, x0
               	mov	x17, #0x5               // =5
               	mul	x1, x2, x17
               	add	x0, x2, #0x1
               	add	x1, x1, x2, lsl #1
               	add	x3, x2, #0x7
               	sxth	x3, w3
               	and	x4, x2, #0xff
               	mov	x17, #0x7a              // =122
               	eor	x4, x4, x17
               	add	x6, x0, x0
               	add	x1, x1, x0, lsl #1
               	add	x3, x3, x0
               	sxth	x3, w3
               	and	x0, x0, #0xff
               	eor	x0, x4, x0
               	sxtw	x4, w6
               	add	x1, x4, x1
               	add	x1, x1, x3
               	add	x0, x1, x0
               	cmp	x0, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	asr	x0, x2, #1
               	add	x0, x2, x0, lsl #4
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
               	mov	x4, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x3, x4
               	add	x3, x3, x0
               	cmp	w1, #0x2
               	b.lo	<addr>
               	mov	x1, x4
               	b	<addr>
               	add	x0, x0, x2
               	mov	x1, #0x2                // =2
               	cbnz	w1, <addr>
               	cmp	x3, #0xd
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	cmp	x5, #0x177
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
