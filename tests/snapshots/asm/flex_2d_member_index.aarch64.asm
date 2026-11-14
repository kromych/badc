
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
               	mov	x0, #0x100              // =256
               	sturh	w0, [x29, #-0x1c]
               	mov	x0, #0x302              // =770
               	sturh	w0, [x29, #-0x1a]
               	mov	x0, #0x504              // =1284
               	sturh	w0, [x29, #-0x18]
               	mov	x0, #0x1110             // =4368
               	sturh	w0, [x29, #-0x16]
               	mov	x0, #0x1312             // =4882
               	sturh	w0, [x29, #-0x14]
               	mov	x0, #0x1514             // =5396
               	sturh	w0, [x29, #-0x12]
               	mov	x0, #0x2120             // =8480
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x2322             // =8994
               	sturh	w0, [x29, #-0xe]
               	mov	x0, #0x2524             // =9508
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x3130             // =12592
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0x3332             // =13106
               	sturh	w0, [x29, #-0x8]
               	mov	x0, #0x3534             // =13620
               	sturh	w0, [x29, #-0x6]
               	mov	x0, #0xab               // =171
               	sturb	w0, [x29, #-0xf]
               	add	x0, x1, #0x4
               	add	x1, x1, #0x16
               	sub	x1, x1, x0
               	cmp	x1, #0x12
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x18
               	sub	x1, x29, #0x20
               	sub	x0, x0, x1
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x77               // =119
               	sturb	w0, [x29, #-0x18]
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
