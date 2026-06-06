
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xe8
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x100
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x106
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x10d
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrh	w1, [x0]
               	add	x0, x0, #0x2
               	ldrh	w0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	sxtw	x1, w1
               	mov	x17, #0xc               // =12
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldrsw	x1, [x0]
               	add	x2, x0, #0x4
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	add	x2, x0, #0x1
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x0, #0x2
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x0, x0, #0x3
               	ldrb	w0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4c0
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x408
               	str	w0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x408
               	ldrsw	x0, [x16]
               	cmp	x0, #0x100
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x408
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x1, [x16]
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	mov	x1, #0x0                // =0
               	strh	w1, [x0]
               	sub	x0, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x2, [x16]
               	lsl	x2, x2, #2
               	add	x0, x0, x2
               	add	x0, x0, #0x2
               	strh	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x400
               	add	x0, x0, #0x14
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0]
               	sub	x0, x29, #0x400
               	add	x0, x0, #0x16
               	mov	x1, #0x10               // =16
               	strh	w1, [x0]
               	sub	x0, x29, #0x400
               	mov	x1, #0x5                // =5
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrh	w1, [x0]
               	add	x0, x0, #0x2
               	ldrh	w0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	mov	x17, #0x1244            // =4676
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x408
               	str	w0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x408
               	ldrsw	x0, [x16]
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x408
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x488
               	str	w0, [x17]
               	b	<addr>
               	sub	x0, x29, #0x480
               	mov	x1, #0x7                // =7
               	mov	x17, #0xc               // =12
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldrsw	x1, [x0]
               	add	x2, x0, #0x4
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x837
               	b.eq	<addr>
               	b	<addr>
               	sub	x16, x29, #0x488
               	ldrsw	x0, [x16]
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x488
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x480
               	sub	x16, x29, #0x408
               	ldrsw	x1, [x16]
               	mov	x17, #0xc               // =12
               	mul	x2, x1, x17
               	add	x0, x0, x2
               	sub	x16, x29, #0x488
               	ldrsw	x2, [x16]
               	lsl	x3, x2, #2
               	add	x0, x0, x3
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	str	w1, [x0]
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x408
               	str	w0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x408
               	ldrsw	x0, [x16]
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x408
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x488
               	str	w0, [x17]
               	b	<addr>
               	sub	x0, x29, #0x4a8
               	mov	x1, #0x3                // =3
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	add	x2, x0, #0x1
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x0, #0x2
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x0, x0, #0x3
               	ldrb	w0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x116
               	b.eq	<addr>
               	b	<addr>
               	sub	x16, x29, #0x488
               	ldrsw	x0, [x16]
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x488
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x4a8
               	sub	x16, x29, #0x408
               	ldrsw	x1, [x16]
               	lsl	x2, x1, #2
               	add	x0, x0, x2
               	sub	x16, x29, #0x488
               	ldrsw	x2, [x16]
               	add	x0, x0, x2
               	add	x1, x1, #0x41
               	sxtw	x1, w1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x4c0
               	ldp	x29, x30, [sp], #0x10
               	ret
