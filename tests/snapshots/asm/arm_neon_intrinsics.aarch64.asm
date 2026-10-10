
arm_neon_intrinsics.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x7                // =7
               	sturb	w0, [x29, #-0x50]
               	mov	x0, #0xc3               // =195
               	sturb	w0, [x29, #-0x40]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x30]
               	mov	x0, #0x26               // =38
               	sturb	w0, [x29, #-0x4f]
               	mov	x0, #0xc6               // =198
               	sturb	w0, [x29, #-0x3f]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x2f]
               	mov	x0, #0x45               // =69
               	sturb	w0, [x29, #-0x4e]
               	mov	x0, #0xc9               // =201
               	sturb	w0, [x29, #-0x3e]
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x2e]
               	mov	x0, #0x64               // =100
               	sturb	w0, [x29, #-0x4d]
               	mov	x0, #0xcc               // =204
               	sturb	w0, [x29, #-0x3d]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0x2d]
               	mov	x0, #0x83               // =131
               	sturb	w0, [x29, #-0x4c]
               	mov	x0, #0xd7               // =215
               	sturb	w0, [x29, #-0x3c]
               	mov	x0, #0x11               // =17
               	sturb	w0, [x29, #-0x2c]
               	mov	x0, #0xa2               // =162
               	sturb	w0, [x29, #-0x4b]
               	mov	x0, #0xda               // =218
               	sturb	w0, [x29, #-0x3b]
               	mov	x0, #0x1a               // =26
               	sturb	w0, [x29, #-0x2b]
               	mov	x0, #0xc1               // =193
               	sturb	w0, [x29, #-0x4a]
               	mov	x0, #0xdd               // =221
               	sturb	w0, [x29, #-0x3a]
               	mov	x0, #0x25               // =37
               	sturb	w0, [x29, #-0x2a]
               	mov	x0, #0xe0               // =224
               	sturb	w0, [x29, #-0x49]
               	sturb	w0, [x29, #-0x39]
               	mov	x0, #0x32               // =50
               	sturb	w0, [x29, #-0x29]
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x48]
               	mov	x1, #0xeb               // =235
               	sturb	w1, [x29, #-0x38]
               	mov	x1, #0x41               // =65
               	sturb	w1, [x29, #-0x28]
               	mov	x1, #0x1e               // =30
               	sturb	w1, [x29, #-0x47]
               	mov	x1, #0xee               // =238
               	sturb	w1, [x29, #-0x37]
               	mov	x1, #0x52               // =82
               	sturb	w1, [x29, #-0x27]
               	mov	x1, #0x3d               // =61
               	sturb	w1, [x29, #-0x46]
               	mov	x1, #0xf1               // =241
               	sturb	w1, [x29, #-0x36]
               	mov	x1, #0x65               // =101
               	sturb	w1, [x29, #-0x26]
               	mov	x1, #0x5c               // =92
               	sturb	w1, [x29, #-0x45]
               	mov	x1, #0xf4               // =244
               	sturb	w1, [x29, #-0x35]
               	mov	x1, #0x7a               // =122
               	sturb	w1, [x29, #-0x25]
               	mov	x1, #0x7b               // =123
               	sturb	w1, [x29, #-0x44]
               	sturb	w0, [x29, #-0x34]
               	mov	x0, #0x91               // =145
               	sturb	w0, [x29, #-0x24]
               	mov	x0, #0x9a               // =154
               	sturb	w0, [x29, #-0x43]
               	mov	x0, #0x82               // =130
               	sturb	w0, [x29, #-0x33]
               	mov	x0, #0xaa               // =170
               	sturb	w0, [x29, #-0x23]
               	mov	x0, #0xb9               // =185
               	sturb	w0, [x29, #-0x42]
               	mov	x0, #0x85               // =133
               	sturb	w0, [x29, #-0x32]
               	mov	x0, #0xc5               // =197
               	sturb	w0, [x29, #-0x22]
               	mov	x0, #0xd8               // =216
               	sturb	w0, [x29, #-0x41]
               	mov	x0, #0x88               // =136
               	sturb	w0, [x29, #-0x31]
               	mov	x0, #0xe2               // =226
               	sturb	w0, [x29, #-0x21]
               	mov	x4, #0x1d               // =29
               	mov	x16, #0x1d              // =29
               	dup	v2.16b, w16
               	sub	x1, x29, #0x50
               	sub	x16, x29, #0x50
               	ldr	q0, [x16]
               	sub	x2, x29, #0x40
               	sub	x16, x29, #0x40
               	ldr	q1, [x16]
               	eor	v3.16b, v0.16b, v1.16b
               	sshr	v4.16b, v0.16b, #0x7
               	shl	v0.16b, v0.16b, #0x1
               	and	v2.16b, v4.16b, v2.16b
               	eor	v0.16b, v0.16b, v2.16b
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x3, x29, #0x20
               	sub	x16, x29, #0x20
               	str	q3, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w5, [x3, x0]
               	ldrb	w6, [x1, x0]
               	ldrb	w7, [x2, x0]
               	eor	x6, x6, x7
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldrb	w6, [x5, x0]
               	ldrb	w3, [x1, x0]
               	lsl	x7, x3, #1
               	tbz	w3, #0x7, <addr>
               	mov	x3, x4
               	eor	x3, x7, x3
               	and	x3, x3, #0xff
               	sub	x7, x29, #0x40
               	ldrb	w7, [x7, x0]
               	eor	x3, x3, x7
               	cmp	w6, w3
               	b.eq	<addr>
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x10]
               	mov	x0, #0xb                // =11
               	sturb	w0, [x29, #-0xf]
               	mov	x0, #0x14               // =20
               	sturb	w0, [x29, #-0xe]
               	mov	x0, #0x1d               // =29
               	sturb	w0, [x29, #-0xd]
               	mov	x0, #0x26               // =38
               	sturb	w0, [x29, #-0xc]
               	mov	x0, #0x2f               // =47
               	sturb	w0, [x29, #-0xb]
               	mov	x0, #0x38               // =56
               	sturb	w0, [x29, #-0xa]
               	mov	x0, #0x41               // =65
               	sturb	w0, [x29, #-0x9]
               	mov	x0, #0x4a               // =74
               	sturb	w0, [x29, #-0x8]
               	mov	x0, #0x53               // =83
               	sturb	w0, [x29, #-0x7]
               	mov	x0, #0x5c               // =92
               	sturb	w0, [x29, #-0x6]
               	mov	x0, #0x65               // =101
               	sturb	w0, [x29, #-0x5]
               	mov	x0, #0x6e               // =110
               	sturb	w0, [x29, #-0x4]
               	mov	x0, #0x77               // =119
               	sturb	w0, [x29, #-0x3]
               	mov	x0, #0x80               // =128
               	sturb	w0, [x29, #-0x2]
               	mov	x0, #0x89               // =137
               	sturb	w0, [x29, #-0x1]
               	sub	x16, x29, #0x10
               	ldr	q0, [x16]
               	sub	x1, x29, #0x30
               	sub	x16, x29, #0x30
               	ldr	q1, [x16]
               	mov	x16, #0xf               // =15
               	dup	v2.16b, w16
               	and	v1.16b, v1.16b, v2.16b
               	tbl	v0.16b, { v0.16b }, v1.16b
               	sub	x2, x29, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	sub	x4, x29, #0x10
               	ldrb	w5, [x1, x0]
               	and	x5, x5, #0xf
               	ldrb	w4, [x4, x5]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x16, x29, #0x50
               	ldr	q0, [x16]
               	sub	x3, x29, #0x40
               	sub	x16, x29, #0x40
               	ldr	q1, [x16]
               	pmul	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x50
               	ldrb	w4, [x1, x2]
               	mov	x1, x0
               	ldrb	w5, [x3, x2]
               	mov	x6, #0x1                // =1
               	lsl	x6, x6, x0
               	sxtw	x6, w6
               	and	x5, x5, x6
               	cbz	x5, <addr>
               	lsl	x5, x4, x0
               	and	x5, x5, #0xff
               	eor	x1, x1, x5
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, x2]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x50
               	sub	x16, x29, #0x50
               	ldr	q0, [x16]
               	sub	x2, x29, #0x40
               	sub	x16, x29, #0x40
               	ldr	q1, [x16]
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x3, x29, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x1, x0]
               	ldrb	w6, [x2, x0]
               	eor	x5, x5, x6
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
