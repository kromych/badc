
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
               	sub	x1, x29, #0x20
               	mov	x2, #0x4                // =4
               	stur	xzr, [x29, #-0x18]
               	stur	xzr, [x29, #-0x10]
               	stur	wzr, [x29, #-0x8]
               	stur	x2, [x29, #-0x20]
               	add	x0, x1, #0x4
               	mov	x2, #0x100              // =256
               	strh	w2, [x0]
               	mov	x2, #0x302              // =770
               	strh	w2, [x0, #0x2]
               	mov	x2, #0x504              // =1284
               	strh	w2, [x0, #0x4]
               	add	x2, x0, #0x6
               	mov	x3, #0x1110             // =4368
               	strh	w3, [x2]
               	mov	x3, #0x1312             // =4882
               	strh	w3, [x2, #0x2]
               	mov	x3, #0x1514             // =5396
               	strh	w3, [x2, #0x4]
               	add	x0, x0, #0xc
               	mov	x2, #0x2120             // =8480
               	strh	w2, [x0]
               	add	x0, x1, #0x4
               	add	x2, x0, #0xc
               	mov	x3, #0x2322             // =8994
               	strh	w3, [x2, #0x2]
               	mov	x3, #0x2524             // =9508
               	strh	w3, [x2, #0x4]
               	add	x2, x0, #0x12
               	mov	x3, #0x3130             // =12592
               	strh	w3, [x2]
               	mov	x3, #0x3332             // =13106
               	strh	w3, [x2, #0x2]
               	mov	x3, #0x3534             // =13620
               	strh	w3, [x2, #0x4]
               	add	x2, x1, #0x10
               	mov	x3, #0xab               // =171
               	strb	w3, [x2, #0x1]
               	add	x1, x1, #0x16
               	sub	x1, x1, x0
               	cmp	x1, #0x12
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x0, #0x18
               	sub	x1, x29, #0x20
               	sub	x2, x2, x1
               	cmp	x2, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x77               // =119
               	strb	w2, [x0, #0x4]
               	stur	wzr, [x29, #-0x20]
               	stur	wzr, [x29, #-0x1c]
               	stur	wzr, [x29, #-0x18]
               	stur	wzr, [x29, #-0x14]
               	stur	wzr, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	stur	wzr, [x29, #-0xc]
               	sturh	w0, [x29, #-0x8]
               	mov	x2, #0x4d               // =77
               	stur	w2, [x29, #-0x8]
               	add	x2, x1, #0x2
               	add	x1, x1, #0x18
               	sub	x1, x1, x2
               	add	x1, x1, x1, lsr #63
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
