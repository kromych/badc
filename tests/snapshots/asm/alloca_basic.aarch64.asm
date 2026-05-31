
alloca_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x126
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x12d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x16, x29, #0x28
               	str	x16, [x16]
               	mov	x20, #0x20              // =32
               	add	x17, x20, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x28
               	ldr	x14, [x16]
               	sub	x14, x14, x17
               	str	x14, [x16]
               	stur	x14, [x29, #-0x8]
               	ldur	x21, [x29, #-0x8]
               	mov	x22, #0x55              // =85
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x20
               	b.ge	<addr>
               	b	<addr>
               	sub	x22, x29, #0x10
               	ldrsw	x0, [x22]
               	add	x0, x0, #0x1
               	str	w0, [x22]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldursw	x21, [x29, #-0x10]
               	add	x0, x0, x21
               	ldrb	w21, [x0]
               	mov	x17, #0x55              // =85
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.eq	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x16, x29, #0x20
               	str	x16, [x16]
               	sxtw	x15, w0
               	stur	w15, [x29, #0x10]
               	ldursw	x14, [x29, #0x10]
               	lsl	x14, x14, #2
               	sxtw	x14, w14
               	add	x17, x14, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x20
               	ldr	x15, [x16]
               	sub	x15, x15, x17
               	str	x15, [x16]
               	stur	x15, [x29, #-0x8]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x18]
               	stur	w14, [x29, #-0x10]
               	b	<addr>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x15, [x29, #0x10]
               	cmp	x14, x15
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	<addr>
               	ldur	x14, [x29, #-0x8]
               	ldursw	x13, [x29, #-0x10]
               	lsl	x15, x13, #2
               	add	x14, x14, x15
               	mov	x17, #0x7               // =7
               	mul	x13, x13, x17
               	sxtw	x13, w13
               	sub	x13, x13, #0x3
               	sxtw	x13, w13
               	str	w13, [x14]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	ldursw	x15, [x29, #0x10]
               	cmp	x13, x15
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x10
               	ldrsw	x13, [x15]
               	add	x13, x13, #0x1
               	str	w13, [x15]
               	b	<addr>
               	sub	x13, x29, #0x18
               	ldrsw	x14, [x13]
               	ldur	x15, [x29, #-0x8]
               	ldursw	x12, [x29, #-0x10]
               	lsl	x12, x12, #2
               	add	x15, x15, x12
               	ldrsw	x12, [x15]
               	add	x14, x14, x12
               	str	w14, [x13]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	sub	x16, x29, #0x30
               	str	x16, [x16]
               	mov	x15, #0x10              // =16
               	add	x17, x15, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x30
               	ldr	x14, [x16]
               	sub	x14, x14, x17
               	str	x14, [x16]
               	stur	x14, [x29, #-0x8]
               	add	x17, x15, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x30
               	ldr	x13, [x16]
               	sub	x13, x13, x17
               	str	x13, [x16]
               	stur	x13, [x29, #-0x10]
               	ldur	x15, [x29, #-0x8]
               	ldur	x13, [x29, #-0x10]
               	cmp	x15, x13
               	b.ne	<addr>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x20, [x29, #-0x8]
               	mov	x21, #0x41              // =65
               	mov	x22, #0x10              // =16
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	ldur	x23, [x29, #-0x10]
               	mov	x24, #0x42              // =66
               	mov	x0, x23
               	mov	x2, x22
               	mov	x1, x24
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldrb	w24, [x0]
               	mov	x17, #0x41              // =65
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x38
               	str	x24, [x17]
               	cbnz	x24, <addr>
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0xf
               	ldrb	w24, [x0]
               	mov	x17, #0x41              // =65
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x38
               	str	x24, [x17]
               	b	<addr>
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x38
               	ldr	x24, [x16]
               	cbz	x24, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x24, [x29, #-0x10]
               	ldrb	w0, [x24]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x40
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	ldur	x24, [x29, #-0x10]
               	add	x24, x24, #0xf
               	ldrb	w0, [x24]
               	mov	x17, #0x42              // =66
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x40
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x40
               	ldr	x0, [x16]
               	cbz	x0, <addr>
               	mov	x24, #0x3               // =3
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x16, x29, #0x20
               	str	x16, [x16]
               	sxtw	x15, w0
               	stur	w15, [x29, #0x10]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	stur	w14, [x29, #-0x10]
               	b	<addr>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x15, [x29, #0x10]
               	cmp	x14, x15
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	<addr>
               	mov	x14, #0x8               // =8
               	add	x17, x14, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x20
               	ldr	x13, [x16]
               	sub	x13, x13, x17
               	str	x13, [x16]
               	stur	x13, [x29, #-0x18]
               	ldur	x14, [x29, #-0x18]
               	ldursw	x13, [x29, #-0x10]
               	str	x13, [x14]
               	sub	x15, x29, #0x8
               	ldrsw	x13, [x15]
               	ldur	x14, [x29, #-0x18]
               	ldr	x12, [x14]
               	sxtw	x12, w12
               	add	x13, x13, x12
               	str	w13, [x15]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	sub	x16, x29, #0x28
               	str	x16, [x16]
               	sxtw	x15, w0
               	stur	w15, [x29, #0x10]
               	mov	x20, #0x40              // =64
               	add	x17, x20, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x28
               	ldr	x15, [x16]
               	sub	x15, x15, x17
               	str	x15, [x16]
               	stur	x15, [x29, #-0x8]
               	ldur	x21, [x29, #-0x8]
               	ldursw	x22, [x29, #0x10]
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x23, #0x14              // =20
               	mov	x0, x23
               	bl	<addr>
               	stur	w0, [x29, #-0x10]
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0x18]
               	b	<addr>
               	ldursw	x23, [x29, #-0x18]
               	cmp	x23, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x23, [x0]
               	add	x23, x23, #0x1
               	str	w23, [x0]
               	b	<addr>
               	ldur	x23, [x29, #-0x8]
               	ldursw	x21, [x29, #-0x18]
               	add	x23, x23, x21
               	ldrb	w21, [x23]
               	ldursw	x23, [x29, #0x10]
               	mov	x17, #0xff              // =255
               	and	x23, x23, x17
               	cmp	x21, x23
               	b.eq	<addr>
               	b	<addr>
               	ldursw	x21, [x29, #-0x10]
               	cmp	x21, #0xbe
               	b.eq	<addr>
               	b	<addr>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	b	<addr>
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xa               // =10
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x11d
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x165
               	mov	x20, x19
               	mov	x21, #0xa               // =10
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x177
               	mov	x22, x19
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x32              // =50
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x4c9
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x186
               	mov	x22, x19
               	mov	x21, #0x32              // =50
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x33              // =51
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x197
               	mov	x23, x19
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
