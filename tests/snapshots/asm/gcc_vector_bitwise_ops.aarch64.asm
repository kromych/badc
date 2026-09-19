
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	q0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	add	x2, x1, #0x0
               	ldrb	w2, [x2]
               	add	x3, x0, #0x0
               	ldrb	w3, [x3]
               	cmp	w2, w3
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x1, #0x1]
               	ldrb	w3, [x0, #0x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x2]
               	ldrb	w3, [x0, #0x2]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x3]
               	ldrb	w3, [x0, #0x3]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x5]
               	ldrb	w3, [x0, #0x5]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x6]
               	ldrb	w3, [x0, #0x6]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x7]
               	ldrb	w3, [x0, #0x7]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x9]
               	ldrb	w3, [x0, #0x9]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0xa]
               	ldrb	w3, [x0, #0xa]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0xb]
               	ldrb	w3, [x0, #0xb]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0xc]
               	ldrb	w3, [x0, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0xd]
               	ldrb	w3, [x0, #0xd]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0xe]
               	ldrb	w3, [x0, #0xe]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w1, [x1, #0xf]
               	ldrb	w0, [x0, #0xf]
               	cmp	w1, w0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x160
               	str	x20, [sp]
               	sub	x20, x29, #0x150
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x140
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x0                // =0
               	cmp	w1, #0x10
               	b.ge	<addr>
               	sub	x3, x29, #0x80
               	sxtw	x0, w1
               	ldrb	w4, [x20, x0]
               	ldrb	w5, [x2, x0]
               	eor	x4, x4, x5
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x70
               	ldrb	w4, [x20, x0]
               	ldrb	w5, [x2, x0]
               	and	x4, x4, x5
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x60
               	ldrb	w4, [x20, x0]
               	ldrb	w5, [x2, x0]
               	orr	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x1, x1, #0x1
               	cmp	w1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x140
               	sub	x7, x29, #0xb0
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	eor	x2, x2, x3
               	str	x2, [x7]
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	eor	x0, x0, x1
               	str	x0, [x7, #0x8]
               	sub	x0, x29, #0x80
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x140
               	sub	x7, x29, #0xb0
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	and	x2, x2, x3
               	str	x2, [x7]
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	and	x0, x0, x1
               	str	x0, [x7, #0x8]
               	sub	x0, x29, #0x70
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x140
               	sub	x7, x29, #0xb0
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	orr	x2, x2, x3
               	str	x2, [x7]
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	orr	x0, x0, x1
               	str	x0, [x7, #0x8]
               	sub	x0, x29, #0x60
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x150
               	sub	x0, x29, #0x140
               	ldr	x3, [x1]
               	ldr	x2, [x0]
               	eor	x3, x3, x2
               	ldr	x1, [x1, #0x8]
               	ldr	x4, [x0, #0x8]
               	eor	x1, x1, x4
               	sub	x7, x29, #0xb0
               	eor	x2, x3, x2
               	str	x2, [x7]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x1, x0
               	str	x0, [x7, #0x8]
               	ldr	q0, [x7]
               	mov	x0, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	sub	x7, x29, #0x130
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x7]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x7, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x140
               	ldr	x1, [x7]
               	ldr	x2, [x0]
               	eor	x1, x1, x2
               	ldr	x2, [x7, #0x8]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x2, x0
               	str	x1, [x7]
               	str	x0, [x7, #0x8]
               	sub	x0, x29, #0x80
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x130
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x7]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x7, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x140
               	ldr	x1, [x7]
               	ldr	x2, [x0]
               	and	x1, x1, x2
               	ldr	x2, [x7, #0x8]
               	ldr	x0, [x0, #0x8]
               	and	x0, x2, x0
               	str	x1, [x7]
               	str	x0, [x7, #0x8]
               	sub	x0, x29, #0x70
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x130
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x7]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x7, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x140
               	ldr	x1, [x7]
               	ldr	x2, [x0]
               	orr	x1, x1, x2
               	ldr	x2, [x7, #0x8]
               	ldr	x0, [x0, #0x8]
               	orr	x0, x2, x0
               	str	x1, [x7]
               	str	x0, [x7, #0x8]
               	sub	x0, x29, #0x60
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x140
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	sub	x7, x29, #0x100
               	str	x1, [x7]
               	str	x0, [x7, #0x8]
               	sub	x0, x29, #0x80
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x2fe              // =766
               	movk	x1, #0x4fc, lsl #16
               	movk	x1, #0x6fa, lsl #32
               	movk	x1, #0x8f8, lsl #48
               	str	x1, [x0]
               	ldrb	w1, [x0]
               	eor	x1, x1, #0xfe
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	eor	x1, x1, #0x2
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0x7]
               	eor	x0, x0, #0x8
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xf0
               	sub	x2, x29, #0xe0
               	add	x0, x3, #0x0
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	add	x0, x2, #0x0
               	mov	x1, #0xc8               // =200
               	strb	w1, [x0]
               	mov	x0, #0x8                // =8
               	strb	w0, [x3, #0x1]
               	mov	x0, #0xc7               // =199
               	strb	w0, [x2, #0x1]
               	mov	x0, #0xf                // =15
               	strb	w0, [x3, #0x2]
               	mov	x0, #0xc6               // =198
               	strb	w0, [x2, #0x2]
               	mov	x0, #0x16               // =22
               	strb	w0, [x3, #0x3]
               	mov	x0, #0xc5               // =197
               	strb	w0, [x2, #0x3]
               	mov	x0, #0x1d               // =29
               	strb	w0, [x3, #0x4]
               	mov	x0, #0xc4               // =196
               	strb	w0, [x2, #0x4]
               	mov	x0, #0x24               // =36
               	strb	w0, [x3, #0x5]
               	mov	x0, #0xc3               // =195
               	strb	w0, [x2, #0x5]
               	mov	x0, #0x2b               // =43
               	strb	w0, [x3, #0x6]
               	mov	x0, #0xc2               // =194
               	strb	w0, [x2, #0x6]
               	mov	x0, #0x32               // =50
               	strb	w0, [x3, #0x7]
               	mov	x0, #0xc1               // =193
               	strb	w0, [x2, #0x7]
               	mov	x0, #0x39               // =57
               	strb	w0, [x3, #0x8]
               	mov	x0, #0xc0               // =192
               	strb	w0, [x2, #0x8]
               	mov	x0, #0x40               // =64
               	strb	w0, [x3, #0x9]
               	mov	x0, #0xbf               // =191
               	strb	w0, [x2, #0x9]
               	mov	x0, #0x47               // =71
               	strb	w0, [x3, #0xa]
               	mov	x0, #0xbe               // =190
               	strb	w0, [x2, #0xa]
               	mov	x0, #0x4e               // =78
               	strb	w0, [x3, #0xb]
               	mov	x0, #0xbd               // =189
               	strb	w0, [x2, #0xb]
               	mov	x0, #0x55               // =85
               	strb	w0, [x3, #0xc]
               	mov	x0, #0xbc               // =188
               	strb	w0, [x2, #0xc]
               	mov	x0, #0x5c               // =92
               	strb	w0, [x3, #0xd]
               	mov	x0, #0xbb               // =187
               	strb	w0, [x2, #0xd]
               	mov	x0, #0x63               // =99
               	strb	w0, [x3, #0xe]
               	mov	x0, #0xba               // =186
               	strb	w0, [x2, #0xe]
               	mov	x0, #0x6a               // =106
               	strb	w0, [x3, #0xf]
               	mov	x0, #0xb9               // =185
               	strb	w0, [x2, #0xf]
               	sub	x4, x29, #0xd0
               	ldr	x0, [x3]
               	ldr	x1, [x3, #0x8]
               	ldr	x5, [x2]
               	eor	x0, x0, x5
               	ldr	x5, [x2, #0x8]
               	eor	x1, x1, x5
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldrb	w5, [x4, x1]
               	ldrb	w6, [x3, x1]
               	ldrb	w1, [x2, x1]
               	eor	x1, x6, x1
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
