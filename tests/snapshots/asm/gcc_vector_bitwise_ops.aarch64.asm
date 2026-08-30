
gcc_vector_bitwise_ops.aarch64:	file format elf64-littleaarch64

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

<same16>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	sub	x0, x29, #0x10
               	add	x2, x0, #0x0
               	ldrb	w2, [x2]
               	add	x3, x1, #0x0
               	ldrb	w3, [x3]
               	cmp	w2, w3
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x1, #0x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x2]
               	ldrb	w3, [x1, #0x2]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x3]
               	ldrb	w3, [x1, #0x3]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x4]
               	ldrb	w3, [x1, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x5]
               	ldrb	w3, [x1, #0x5]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x6]
               	ldrb	w3, [x1, #0x6]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x7]
               	ldrb	w3, [x1, #0x7]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x8]
               	ldrb	w3, [x1, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x9]
               	ldrb	w3, [x1, #0x9]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0xa]
               	ldrb	w3, [x1, #0xa]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0xb]
               	ldrb	w3, [x1, #0xb]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0xc]
               	ldrb	w3, [x1, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0xd]
               	ldrb	w3, [x1, #0xd]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x0, #0xe]
               	ldrb	w3, [x1, #0xe]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w0, [x0, #0xf]
               	ldrb	w1, [x1, #0xf]
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xd0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	sub	x20, x29, #0x48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x2, x29, #0x78
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x38
               	sxtw	x0, w1
               	add	x6, x3, x0
               	add	x3, x20, x0
               	ldrb	w5, [x3]
               	add	x4, x2, x0
               	ldrb	w7, [x4]
               	eor	x5, x5, x7
               	strb	w5, [x6]
               	sub	x5, x29, #0x28
               	add	x6, x5, x0
               	ldrb	w5, [x3]
               	ldrb	w7, [x4]
               	and	x5, x5, x7
               	strb	w5, [x6]
               	sub	x5, x29, #0x18
               	add	x5, x5, x0
               	ldrb	w3, [x3]
               	ldrb	w4, [x4]
               	orr	x3, x3, x4
               	strb	w3, [x5]
               	add	x1, x0, #0x1
               	cmp	w1, #0x10
               	b.lt	<addr>
               	sub	x22, x29, #0x48
               	sub	x23, x29, #0x78
               	sub	x21, x29, #0x58
               	ldr	x0, [x22]
               	ldr	x1, [x23]
               	eor	x0, x0, x1
               	str	x0, [x21]
               	ldr	x0, [x22, #0x8]
               	ldr	x1, [x23, #0x8]
               	eor	x0, x0, x1
               	str	x0, [x21, #0x8]
               	sub	x1, x29, #0x38
               	mov	x0, x21
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	ldr	x0, [x22]
               	ldr	x1, [x23]
               	and	x0, x0, x1
               	str	x0, [x21]
               	ldr	x0, [x22, #0x8]
               	ldr	x1, [x23, #0x8]
               	and	x0, x0, x1
               	str	x0, [x21, #0x8]
               	sub	x1, x29, #0x28
               	mov	x0, x21
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x22, x29, #0x48
               	sub	x21, x29, #0x78
               	sub	x0, x29, #0x58
               	ldr	x1, [x22]
               	ldr	x2, [x21]
               	orr	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x22, #0x8]
               	ldr	x2, [x21, #0x8]
               	orr	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x18
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	ldr	x1, [x22]
               	ldr	x0, [x21]
               	eor	x1, x1, x0
               	ldr	x2, [x22, #0x8]
               	ldr	x3, [x21, #0x8]
               	eor	x2, x2, x3
               	sub	x22, x29, #0x58
               	eor	x0, x1, x0
               	str	x0, [x22]
               	ldr	x0, [x21, #0x8]
               	eor	x0, x2, x0
               	str	x0, [x22, #0x8]
               	mov	x0, x22
               	mov	x2, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x21, x29, #0x48
               	sub	x20, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x20]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x0, x29, #0x78
               	ldr	x1, [x20]
               	ldr	x2, [x0]
               	eor	x1, x1, x2
               	str	x1, [x22]
               	ldr	x1, [x20, #0x8]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x1, x0
               	str	x0, [x22, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x20]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x1, x29, #0x38
               	mov	x0, x20
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x20]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x22, x29, #0x78
               	sub	x0, x29, #0x58
               	ldr	x1, [x20]
               	ldr	x2, [x22]
               	and	x1, x1, x2
               	str	x1, [x0]
               	ldr	x1, [x20, #0x8]
               	ldr	x2, [x22, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x20, x29, #0x68
               	sub	x1, x29, #0x28
               	mov	x0, x20
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x23, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x23]
               	str	x10, [x20]
               	ldr	x10, [x23, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x21, x29, #0x58
               	ldr	x0, [x20]
               	ldr	x1, [x22]
               	orr	x0, x0, x1
               	str	x0, [x21]
               	ldr	x0, [x20, #0x8]
               	ldr	x1, [x22, #0x8]
               	orr	x0, x0, x1
               	str	x0, [x21, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x20]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x22, x29, #0x68
               	sub	x1, x29, #0x18
               	mov	x0, x22
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	ldr	x0, [x23]
               	ldr	x1, [x23, #0x8]
               	sub	x20, x29, #0x78
               	ldr	x2, [x20]
               	ldr	x3, [x20, #0x8]
               	eor	x0, x0, x2
               	str	x0, [x21]
               	eor	x0, x1, x3
               	str	x0, [x21, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x22]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x22, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	sub	x1, x29, #0x38
               	mov	x0, x22
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, #0x2fe              // =766
               	movk	x1, #0x4fc, lsl #16
               	movk	x1, #0x6fa, lsl #32
               	movk	x1, #0x8f8, lsl #48
               	str	x1, [x0]
               	ldrb	w1, [x0]
               	mov	x17, #0xfe              // =254
               	eor	x1, x1, x17
               	mov	w1, w1
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x2               // =2
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0x7]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x2, x29, #0x98
               	sub	x1, x29, #0x88
               	add	x0, x2, #0x0
               	strb	w3, [x0]
               	add	x0, x1, #0x0
               	mov	x3, #0xc8               // =200
               	strb	w3, [x0]
               	mov	x0, #0x8                // =8
               	strb	w0, [x2, #0x1]
               	mov	x0, #0xc7               // =199
               	strb	w0, [x1, #0x1]
               	mov	x0, #0xf                // =15
               	strb	w0, [x2, #0x2]
               	mov	x0, #0xc6               // =198
               	strb	w0, [x1, #0x2]
               	mov	x0, #0x16               // =22
               	strb	w0, [x2, #0x3]
               	mov	x0, #0xc5               // =197
               	strb	w0, [x1, #0x3]
               	mov	x0, #0x1d               // =29
               	strb	w0, [x2, #0x4]
               	mov	x0, #0xc4               // =196
               	strb	w0, [x1, #0x4]
               	mov	x0, #0x24               // =36
               	strb	w0, [x2, #0x5]
               	mov	x0, #0xc3               // =195
               	strb	w0, [x1, #0x5]
               	mov	x0, #0x2b               // =43
               	strb	w0, [x2, #0x6]
               	mov	x0, #0xc2               // =194
               	strb	w0, [x1, #0x6]
               	mov	x0, #0x32               // =50
               	strb	w0, [x2, #0x7]
               	mov	x0, #0xc1               // =193
               	strb	w0, [x1, #0x7]
               	mov	x0, #0x39               // =57
               	strb	w0, [x2, #0x8]
               	mov	x0, #0xc0               // =192
               	strb	w0, [x1, #0x8]
               	mov	x0, #0x40               // =64
               	strb	w0, [x2, #0x9]
               	mov	x0, #0xbf               // =191
               	strb	w0, [x1, #0x9]
               	mov	x0, #0x47               // =71
               	strb	w0, [x2, #0xa]
               	mov	x0, #0xbe               // =190
               	strb	w0, [x1, #0xa]
               	mov	x0, #0x4e               // =78
               	strb	w0, [x2, #0xb]
               	mov	x0, #0xbd               // =189
               	strb	w0, [x1, #0xb]
               	mov	x0, #0x55               // =85
               	strb	w0, [x2, #0xc]
               	mov	x0, #0xbc               // =188
               	strb	w0, [x1, #0xc]
               	mov	x0, #0x5c               // =92
               	strb	w0, [x2, #0xd]
               	mov	x0, #0xbb               // =187
               	strb	w0, [x1, #0xd]
               	mov	x0, #0x63               // =99
               	strb	w0, [x2, #0xe]
               	mov	x0, #0xba               // =186
               	strb	w0, [x1, #0xe]
               	mov	x0, #0x6a               // =106
               	strb	w0, [x2, #0xf]
               	mov	x0, #0xb9               // =185
               	strb	w0, [x1, #0xf]
               	ldr	x3, [x2]
               	ldr	x4, [x2, #0x8]
               	sub	x0, x29, #0x58
               	ldr	x5, [x1]
               	eor	x3, x3, x5
               	str	x3, [x0]
               	ldr	x3, [x1, #0x8]
               	eor	x3, x4, x3
               	str	x3, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sxtw	x3, w0
               	add	x5, x20, x3
               	ldrb	w5, [x5]
               	add	x6, x2, x3
               	ldrb	w6, [x6]
               	add	x7, x1, x3
               	ldrb	w7, [x7]
               	eor	x6, x6, x7
               	and	x6, x6, x4
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
