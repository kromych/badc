
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
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	cmp	w0, #0x100
               	b.ge	<addr>
               	sub	x3, x29, #0x400
               	lsl	x4, x0, #2
               	add	x2, x3, x4
               	strh	w1, [x2]
               	strh	w1, [x2, #0x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x100
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
               	mov	x17, #0x1244            // =4676
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x6, #0xc                // =12
               	mov	x7, #0x64               // =100
               	cmp	w0, #0xa
               	b.ge	<addr>
               	sub	x3, x29, #0x78
               	mul	x4, x0, x6
               	add	x2, x3, x4
               	mul	x1, x0, x7
               	str	w1, [x2]
               	add	x5, x1, #0x1
               	str	w5, [x2, #0x4]
               	add	x1, x1, #0x2
               	str	w1, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x54
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	cmp	w0, #0x837
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	lsl	x4, x0, #2
               	add	x2, x3, x4
               	add	x1, x0, #0x41
               	strb	w1, [x2]
               	add	x5, x1, #0x1
               	strb	w5, [x2, #0x1]
               	add	x5, x1, #0x2
               	strb	w5, [x2, #0x2]
               	add	x1, x1, #0x3
               	strb	w1, [x2, #0x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
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
               	cmp	w0, #0x116
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
