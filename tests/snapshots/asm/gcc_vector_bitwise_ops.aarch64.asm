
gcc_vector_bitwise_ops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x3, x0
               	sub	x0, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x20
               	ldr	x4, [x1]
               	ldr	x5, [x2]
               	eor	x4, x4, x5
               	str	x4, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<same16>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x2, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x1f0]!
               	stp	x29, x30, [sp, #0x1e0]
               	add	x29, sp, #0x1e0
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x20, x29, #0x10
               	sub	x2, x29, #0x20
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x40
               	add	x4, x3, x0
               	add	x3, x20, x0
               	ldrb	w3, [x3]
               	add	x5, x2, x0
               	ldrb	w5, [x5]
               	eor	x3, x3, x5
               	strb	w3, [x4]
               	sub	x3, x29, #0x50
               	add	x4, x3, x0
               	add	x3, x20, x0
               	ldrb	w3, [x3]
               	add	x5, x2, x0
               	ldrb	w5, [x5]
               	and	x3, x3, x5
               	strb	w3, [x4]
               	sub	x3, x29, #0x60
               	add	x4, x3, x0
               	add	x3, x20, x0
               	ldrb	w3, [x3]
               	add	x5, x2, x0
               	ldrb	w5, [x5]
               	orr	x3, x3, x5
               	strb	w3, [x4]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x20
               	sub	x0, x29, #0x130
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	eor	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x40
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x20
               	sub	x0, x29, #0x140
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	and	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x50
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x20
               	sub	x0, x29, #0x150
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	orr	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	orr	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x60
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	eor	x2, x2, x3
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	eor	x3, x0, x1
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x170
               	ldr	x4, [x1]
               	eor	x2, x2, x4
               	str	x2, [x0]
               	ldr	x1, [x1, #0x8]
               	eor	x1, x3, x1
               	str	x1, [x0, #0x8]
               	mov	x2, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x78
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x78
               	sub	x1, x29, #0x78
               	sub	x2, x29, #0x20
               	sub	x0, x29, #0x180
               	ldr	x4, [x1]
               	ldr	x5, [x2]
               	eor	x4, x4, x5
               	str	x4, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x40
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x78
               	sub	x1, x29, #0x78
               	sub	x2, x29, #0x20
               	sub	x0, x29, #0x190
               	ldr	x4, [x1]
               	ldr	x5, [x2]
               	and	x4, x4, x5
               	str	x4, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	and	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x50
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x78
               	sub	x1, x29, #0x78
               	sub	x2, x29, #0x20
               	sub	x0, x29, #0x1a0
               	ldr	x4, [x1]
               	ldr	x5, [x2]
               	orr	x4, x4, x5
               	str	x4, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	orr	x1, x1, x2
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x60
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x98
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x1, x29, #0x88
               	sub	x2, x29, #0x98
               	sub	x0, x29, #0x1b0
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	eor	x3, x3, x4
               	str	x3, [x0]
               	ldr	x1, [x1, #0x8]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x2
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa8
               	sub	x1, x29, #0x40
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0xb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb0
               	sub	x1, x29, #0xb0
               	sub	x2, x29, #0xb8
               	ldr	x1, [x1]
               	ldr	x2, [x2]
               	eor	x1, x1, x2
               	str	x1, [x0]
               	sub	x1, x29, #0xb0
               	ldrb	w0, [x1]
               	mov	x17, #0xfe              // =254
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrb	w0, [x1, #0x1]
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0x7]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x20, x29, #0xd0
               	sub	x21, x29, #0xe0
               	add	x0, x20, #0x0
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	add	x0, x21, #0x0
               	mov	x1, #0xc8               // =200
               	strb	w1, [x0]
               	mov	x0, #0x8                // =8
               	strb	w0, [x20, #0x1]
               	mov	x0, #0xc7               // =199
               	strb	w0, [x21, #0x1]
               	mov	x0, #0xf                // =15
               	strb	w0, [x20, #0x2]
               	mov	x0, #0xc6               // =198
               	strb	w0, [x21, #0x2]
               	mov	x0, #0x16               // =22
               	strb	w0, [x20, #0x3]
               	mov	x0, #0xc5               // =197
               	strb	w0, [x21, #0x3]
               	mov	x0, #0x1d               // =29
               	strb	w0, [x20, #0x4]
               	mov	x0, #0xc4               // =196
               	strb	w0, [x21, #0x4]
               	mov	x0, #0x24               // =36
               	strb	w0, [x20, #0x5]
               	mov	x0, #0xc3               // =195
               	strb	w0, [x21, #0x5]
               	mov	x0, #0x2b               // =43
               	strb	w0, [x20, #0x6]
               	mov	x0, #0xc2               // =194
               	strb	w0, [x21, #0x6]
               	mov	x0, #0x32               // =50
               	strb	w0, [x20, #0x7]
               	mov	x0, #0xc1               // =193
               	strb	w0, [x21, #0x7]
               	mov	x0, #0x39               // =57
               	strb	w0, [x20, #0x8]
               	mov	x0, #0xc0               // =192
               	strb	w0, [x21, #0x8]
               	mov	x0, #0x40               // =64
               	strb	w0, [x20, #0x9]
               	mov	x0, #0xbf               // =191
               	strb	w0, [x21, #0x9]
               	mov	x0, #0x47               // =71
               	strb	w0, [x20, #0xa]
               	mov	x0, #0xbe               // =190
               	strb	w0, [x21, #0xa]
               	mov	x0, #0x4e               // =78
               	strb	w0, [x20, #0xb]
               	mov	x0, #0xbd               // =189
               	strb	w0, [x21, #0xb]
               	mov	x0, #0x55               // =85
               	strb	w0, [x20, #0xc]
               	mov	x0, #0xbc               // =188
               	strb	w0, [x21, #0xc]
               	mov	x0, #0x5c               // =92
               	strb	w0, [x20, #0xd]
               	mov	x0, #0xbb               // =187
               	strb	w0, [x21, #0xd]
               	mov	x0, #0x63               // =99
               	strb	w0, [x20, #0xe]
               	mov	x0, #0xba               // =186
               	strb	w0, [x21, #0xe]
               	mov	x0, #0x6a               // =106
               	strb	w0, [x20, #0xf]
               	mov	x0, #0xb9               // =185
               	strb	w0, [x21, #0xf]
               	sub	x0, x29, #0xf0
               	sub	x1, x29, #0xd0
               	sub	x2, x29, #0xe0
               	bl	<addr>
               	sub	x2, x29, #0xf0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	add	x4, x20, x1
               	ldrb	w4, [x4]
               	add	x5, x21, x1
               	ldrb	w5, [x5]
               	eor	x4, x4, x5
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x1e0]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
