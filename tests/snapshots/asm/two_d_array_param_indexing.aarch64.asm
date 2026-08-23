
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x400
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	sub	x4, x29, #0x400
               	lsl	x5, x1, #2
               	add	x3, x4, x5
               	strh	w2, [x3]
               	strh	w2, [x3, #0x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x100
               	b.lt	<addr>
               	sub	x0, x29, #0x400
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0, #0x14]
               	mov	x1, #0x10               // =16
               	strh	w1, [x0, #0x16]
               	add	x0, x0, #0x14
               	ldrh	w1, [x0]
               	ldrh	w0, [x0, #0x2]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	mov	x17, #0x1244            // =4676
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x7, #0xc                // =12
               	mov	x8, #0x64               // =100
               	b	<addr>
               	sub	x4, x29, #0x78
               	mul	x5, x1, x7
               	add	x3, x4, x5
               	add	x9, x3, #0x0
               	mul	x0, x1, x8
               	add	x6, x0, #0x0
               	str	w6, [x9]
               	add	x6, x0, #0x1
               	str	w6, [x3, #0x4]
               	add	x0, x0, #0x2
               	str	w0, [x3, #0x8]
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0xa
               	b.lt	<addr>
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x54
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x837
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0x20
               	lsl	x6, x1, #2
               	add	x3, x5, x6
               	add	x8, x3, #0x0
               	add	x0, x1, #0x41
               	add	x7, x0, #0x0
               	and	x7, x7, x4
               	strb	w7, [x8]
               	add	x7, x0, #0x1
               	and	x7, x7, x4
               	strb	w7, [x3, #0x1]
               	add	x7, x0, #0x2
               	and	x7, x7, x4
               	strb	w7, [x3, #0x2]
               	add	x0, x0, #0x3
               	and	x0, x0, x4
               	strb	w0, [x3, #0x3]
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0xc
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x2]
               	add	x1, x1, x2
               	ldrb	w0, [x0, #0x3]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x116
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
