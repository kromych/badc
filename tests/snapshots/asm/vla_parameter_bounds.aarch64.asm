
vla_parameter_bounds.aarch64:	file format elf64-littleaarch64

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

<pointer>:
               	sxtw	x7, w0
               	sxtw	x1, w1
               	lsl	x5, x1, #2
               	mul	x8, x7, x5
               	mov	x4, #0x0                // =0
               	mov	x0, x4
               	cmp	w4, w7
               	b.ge	<addr>
               	mov	x3, #0x0                // =0
               	cmp	w3, w1
               	b.ge	<addr>
               	madd	x6, x4, x5, x2
               	ldrsw	x6, [x6, x3, lsl #2]
               	add	x0, x0, x6
               	add	x3, x3, #0x1
               	cmp	w3, w1
               	b.lt	<addr>
               	add	x4, x4, #0x1
               	cmp	w4, w7
               	b.lt	<addr>
               	mul	x2, x7, x1
               	sxtw	x2, w2
               	lsl	x2, x2, #2
               	cmp	x8, x2
               	b.ne	<addr>
               	lsl	x1, x1, #2
               	cmp	x5, x1
               	b.ne	<addr>
               	ret
               	mov	x0, #-0x1               // =-1
               	b	<addr>

<rows>:
               	sxtw	x0, w0
               	sxtw	x3, w3
               	sxtw	x1, w1
               	lsl	x4, x1, #2
               	mul	x5, x0, x4
               	mul	x6, x0, x1
               	sxtw	x6, w6
               	lsl	x6, x6, #2
               	cmp	x5, x6
               	b.ne	<addr>
               	cmp	x4, x4
               	b.eq	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	madd	x3, x3, x5, x2
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	madd	x0, x0, x4, x3
               	sub	x1, x1, #0x1
               	ldrsw	x1, [x0, w1, sxtw #2]
               	add	x0, x2, x5
               	sub	x0, x0, x2
               	asr	x2, x0, #63
               	add	x0, x0, x2, lsr #62
               	add	x0, x1, x0, asr #2
               	ret

<mixed>:
               	sxtw	x0, w0
               	lsl	x2, x0, #2
               	mov	x17, #0x3               // =3
               	mul	x3, x2, x17
               	mov	x17, #0x3               // =3
               	mul	x4, x0, x17
               	sxtw	x4, w4
               	lsl	x4, x4, #2
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x1, x1, x3
               	add	x1, x1, x2, lsl #1
               	sub	x0, x0, #0x1
               	ldrsw	x0, [x1, w0, sxtw #2]
               	ret
               	mov	x0, #-0x1               // =-1
               	b	<addr>

<unnamed>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	lsl	x3, x1, #2
               	mul	x4, x0, x3
               	mul	x5, x0, x1
               	sxtw	x5, w5
               	lsl	x5, x5, #2
               	cmp	x4, x5
               	b.ne	<addr>
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	madd	x0, x0, x3, x2
               	sub	x1, x1, #0x1
               	ldrsw	x0, [x0, w1, sxtw #2]
               	ret
               	mov	x0, #-0x1               // =-1
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	sub	x2, x29, #0x108
               	mov	x0, #0x0                // =0
               	str	w0, [sp, #0x8]
               	mov	x1, #0x1                // =1
               	str	w1, [sp, #0xc]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x100]
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0xfc]
               	add	x1, x2, #0x10
               	mov	x3, #0xa                // =10
               	str	w3, [x1]
               	mov	x3, #0xb                // =11
               	str	w3, [x1, #0x4]
               	mov	x3, #0xc                // =12
               	str	w3, [x1, #0x8]
               	mov	x3, #0xd                // =13
               	str	w3, [x1, #0xc]
               	add	x1, x2, #0x20
               	mov	x2, #0x14               // =20
               	str	w2, [x1]
               	mov	x2, #0x15               // =21
               	str	w2, [x1, #0x4]
               	mov	x2, #0x16               // =22
               	str	w2, [x1, #0x8]
               	mov	x2, #0x17               // =23
               	str	w2, [x1, #0xc]
               	mov	x3, #0x30               // =48
               	mov	x4, #0x64               // =100
               	sub	x1, x29, #0xd8
               	mul	x5, x0, x3
               	add	x1, x1, x5
               	mul	x2, x0, x4
               	str	w2, [x1]
               	add	x6, x2, #0x1
               	str	w6, [x1, #0x4]
               	add	x6, x2, #0x2
               	str	w6, [x1, #0x8]
               	add	x6, x2, #0x3
               	str	w6, [x1, #0xc]
               	add	x1, x1, #0x10
               	add	x2, x2, #0xa
               	str	w2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0xd8
               	add	x2, x1, x5
               	add	x6, x2, #0x10
               	mul	x2, x0, x4
               	add	x5, x2, #0xa
               	add	x7, x5, #0x2
               	str	w7, [x6, #0x8]
               	mul	x6, x0, x3
               	add	x1, x1, x6
               	add	x6, x1, #0x10
               	add	x5, x5, #0x3
               	str	w5, [x6, #0xc]
               	add	x1, x1, #0x20
               	add	x2, x2, #0x14
               	str	w2, [x1]
               	add	x5, x2, #0x1
               	str	w5, [x1, #0x4]
               	add	x5, x2, #0x2
               	str	w5, [x1, #0x8]
               	add	x2, x2, #0x3
               	str	w2, [x1, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3c               // =60
               	mov	x4, #0x64               // =100
               	sub	x1, x29, #0x78
               	mul	x5, x0, x3
               	add	x1, x1, x5
               	mul	x2, x0, x4
               	str	w2, [x1]
               	add	x6, x2, #0x1
               	str	w6, [x1, #0x4]
               	add	x6, x2, #0x2
               	str	w6, [x1, #0x8]
               	add	x6, x2, #0x3
               	str	w6, [x1, #0xc]
               	add	x6, x2, #0x4
               	str	w6, [x1, #0x10]
               	add	x1, x1, #0x14
               	add	x2, x2, #0xa
               	str	w2, [x1]
               	sub	x2, x29, #0x78
               	add	x1, x2, x5
               	add	x6, x1, #0x14
               	mul	x5, x0, x4
               	add	x1, x5, #0xa
               	add	x7, x1, #0x1
               	str	w7, [x6, #0x4]
               	mul	x6, x0, x3
               	add	x7, x2, x6
               	add	x2, x7, #0x14
               	add	x8, x1, #0x2
               	str	w8, [x2, #0x8]
               	add	x8, x1, #0x3
               	str	w8, [x2, #0xc]
               	add	x1, x1, #0x4
               	str	w1, [x2, #0x10]
               	add	x2, x7, #0x28
               	add	x1, x5, #0x14
               	str	w1, [x2]
               	sub	x2, x29, #0x78
               	add	x5, x2, x6
               	add	x5, x5, #0x28
               	add	x1, x1, #0x1
               	str	w1, [x5, #0x4]
               	mul	x1, x0, x4
               	add	x1, x1, #0x14
               	add	x6, x1, #0x2
               	str	w6, [x5, #0x8]
               	mul	x5, x0, x3
               	add	x2, x2, x5
               	add	x2, x2, #0x28
               	add	x5, x1, #0x3
               	str	w5, [x2, #0xc]
               	add	x1, x1, #0x4
               	str	w1, [x2, #0x10]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x3, x29, #0x108
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, #0x0                // =0
               	add	x4, x3, x2, lsl #4
               	ldrsw	x4, [x4, x0, lsl #2]
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	cmp	w1, #0x8a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd8
               	add	x1, x0, #0x30
               	add	x2, x1, #0x20
               	ldrsw	x2, [x2, #0xc]
               	sub	x1, x1, x0
               	asr	x3, x1, #63
               	add	x1, x1, x3, lsr #62
               	add	x1, x2, x1, asr #2
               	cmp	w1, #0x87
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x78
               	add	x1, x1, #0x3c
               	add	x1, x1, #0x28
               	ldrsw	x1, [x1, #0x10]
               	cmp	w1, #0x7c
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x20
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
