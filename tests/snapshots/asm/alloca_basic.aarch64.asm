
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x108
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
               	add	x11, x11, #0x120
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x126
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x12d
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x16, x29, #0x28
               	str	x16, [x16]
               	mov	x2, #0x20               // =32
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x28
               	ldr	x14, [x16]
               	sub	x14, x14, x17
               	str	x14, [x16]
               	stur	x14, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x55               // =85
               	bl	<addr>
               	mov	x12, x0
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x10]
               	b	<addr>
               	ldursw	x12, [x29, #-0x10]
               	cmp	x12, #0x20
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x10
               	ldrsw	x12, [x1]
               	add	x12, x12, #0x1
               	str	w12, [x1]
               	b	<addr>
               	ldur	x12, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x12, x12, x0
               	ldrb	w12, [x12]
               	mov	x17, #0x55              // =85
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	b	<addr>
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
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
               	ldrsw	x15, [x15]
               	add	x14, x14, x15
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
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
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x41               // =65
               	mov	x20, #0x10              // =16
               	mov	x2, x20
               	bl	<addr>
               	mov	x12, x0
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x42               // =66
               	mov	x2, x20
               	bl	<addr>
               	mov	x12, x0
               	ldur	x12, [x29, #-0x8]
               	ldrb	w12, [x12]
               	mov	x17, #0x41              // =65
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	cset	x12, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x38
               	str	x12, [x17]
               	cbnz	x12, <addr>
               	ldur	x1, [x29, #-0x8]
               	add	x1, x1, #0xf
               	ldrb	w1, [x1]
               	mov	x17, #0x41              // =65
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x38
               	str	x1, [x17]
               	b	<addr>
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x38
               	ldr	x1, [x16]
               	cbz	x1, <addr>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x10]
               	ldrb	w1, [x1]
               	mov	x17, #0x42              // =66
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x40
               	str	x1, [x17]
               	cbnz	x1, <addr>
               	ldur	x12, [x29, #-0x10]
               	add	x12, x12, #0xf
               	ldrb	w12, [x12]
               	mov	x17, #0x42              // =66
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	cset	x12, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x40
               	str	x12, [x17]
               	b	<addr>
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x40
               	ldr	x12, [x16]
               	cbz	x12, <addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
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
               	ldr	x14, [x14]
               	sxtw	x14, w14
               	add	x13, x13, x14
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
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x16, x29, #0x28
               	str	x16, [x16]
               	sxtw	x15, w0
               	stur	w15, [x29, #0x10]
               	mov	x2, #0x40               // =64
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x28
               	ldr	x15, [x16]
               	sub	x15, x15, x17
               	str	x15, [x16]
               	stur	x15, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #0x10]
               	bl	<addr>
               	mov	x12, x0
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x1, x0
               	stur	w1, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x18
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	ldursw	x12, [x29, #-0x18]
               	add	x0, x0, x12
               	ldrb	w0, [x0]
               	ldursw	x12, [x29, #0x10]
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	cmp	x0, x12
               	b.eq	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0xbe
               	b.eq	<addr>
               	b	<addr>
               	mov	x12, #0xffff            // =65535
               	movk	x12, #0xffff, lsl #16
               	movk	x12, #0xffff, lsl #32
               	movk	x12, #0xffff, lsl #48
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	b	<addr>
               	mov	x12, #0xfffe            // =65534
               	movk	x12, #0xffff, lsl #16
               	movk	x12, #0xffff, lsl #32
               	movk	x12, #0xffff, lsl #48
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x14, <page>
               	add	x14, x14, #0x158
               	mov	x0, x14
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0xa               // =10
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x11d
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x165
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x177
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, #0x4c9
               	b.eq	<addr>
               	adrp	x21, <page>
               	add	x21, x21, #0x186
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x33               // =51
               	mov	x0, x1
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x197
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
