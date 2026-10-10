
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
               	sub	sp, sp, #0x10
               	stur	q0, [x29, #-0x10]
               	ldurb	w1, [x29, #-0x10]
               	ldrb	w2, [x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w1, [x29, #-0xf]
               	ldrb	w2, [x0, #0x1]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0xe]
               	ldrb	w2, [x0, #0x2]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0xd]
               	ldrb	w2, [x0, #0x3]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0xc]
               	ldrb	w2, [x0, #0x4]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0xb]
               	ldrb	w2, [x0, #0x5]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0xa]
               	ldrb	w2, [x0, #0x6]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x9]
               	ldrb	w2, [x0, #0x7]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x8]
               	ldrb	w2, [x0, #0x8]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x7]
               	ldrb	w2, [x0, #0x9]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x6]
               	ldrb	w2, [x0, #0xa]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x5]
               	ldrb	w2, [x0, #0xb]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x4]
               	ldrb	w2, [x0, #0xc]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x3]
               	ldrb	w2, [x0, #0xd]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x2]
               	ldrb	w2, [x0, #0xe]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x1]
               	ldrb	w0, [x0, #0xf]
               	cmp	w1, w0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x1, x29, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x30
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	eor	x4, x4, x5
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x20
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	and	x4, x4, x5
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x10
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	orr	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x7, x29, #0x60
               	ldur	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x70]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x78]
               	ldur	x1, [x29, #-0x68]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x58]
               	sub	x0, x29, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	ldur	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x70]
               	and	x0, x0, x1
               	stur	x0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x78]
               	ldur	x1, [x29, #-0x68]
               	and	x0, x0, x1
               	stur	x0, [x29, #-0x58]
               	sub	x0, x29, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	ldur	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x70]
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x60]
               	ldur	x0, [x29, #-0x78]
               	ldur	x1, [x29, #-0x68]
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x58]
               	sub	x0, x29, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x80]
               	ldur	x0, [x29, #-0x70]
               	eor	x2, x1, x0
               	ldur	x3, [x29, #-0x78]
               	ldur	x1, [x29, #-0x68]
               	eor	x3, x3, x1
               	sub	x7, x29, #0x60
               	eor	x0, x2, x0
               	stur	x0, [x29, #-0x60]
               	eor	x0, x3, x1
               	stur	x0, [x29, #-0x58]
               	sub	x0, x29, #0x80
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	sub	x7, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x70]
               	eor	x0, x0, x1
               	ldur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x68]
               	eor	x1, x1, x2
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	sub	x0, x29, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	sub	x0, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x70]
               	and	x0, x0, x1
               	ldur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x68]
               	and	x1, x1, x2
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	sub	x0, x29, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	sub	x0, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x70]
               	orr	x0, x0, x1
               	ldur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x68]
               	orr	x1, x1, x2
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	sub	x0, x29, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x78]
               	ldur	x2, [x29, #-0x70]
               	ldur	x3, [x29, #-0x68]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	sub	x7, x29, #0x60
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	sub	x0, x29, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	mov	x0, #0x2fe              // =766
               	movk	x0, #0x4fc, lsl #16
               	movk	x0, #0x6fa, lsl #32
               	movk	x0, #0x8f8, lsl #48
               	stur	x0, [x29, #-0x38]
               	ldurb	w0, [x29, #-0x38]
               	eor	x0, x0, #0xfe
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x37]
               	eor	x0, x0, #0x2
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x31]
               	eor	x0, x0, #0x8
               	cbz	w0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x70
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x50]
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x70]
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x4f]
               	mov	x0, #0xc7               // =199
               	sturb	w0, [x29, #-0x6f]
               	mov	x0, #0xf                // =15
               	sturb	w0, [x29, #-0x4e]
               	mov	x0, #0xc6               // =198
               	sturb	w0, [x29, #-0x6e]
               	mov	x0, #0x16               // =22
               	sturb	w0, [x29, #-0x4d]
               	mov	x0, #0xc5               // =197
               	sturb	w0, [x29, #-0x6d]
               	mov	x0, #0x1d               // =29
               	sturb	w0, [x29, #-0x4c]
               	mov	x0, #0xc4               // =196
               	sturb	w0, [x29, #-0x6c]
               	mov	x0, #0x24               // =36
               	sturb	w0, [x29, #-0x4b]
               	mov	x0, #0xc3               // =195
               	sturb	w0, [x29, #-0x6b]
               	mov	x0, #0x2b               // =43
               	sturb	w0, [x29, #-0x4a]
               	mov	x0, #0xc2               // =194
               	sturb	w0, [x29, #-0x6a]
               	mov	x0, #0x32               // =50
               	sturb	w0, [x29, #-0x49]
               	mov	x0, #0xc1               // =193
               	sturb	w0, [x29, #-0x69]
               	mov	x0, #0x39               // =57
               	sturb	w0, [x29, #-0x48]
               	mov	x0, #0xc0               // =192
               	sturb	w0, [x29, #-0x68]
               	mov	x0, #0x40               // =64
               	sturb	w0, [x29, #-0x47]
               	mov	x0, #0xbf               // =191
               	sturb	w0, [x29, #-0x67]
               	mov	x0, #0x47               // =71
               	sturb	w0, [x29, #-0x46]
               	mov	x0, #0xbe               // =190
               	sturb	w0, [x29, #-0x66]
               	mov	x0, #0x4e               // =78
               	sturb	w0, [x29, #-0x45]
               	mov	x0, #0xbd               // =189
               	sturb	w0, [x29, #-0x65]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0x44]
               	mov	x0, #0xbc               // =188
               	sturb	w0, [x29, #-0x64]
               	mov	x0, #0x5c               // =92
               	sturb	w0, [x29, #-0x43]
               	mov	x0, #0xbb               // =187
               	sturb	w0, [x29, #-0x63]
               	mov	x0, #0x63               // =99
               	sturb	w0, [x29, #-0x42]
               	mov	x0, #0xba               // =186
               	sturb	w0, [x29, #-0x62]
               	mov	x0, #0x6a               // =106
               	sturb	w0, [x29, #-0x41]
               	mov	x0, #0xb9               // =185
               	sturb	w0, [x29, #-0x61]
               	sub	x3, x29, #0x60
               	ldur	x0, [x29, #-0x50]
               	ldur	x4, [x29, #-0x48]
               	ldur	x5, [x29, #-0x70]
               	eor	x0, x0, x5
               	ldur	x5, [x29, #-0x68]
               	eor	x4, x4, x5
               	stur	x0, [x29, #-0x60]
               	stur	x4, [x29, #-0x58]
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
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
