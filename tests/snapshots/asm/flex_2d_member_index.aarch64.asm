
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
               	sub	x0, x29, #0x20
               	str	xzr, [x0]
               	str	xzr, [x0, #0x8]
               	str	xzr, [x0, #0x10]
               	str	wzr, [x0, #0x18]
               	mov	x3, #0x4                // =4
               	str	w3, [x0]
               	add	x1, x0, #0x4
               	strb	wzr, [x1]
               	mov	x2, #0x1                // =1
               	strb	w2, [x1, #0x1]
               	mov	x2, #0x2                // =2
               	strb	w2, [x1, #0x2]
               	mov	x2, #0x3                // =3
               	strb	w2, [x1, #0x3]
               	strb	w3, [x1, #0x4]
               	mov	x2, #0x5                // =5
               	strb	w2, [x1, #0x5]
               	add	x2, x1, #0x6
               	mov	x3, #0x10               // =16
               	strb	w3, [x2]
               	mov	x3, #0x11               // =17
               	strb	w3, [x2, #0x1]
               	mov	x3, #0x12               // =18
               	strb	w3, [x2, #0x2]
               	mov	x3, #0x13               // =19
               	strb	w3, [x2, #0x3]
               	mov	x3, #0x14               // =20
               	strb	w3, [x2, #0x4]
               	mov	x3, #0x15               // =21
               	strb	w3, [x2, #0x5]
               	add	x1, x1, #0xc
               	mov	x2, #0x20               // =32
               	strb	w2, [x1]
               	mov	x2, #0x21               // =33
               	strb	w2, [x1, #0x1]
               	add	x2, x0, #0x4
               	add	x1, x2, #0xc
               	mov	x3, #0x22               // =34
               	strb	w3, [x1, #0x2]
               	mov	x3, #0x23               // =35
               	strb	w3, [x1, #0x3]
               	mov	x3, #0x24               // =36
               	strb	w3, [x1, #0x4]
               	mov	x3, #0x25               // =37
               	strb	w3, [x1, #0x5]
               	add	x1, x2, #0x12
               	mov	x3, #0x30               // =48
               	strb	w3, [x1]
               	mov	x3, #0x31               // =49
               	strb	w3, [x1, #0x1]
               	mov	x3, #0x32               // =50
               	strb	w3, [x1, #0x2]
               	mov	x3, #0x33               // =51
               	strb	w3, [x1, #0x3]
               	mov	x3, #0x34               // =52
               	strb	w3, [x1, #0x4]
               	mov	x3, #0x35               // =53
               	strb	w3, [x1, #0x5]
               	add	x1, x0, #0x10
               	mov	x3, #0xab               // =171
               	strb	w3, [x1, #0x1]
               	add	x0, x0, #0x16
               	sub	x0, x0, x2
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x2, #0x18
               	sub	x1, x29, #0x20
               	sub	x0, x0, x1
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x77               // =119
               	strb	w0, [x2, #0x4]
               	strh	wzr, [x1]
               	strh	wzr, [x1, #0x2]
               	strh	wzr, [x1, #0x4]
               	strh	wzr, [x1, #0x6]
               	strh	wzr, [x1, #0x8]
               	strh	wzr, [x1, #0xa]
               	strh	wzr, [x1, #0xc]
               	strh	wzr, [x1, #0xe]
               	strh	wzr, [x1, #0x10]
               	strh	wzr, [x1, #0x12]
               	sub	x2, x29, #0x20
               	mov	x0, #0x0                // =0
               	strh	w0, [x2, #0x14]
               	strh	w0, [x2, #0x16]
               	strh	w0, [x2, #0x18]
               	strh	w0, [x2, #0x1a]
               	mov	x2, #0x4d               // =77
               	strh	w2, [x1, #0x18]
               	add	x2, x1, #0x2
               	add	x1, x1, #0x18
               	sub	x1, x1, x2
               	lsr	x2, x1, #63
               	add	x1, x1, x2
               	asr	x1, x1, #1
               	cmp	x1, #0xb
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
