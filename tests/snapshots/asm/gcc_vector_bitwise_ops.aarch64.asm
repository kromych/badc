
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	sub	x2, x29, #0x88
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x78
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x68
               	add	x7, x4, x0
               	add	x4, x2, x0
               	ldrb	w6, [x4]
               	add	x5, x3, x0
               	ldrb	w8, [x5]
               	eor	x6, x6, x8
               	strb	w6, [x7]
               	sub	x6, x29, #0x58
               	add	x7, x6, x0
               	ldrb	w6, [x4]
               	ldrb	w8, [x5]
               	and	x6, x6, x8
               	strb	w6, [x7]
               	sub	x6, x29, #0x48
               	add	x6, x6, x0
               	ldrb	w4, [x4]
               	ldrb	w5, [x5]
               	orr	x4, x4, x5
               	strb	w4, [x6]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x78
               	sub	x3, x29, #0x28
               	ldr	x4, [x0]
               	ldr	x5, [x1]
               	eor	x4, x4, x5
               	str	x4, [x3]
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	eor	x0, x0, x1
               	str	x0, [x3, #0x8]
               	sub	x4, x29, #0x68
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	cmp	x5, x6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x78
               	sub	x3, x29, #0x28
               	ldr	x4, [x0]
               	ldr	x5, [x1]
               	and	x4, x4, x5
               	str	x4, [x3]
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	and	x0, x0, x1
               	str	x0, [x3, #0x8]
               	sub	x4, x29, #0x58
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	cmp	x5, x6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x78
               	sub	x3, x29, #0x28
               	ldr	x4, [x0]
               	ldr	x5, [x1]
               	orr	x4, x4, x5
               	str	x4, [x3]
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	orr	x0, x0, x1
               	str	x0, [x3, #0x8]
               	sub	x4, x29, #0x48
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	cmp	x5, x6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x88
               	sub	x0, x29, #0x78
               	ldr	x3, [x1]
               	ldr	x4, [x0]
               	eor	x5, x3, x4
               	ldr	x1, [x1, #0x8]
               	ldr	x3, [x0, #0x8]
               	eor	x1, x1, x3
               	sub	x3, x29, #0x28
               	eor	x4, x5, x4
               	str	x4, [x3]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x1, x0
               	str	x0, [x3, #0x8]
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
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	sub	x2, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x1, x29, #0x78
               	sub	x0, x29, #0x28
               	ldr	x3, [x2]
               	ldr	x4, [x1]
               	eor	x3, x3, x4
               	str	x3, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x1, [x1, #0x8]
               	eor	x1, x3, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x68
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x38
               	sub	x0, x29, #0x88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x1, x29, #0x78
               	sub	x0, x29, #0x28
               	ldr	x3, [x2]
               	ldr	x4, [x1]
               	and	x3, x3, x4
               	str	x3, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x1, [x1, #0x8]
               	and	x1, x3, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x58
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x38
               	sub	x0, x29, #0x88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x1, x29, #0x78
               	sub	x0, x29, #0x28
               	ldr	x3, [x2]
               	ldr	x4, [x1]
               	orr	x3, x3, x4
               	str	x3, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x1, [x1, #0x8]
               	orr	x1, x3, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x48
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x78
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x28
               	eor	x1, x1, x3
               	str	x1, [x0]
               	eor	x1, x2, x4
               	str	x1, [x0, #0x8]
               	sub	x2, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x68
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
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
               	mov	x4, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x2               // =2
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0x7]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x58
               	sub	x2, x29, #0x48
               	add	x0, x3, #0x0
               	strb	w4, [x0]
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
               	sub	x4, x29, #0x38
               	ldr	x1, [x3]
               	ldr	x5, [x3, #0x8]
               	sub	x0, x29, #0x18
               	ldr	x6, [x2]
               	eor	x1, x1, x6
               	str	x1, [x0]
               	ldr	x1, [x2, #0x8]
               	eor	x1, x5, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x5, x4, x1
               	ldrb	w5, [x5]
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	add	x7, x2, x1
               	ldrb	w7, [x7]
               	eor	x6, x6, x7
               	mov	x17, #0xff              // =255
               	and	x6, x6, x17
               	cmp	x5, x6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x1, x4
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
