
bitfields.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x1, #0x1
               	str	w1, [x0]
               	and	x1, x1, #0xfffffffffffffffd
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	w1, [x0]
               	and	x1, x1, #0xffffffffffffffe3
               	mov	x17, #0x14              // =20
               	orr	x1, x1, x17
               	str	w1, [x0]
               	and	x1, x1, #0xfffffffffffffc1f
               	mov	x17, #0x220             // =544
               	orr	x1, x1, x17
               	str	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	and	x2, x2, #0xffffffff00000000
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	orr	x2, x2, x17
               	str	w2, [x0, #0x4]
               	and	x3, x1, #0x1
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w3, w1
               	asr	x4, x3, #1
               	and	x4, x4, #0x1
               	cbz	x4, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x4, x3, #2
               	and	x4, x4, #0x7
               	cmp	w4, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x3, x3, #5
               	and	x3, x3, #0x1f
               	cmp	w3, #0x11
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	eor	x2, x2, x17
               	cbz	w2, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x1, #0xfffffffffffffffe
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	str	w1, [x0]
               	and	x2, x1, #0x1
               	cbz	x2, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w2, w1
               	asr	x3, x2, #1
               	and	x3, x3, #0x1
               	cbz	x3, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x3, x2, #2
               	and	x3, x3, #0x7
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x2, #5
               	and	x2, x2, #0x1f
               	cmp	w2, #0x11
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x1, #0xffffffffffffffe3
               	orr	x1, x1, #0x1c
               	str	w1, [x0]
               	mov	w0, w1
               	asr	x2, x0, #2
               	and	x2, x2, #0x7
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x0, #5
               	and	x0, x0, #0x1f
               	cmp	w0, #0x11
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0x1
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffffe
               	orr	x0, x0, #0x1
               	stur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffffd
               	orr	x0, x0, #0x2
               	stur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffffb
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffff7
               	orr	x0, x0, #0x8
               	stur	w0, [x29, #-0x8]
               	and	x0, x0, #0xffffffffffffff0f
               	mov	x17, #0xb0              // =176
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	and	x0, x0, #0xffffffffffff00ff
               	mov	x17, #0xc800            // =51200
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	and	x1, x0, #0x1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x2, x1, #1
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #2
               	and	x2, x2, #0x1
               	cbz	x2, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #3
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #4
               	and	x2, x2, #0xf
               	cmp	w2, #0xb
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x1, x1, #8
               	and	x1, x1, #0xff
               	cmp	w1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xffffffffffff00ff
               	mov	x17, #0xc900            // =51456
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	mov	w0, w0
               	asr	x0, x0, #8
               	and	x0, x0, #0xff
               	cmp	w0, #0xc9
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
