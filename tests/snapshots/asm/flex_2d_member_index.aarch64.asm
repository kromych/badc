
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
               	sub	sp, sp, #0x20
               	sub	x4, x29, #0x20
               	mov	x1, #0x0                // =0
               	str	x1, [x4]
               	str	x1, [x4, #0x8]
               	str	x1, [x4, #0x10]
               	str	w1, [x4, #0x18]
               	mov	x0, #0x4                // =4
               	str	w0, [x4]
               	mov	x8, #0x6                // =6
               	cmp	w1, #0x4
               	b.ge	<addr>
               	add	x5, x4, #0x4
               	sxtw	x2, w1
               	mul	x6, x2, x8
               	add	x3, x5, x6
               	add	x9, x3, #0x0
               	lsl	x0, x2, #4
               	add	x7, x0, #0x0
               	and	x7, x7, #0xff
               	strb	w7, [x9]
               	add	x7, x0, #0x1
               	and	x7, x7, #0xff
               	strb	w7, [x3, #0x1]
               	add	x7, x0, #0x2
               	and	x7, x7, #0xff
               	strb	w7, [x3, #0x2]
               	add	x7, x0, #0x3
               	and	x7, x7, #0xff
               	strb	w7, [x3, #0x3]
               	add	x0, x0, #0x4
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x4]
               	add	x3, x5, x6
               	lsl	x0, x2, #4
               	add	x0, x0, #0x5
               	and	x0, x0, #0xff
               	strb	w0, [x3, #0x5]
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	ldrb	w0, [x4, #0x15]
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x4, #0x16]
               	eor	x0, x0, #0x30
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x4, #0x10
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x21              // =33
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xab               // =171
               	strb	w1, [x0, #0x1]
               	add	x1, x4, #0x4
               	add	x0, x4, #0x16
               	sub	x0, x0, x1
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
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
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x1, #0x0
               	mov	x2, #0x77               // =119
               	strb	w2, [x1, #0x4]
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
               	add	x1, x0, #0x2
               	add	x0, x0, #0x18
               	sub	x0, x0, x1
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
