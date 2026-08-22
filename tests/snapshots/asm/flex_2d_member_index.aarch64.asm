
flex_2d_member_index.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x20
               	mov	x2, #0x0                // =0
               	str	x2, [x4]
               	str	x2, [x4, #0x8]
               	str	x2, [x4, #0x10]
               	str	w2, [x4, #0x18]
               	mov	x0, #0x4                // =4
               	str	w0, [x4]
               	mov	x9, #0x6                // =6
               	mov	x5, #0xff               // =255
               	b	<addr>
               	add	x6, x4, #0x4
               	sxtw	x1, w2
               	mul	x7, x1, x9
               	add	x3, x6, x7
               	add	x10, x3, #0x0
               	lsl	x0, x1, #4
               	add	x8, x0, #0x0
               	and	x8, x8, x5
               	strb	w8, [x10]
               	add	x8, x0, #0x1
               	and	x8, x8, x5
               	strb	w8, [x3, #0x1]
               	add	x8, x0, #0x2
               	and	x8, x8, x5
               	strb	w8, [x3, #0x2]
               	add	x8, x0, #0x3
               	and	x8, x8, x5
               	strb	w8, [x3, #0x3]
               	add	x0, x0, #0x4
               	and	x0, x0, x5
               	strb	w0, [x3, #0x4]
               	add	x3, x6, x7
               	lsl	x0, x1, #4
               	add	x0, x0, #0x5
               	and	x0, x0, x5
               	strb	w0, [x3, #0x5]
               	add	x2, x1, #0x1
               	cmp	x2, #0x4
               	b.lt	<addr>
               	ldrb	w0, [x4, #0x15]
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x4, #0x16]
               	mov	x17, #0x30              // =48
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x4, #0x10
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x21              // =33
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xab               // =171
               	strb	w1, [x0, #0x1]
               	ldrb	w0, [x4, #0x11]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x4, #0x4
               	add	x0, x4, #0x16
               	sub	x0, x0, x1
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x4]
               	mov	x17, #0x6               // =6
               	mul	x0, x0, x17
               	add	x2, x1, x0
               	sub	x0, x29, #0x20
               	sub	x2, x2, x0
               	cmp	x2, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x1, #0x0
               	mov	x2, #0x77               // =119
               	strb	w2, [x1, #0x4]
               	ldrb	w1, [x4, #0x8]
               	mov	x17, #0x77              // =119
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x0, #0x0
               	mov	x1, #0x0                // =0
               	strh	w1, [x2]
               	strh	w1, [x0, #0x2]
               	strh	w1, [x0, #0x4]
               	strh	w1, [x0, #0x6]
               	strh	w1, [x0, #0x8]
               	strh	w1, [x0, #0xa]
               	strh	w1, [x0, #0xc]
               	strh	w1, [x0, #0xe]
               	strh	w1, [x0, #0x10]
               	strh	w1, [x0, #0x12]
               	sub	x1, x29, #0x20
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x14]
               	strh	w2, [x1, #0x16]
               	strh	w2, [x1, #0x18]
               	strh	w2, [x1, #0x1a]
               	mov	x1, #0x4d               // =77
               	strh	w1, [x0, #0x18]
               	sxth	x1, w1
               	cmp	x1, #0x4d
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x2
               	add	x0, x0, #0x18
               	sub	x0, x0, x1
               	asr	x1, x0, #63
               	lsr	x1, x1, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
