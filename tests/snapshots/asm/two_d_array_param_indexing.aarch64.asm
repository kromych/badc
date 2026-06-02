
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x110
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x116
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x11d
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	lsl	x14, x14, #2
               	add	x15, x15, x14
               	ldrh	w14, [x15]
               	add	x15, x15, #0x2
               	ldrh	w15, [x15]
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x17, #0xc               // =12
               	mul	x14, x14, x17
               	add	x15, x15, x14
               	ldrsw	x14, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	lsl	x14, x14, #2
               	add	x15, x15, x14
               	ldrb	w14, [x15]
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x13, x15, #0x2
               	ldrb	w13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, #0x3
               	ldrb	w15, [x15]
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4c0
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w15, [x17]
               	b	<addr>
               	sub	x16, x29, #0x408
               	ldrsw	x15, [x16]
               	cmp	x15, #0x100
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x408
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	sub	x15, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x13, [x16]
               	lsl	x13, x13, #2
               	add	x15, x15, x13
               	mov	x13, #0x0               // =0
               	strh	w13, [x15]
               	sub	x14, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x15, [x16]
               	lsl	x15, x15, #2
               	add	x14, x14, x15
               	add	x14, x14, #0x2
               	strh	w13, [x14]
               	b	<addr>
               	sub	x14, x29, #0x400
               	add	x14, x14, #0x14
               	mov	x15, #0x1234            // =4660
               	strh	w15, [x14]
               	sub	x13, x29, #0x400
               	add	x13, x13, #0x16
               	mov	x15, #0x10              // =16
               	strh	w15, [x13]
               	sub	x14, x29, #0x400
               	mov	x15, #0x5               // =5
               	lsl	x15, x15, #2
               	add	x14, x14, x15
               	ldrh	w15, [x14]
               	add	x14, x14, #0x2
               	ldrh	w14, [x14]
               	add	x15, x15, x14
               	sxtw	x15, w15
               	mov	x17, #0x1244            // =4676
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w15, [x17]
               	b	<addr>
               	sub	x16, x29, #0x408
               	ldrsw	x15, [x16]
               	cmp	x15, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x408
               	ldrsw	x15, [x0]
               	add	x15, x15, #0x1
               	str	w15, [x0]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x488
               	str	w15, [x17]
               	b	<addr>
               	sub	x15, x29, #0x480
               	mov	x13, #0x7               // =7
               	mov	x17, #0xc               // =12
               	mul	x13, x13, x17
               	add	x15, x15, x13
               	ldrsw	x13, [x15]
               	add	x0, x15, #0x4
               	ldrsw	x0, [x0]
               	add	x13, x13, x0
               	sxtw	x13, w13
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	add	x13, x13, x15
               	sxtw	x13, w13
               	cmp	x13, #0x837
               	b.eq	<addr>
               	b	<addr>
               	sub	x16, x29, #0x488
               	ldrsw	x15, [x16]
               	cmp	x15, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x488
               	ldrsw	x15, [x13]
               	add	x15, x15, #0x1
               	str	w15, [x13]
               	b	<addr>
               	sub	x15, x29, #0x480
               	sub	x16, x29, #0x408
               	ldrsw	x0, [x16]
               	mov	x17, #0xc               // =12
               	mul	x13, x0, x17
               	add	x15, x15, x13
               	sub	x16, x29, #0x488
               	ldrsw	x13, [x16]
               	lsl	x12, x13, #2
               	add	x15, x15, x12
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, x13
               	sxtw	x0, w0
               	str	w0, [x15]
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w13, [x17]
               	b	<addr>
               	sub	x16, x29, #0x408
               	ldrsw	x13, [x16]
               	cmp	x13, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x408
               	ldrsw	x13, [x0]
               	add	x13, x13, #0x1
               	str	w13, [x0]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	sub	x17, x29, #0x488
               	str	w13, [x17]
               	b	<addr>
               	sub	x13, x29, #0x4a8
               	mov	x15, #0x3               // =3
               	lsl	x15, x15, #2
               	add	x13, x13, x15
               	ldrb	w15, [x13]
               	add	x0, x13, #0x1
               	ldrb	w0, [x0]
               	add	x15, x15, x0
               	sxtw	x15, w15
               	add	x0, x13, #0x2
               	ldrb	w0, [x0]
               	add	x15, x15, x0
               	sxtw	x15, w15
               	add	x13, x13, #0x3
               	ldrb	w13, [x13]
               	add	x15, x15, x13
               	sxtw	x15, w15
               	cmp	x15, #0x116
               	b.eq	<addr>
               	b	<addr>
               	sub	x16, x29, #0x488
               	ldrsw	x13, [x16]
               	cmp	x13, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x488
               	ldrsw	x13, [x15]
               	add	x13, x13, #0x1
               	str	w13, [x15]
               	b	<addr>
               	sub	x13, x29, #0x4a8
               	sub	x16, x29, #0x408
               	ldrsw	x0, [x16]
               	lsl	x15, x0, #2
               	add	x13, x13, x15
               	sub	x16, x29, #0x488
               	ldrsw	x15, [x16]
               	add	x13, x13, x15
               	add	x0, x0, #0x41
               	sxtw	x0, w0
               	add	x0, x0, x15
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x13]
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
