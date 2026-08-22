
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
               	sub	sp, sp, #0x50
               	sub	x2, x29, #0x48
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x48
               	add	x3, x3, x1
               	mov	x4, #0x0                // =0
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x1c
               	b.lt	<addr>
               	mov	x0, #0x4                // =4
               	str	w0, [x2]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	add	x3, x2, #0x4
               	mov	x17, #0x6               // =6
               	mul	x4, x0, x17
               	add	x3, x3, x4
               	add	x4, x3, #0x0
               	lsl	x3, x0, #4
               	add	x3, x3, #0x0
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x4]
               	add	x3, x2, #0x4
               	mov	x17, #0x6               // =6
               	mul	x4, x0, x17
               	add	x4, x3, x4
               	lsl	x3, x0, #4
               	add	x3, x3, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x4, #0x1]
               	add	x3, x2, #0x4
               	mov	x17, #0x6               // =6
               	mul	x4, x0, x17
               	add	x4, x3, x4
               	lsl	x3, x0, #4
               	add	x3, x3, #0x2
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x4, #0x2]
               	add	x3, x2, #0x4
               	mov	x17, #0x6               // =6
               	mul	x4, x0, x17
               	add	x4, x3, x4
               	lsl	x3, x0, #4
               	add	x3, x3, #0x3
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x4, #0x3]
               	add	x3, x2, #0x4
               	mov	x17, #0x6               // =6
               	mul	x4, x0, x17
               	add	x4, x3, x4
               	lsl	x3, x0, #4
               	add	x3, x3, #0x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x4, #0x4]
               	add	x3, x2, #0x4
               	mov	x17, #0x6               // =6
               	mul	x4, x0, x17
               	add	x4, x3, x4
               	lsl	x3, x0, #4
               	add	x3, x3, #0x5
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x4, #0x5]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.lt	<addr>
               	ldrb	w0, [x2, #0x15]
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x2, #0x16]
               	mov	x17, #0x30              // =48
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x2, #0x10
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x21              // =33
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xab               // =171
               	strb	w1, [x0, #0x1]
               	ldrb	w0, [x2, #0x11]
               	mov	x17, #0xab              // =171
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x2, #0x4
               	add	x1, x2, #0x16
               	sub	x0, x1, x0
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x2, #0x4
               	ldrsw	x1, [x2]
               	mov	x17, #0x6               // =6
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	sub	x1, x29, #0x48
               	sub	x0, x0, x1
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x2, #0x4
               	add	x0, x0, #0x0
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0x4]
               	ldrb	w0, [x2, #0x8]
               	mov	x17, #0x77              // =119
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x28
               	add	x1, x1, #0x0
               	mov	x2, #0x0                // =0
               	strh	w2, [x1]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x2]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x4]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x6]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x8]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0xa]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0xc]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0xe]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x10]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x12]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x14]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x16]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x18]
               	sub	x1, x29, #0x28
               	mov	x2, #0x0                // =0
               	strh	w2, [x1, #0x1a]
               	mov	x1, #0x4d               // =77
               	strh	w1, [x0, #0x18]
               	sxth	x1, w1
               	cmp	x1, #0x4d
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x50
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
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
