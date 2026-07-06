
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrh	w1, [x0]
               	ldrh	w0, [x0, #0x2]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<sum_int_row>:
               	sxtw	x1, w1
               	mov	x17, #0xc               // =12
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<sum_char_row>:
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x2]
               	add	x1, x1, x2
               	ldrb	w0, [x0, #0x3]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4c0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x400
               	lsl	x3, x0, #2
               	add	x2, x2, x3
               	mov	x3, #0x0                // =0
               	strh	w3, [x2]
               	sub	x2, x29, #0x400
               	lsl	x4, x0, #2
               	add	x2, x2, x4
               	strh	w3, [x2, #0x2]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x100
               	b.lt	<addr>
               	sub	x0, x29, #0x400
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0, #0x14]
               	sub	x0, x29, #0x400
               	mov	x1, #0x10               // =16
               	strh	w1, [x0, #0x16]
               	sub	x0, x29, #0x400
               	add	x0, x0, #0x14
               	ldrh	w1, [x0]
               	ldrh	w0, [x0, #0x2]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	mov	x17, #0x1244            // =4676
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x480
               	mov	x17, #0xc               // =12
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	add	x2, x2, #0x0
               	mov	x17, #0x64              // =100
               	mul	x3, x0, x17
               	add	x3, x3, #0x0
               	str	w3, [x2]
               	sub	x2, x29, #0x480
               	mov	x17, #0xc               // =12
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	mov	x17, #0x64              // =100
               	mul	x3, x0, x17
               	add	x3, x3, #0x1
               	str	w3, [x2, #0x4]
               	sub	x2, x29, #0x480
               	mov	x17, #0xc               // =12
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	mov	x17, #0x64              // =100
               	mul	x3, x0, x17
               	add	x3, x3, #0x2
               	str	w3, [x2, #0x8]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0xa
               	b.lt	<addr>
               	sub	x0, x29, #0x480
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
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x4a8
               	lsl	x3, x0, #2
               	add	x2, x2, x3
               	add	x2, x2, #0x0
               	add	x3, x0, #0x41
               	add	x3, x3, #0x0
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x2]
               	sub	x2, x29, #0x4a8
               	lsl	x3, x0, #2
               	add	x2, x2, x3
               	add	x3, x0, #0x41
               	add	x3, x3, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x4a8
               	lsl	x3, x0, #2
               	add	x2, x2, x3
               	add	x3, x0, #0x41
               	add	x3, x3, #0x2
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x4a8
               	lsl	x3, x0, #2
               	add	x2, x2, x3
               	add	x3, x0, #0x41
               	add	x3, x3, #0x3
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x2, #0x3]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x4a8
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
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
