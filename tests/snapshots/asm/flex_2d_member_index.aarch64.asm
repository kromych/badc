
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
               	sub	x3, x29, #0x20
               	mov	x0, #0x0                // =0
               	str	x0, [x3]
               	str	x0, [x3, #0x8]
               	str	x0, [x3, #0x10]
               	str	w0, [x3, #0x18]
               	mov	x1, #0x4                // =4
               	str	w1, [x3]
               	mov	x7, #0x6                // =6
               	cmp	w0, #0x4
               	b.ge	<addr>
               	add	x4, x3, #0x4
               	mul	x5, x0, x7
               	add	x2, x4, x5
               	add	x8, x2, #0x0
               	lsl	x1, x0, #4
               	add	x6, x1, #0x0
               	strb	w6, [x8]
               	add	x6, x1, #0x1
               	strb	w6, [x2, #0x1]
               	add	x6, x1, #0x2
               	strb	w6, [x2, #0x2]
               	add	x6, x1, #0x3
               	strb	w6, [x2, #0x3]
               	add	x1, x1, #0x4
               	strb	w1, [x2, #0x4]
               	lsl	x1, x0, #4
               	add	x1, x1, #0x5
               	strb	w1, [x2, #0x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldrb	w0, [x3, #0x15]
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x3, #0x16]
               	eor	x0, x0, #0x30
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x3, #0x10
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
               	add	x1, x3, #0x4
               	add	x0, x3, #0x16
               	sub	x0, x0, x1
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
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
