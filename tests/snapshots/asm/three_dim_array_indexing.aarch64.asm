
three_dim_array_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
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
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x0, <page>
               	add	x0, x0, #0x11c
               	ldrb	w1, [x0]
               	add	x2, x0, #0x1
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x0, #0x2
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x0, #0x3
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x8
               	ldrb	w2, [x1]
               	add	x3, x1, #0x1
               	ldrb	w3, [x3]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	add	x3, x1, #0x2
               	ldrb	w3, [x3]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	add	x1, x1, #0x3
               	ldrb	w1, [x1]
               	add	x1, x2, x1
               	sxtw	x1, w1
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x10
               	ldrb	w2, [x1]
               	add	x3, x1, #0x1
               	ldrb	w3, [x3]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	add	x3, x1, #0x2
               	ldrb	w3, [x3]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	add	x1, x1, #0x3
               	ldrb	w1, [x1]
               	add	x1, x2, x1
               	sxtw	x1, w1
               	cmp	x1, #0x4a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0xb
               	ldrb	w1, [x1]
               	mov	x17, #0xc               // =12
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x17
               	ldrb	w1, [x1]
               	mov	x17, #0x18              // =24
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0xc
               	ldrb	w1, [x1]
               	ldrb	w2, [x0]
               	sub	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x4
               	ldrb	w1, [x1]
               	ldrb	w0, [x0]
               	sub	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x134
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
