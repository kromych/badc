
three_dim_array_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0x100
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, x0
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
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0x150
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
               	sxtw	x14, w14
               	cmp	x14, #0xa
               	b.eq	<addr>
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0x150
               	add	x14, x14, #0x8
               	ldrb	w15, [x14]
               	add	x13, x14, #0x1
               	ldrb	w13, [x13]
               	add	x15, x15, x13
               	sxtw	x15, w15
               	add	x13, x14, #0x2
               	ldrb	w13, [x13]
               	add	x15, x15, x13
               	sxtw	x15, w15
               	add	x14, x14, #0x3
               	ldrb	w14, [x14]
               	add	x15, x15, x14
               	sxtw	x15, w15
               	cmp	x15, #0x2a
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x15, x15, #0x10
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
               	sxtw	x14, w14
               	cmp	x14, #0x4a
               	b.eq	<addr>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0x150
               	ldrb	w14, [x14]
               	mov	x17, #0x1               // =1
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0x150
               	add	x14, x14, #0xb
               	ldrb	w14, [x14]
               	mov	x17, #0xc               // =12
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x15, #0x5               // =5
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0x150
               	add	x14, x14, #0x17
               	ldrb	w14, [x14]
               	mov	x17, #0x18              // =24
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0x150
               	add	x15, x14, #0xc
               	ldrb	w15, [x15]
               	ldrb	w14, [x14]
               	sub	x15, x15, x14
               	sxtw	x15, w15
               	cmp	x15, #0xc
               	b.eq	<addr>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x14, x15, #0x4
               	ldrb	w14, [x14]
               	ldrb	w15, [x15]
               	sub	x14, x14, x15
               	sxtw	x14, w14
               	cmp	x14, #0x4
               	b.eq	<addr>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x168
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
