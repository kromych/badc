
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
               	sub	x2, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	stur	xzr, [x29, #-0x10]
               	stur	wzr, [x29, #-0x8]
               	mov	x3, #0x4                // =4
               	stur	w3, [x29, #-0x20]
               	add	x0, x2, #0x4
               	strb	wzr, [x0]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x2]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x3]
               	strb	w3, [x0, #0x4]
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x5]
               	add	x1, x0, #0x6
               	mov	x3, #0x10               // =16
               	strb	w3, [x1]
               	mov	x3, #0x11               // =17
               	strb	w3, [x1, #0x1]
               	mov	x3, #0x12               // =18
               	strb	w3, [x1, #0x2]
               	mov	x3, #0x13               // =19
               	strb	w3, [x1, #0x3]
               	mov	x3, #0x14               // =20
               	strb	w3, [x1, #0x4]
               	mov	x3, #0x15               // =21
               	strb	w3, [x1, #0x5]
               	add	x0, x0, #0xc
               	mov	x1, #0x20               // =32
               	strb	w1, [x0]
               	mov	x1, #0x21               // =33
               	strb	w1, [x0, #0x1]
               	add	x1, x2, #0x4
               	add	x0, x1, #0xc
               	mov	x3, #0x22               // =34
               	strb	w3, [x0, #0x2]
               	mov	x3, #0x23               // =35
               	strb	w3, [x0, #0x3]
               	mov	x3, #0x24               // =36
               	strb	w3, [x0, #0x4]
               	mov	x3, #0x25               // =37
               	strb	w3, [x0, #0x5]
               	add	x0, x1, #0x12
               	mov	x3, #0x30               // =48
               	strb	w3, [x0]
               	mov	x3, #0x31               // =49
               	strb	w3, [x0, #0x1]
               	mov	x3, #0x32               // =50
               	strb	w3, [x0, #0x2]
               	mov	x3, #0x33               // =51
               	strb	w3, [x0, #0x3]
               	mov	x3, #0x34               // =52
               	strb	w3, [x0, #0x4]
               	mov	x3, #0x35               // =53
               	strb	w3, [x0, #0x5]
               	add	x0, x2, #0x10
               	mov	x3, #0xab               // =171
               	strb	w3, [x0, #0x1]
               	add	x0, x2, #0x16
               	sub	x0, x0, x1
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x1, #0x18
               	sub	x2, x29, #0x20
               	sub	x0, x0, x2
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x77               // =119
               	strb	w0, [x1, #0x4]
               	sturh	wzr, [x29, #-0x20]
               	sturh	wzr, [x29, #-0x1e]
               	sturh	wzr, [x29, #-0x1c]
               	sturh	wzr, [x29, #-0x1a]
               	sturh	wzr, [x29, #-0x18]
               	sturh	wzr, [x29, #-0x16]
               	sturh	wzr, [x29, #-0x14]
               	sturh	wzr, [x29, #-0x12]
               	sturh	wzr, [x29, #-0x10]
               	sturh	wzr, [x29, #-0xe]
               	mov	x0, #0x0                // =0
               	sturh	w0, [x29, #-0xc]
               	sturh	w0, [x29, #-0xa]
               	sturh	w0, [x29, #-0x8]
               	sturh	w0, [x29, #-0x6]
               	mov	x1, #0x4d               // =77
               	sturh	w1, [x29, #-0x8]
               	add	x1, x2, #0x2
               	add	x2, x2, #0x18
               	sub	x1, x2, x1
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
