
alloca_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400b68 <.text+0x868>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40038c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x126
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400ed8 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
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
               	bl	0x400ee4 <memset>
               	mov	x12, x0
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x10]
               	b	0x4004c0 <.text+0x1c0>
               	ldursw	x12, [x29, #-0x10]
               	cmp	x12, #0x20
               	b.ge	0x400514 <.text+0x214>
               	b	0x4004e4 <.text+0x1e4>
               	sub	x12, x29, #0x10
               	ldrsw	x22, [x12]
               	add	x21, x22, #0x1
               	str	w21, [x12]
               	b	0x4004c0 <.text+0x1c0>
               	ldur	x21, [x29, #-0x8]
               	ldursw	x22, [x29, #-0x10]
               	add	x12, x21, x22
               	ldrb	w22, [x12]
               	mov	x17, #0x55              // =85
               	eor	x12, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x12, x17
               	cmp	x22, #0x0
               	b.eq	0x400564 <.text+0x264>
               	b	0x40053c <.text+0x23c>
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4004d0 <.text+0x1d0>
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
               	lsl	x15, x14, #2
               	sxtw	x15, w15
               	add	x17, x15, #0xf
               	and	x17, x17, #0xfffffffffffffff
               	sub	x16, x29, #0x20
               	ldr	x14, [x16]
               	sub	x14, x14, x17
               	str	x14, [x16]
               	stur	x14, [x29, #-0x8]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x18]
               	stur	w15, [x29, #-0x10]
               	b	0x4005c8 <.text+0x2c8>
               	ldursw	x15, [x29, #-0x10]
               	ldursw	x14, [x29, #0x10]
               	cmp	x15, x14
               	b.ge	0x40061c <.text+0x31c>
               	b	0x4005f0 <.text+0x2f0>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	add	x15, x13, #0x1
               	str	w15, [x14]
               	b	0x4005c8 <.text+0x2c8>
               	ldur	x15, [x29, #-0x8]
               	ldursw	x13, [x29, #-0x10]
               	lsl	x14, x13, #2
               	add	x12, x15, x14
               	mov	x17, #0x7               // =7
               	mul	x14, x13, x17
               	sxtw	x14, w14
               	sub	x13, x14, #0x3
               	sxtw	x13, w13
               	str	w13, [x12]
               	b	0x4005dc <.text+0x2dc>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x10]
               	b	0x400628 <.text+0x328>
               	ldursw	x13, [x29, #-0x10]
               	ldursw	x14, [x29, #0x10]
               	cmp	x13, x14
               	b.ge	0x400678 <.text+0x378>
               	b	0x400650 <.text+0x350>
               	sub	x14, x29, #0x10
               	ldrsw	x12, [x14]
               	add	x13, x12, #0x1
               	str	w13, [x14]
               	b	0x400628 <.text+0x328>
               	sub	x13, x29, #0x18
               	ldrsw	x12, [x13]
               	ldur	x14, [x29, #-0x8]
               	ldursw	x15, [x29, #-0x10]
               	lsl	x11, x15, #2
               	add	x15, x14, x11
               	ldrsw	x11, [x15]
               	add	x15, x12, x11
               	str	w15, [x13]
               	b	0x40063c <.text+0x33c>
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
               	b.ne	0x400740 <.text+0x440>
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
               	bl	0x400ee4 <memset>
               	mov	x12, x0
               	ldur	x23, [x29, #-0x10]
               	mov	x24, #0x42              // =66
               	mov	x0, x23
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x400ee4 <memset>
               	mov	x20, x0
               	ldur	x20, [x29, #-0x8]
               	ldrb	w24, [x20]
               	mov	x17, #0x41              // =65
               	eor	x20, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x20, x17
               	cmp	x24, #0x0
               	cset	x20, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x38
               	str	x20, [x17]
               	cbnz	x20, 0x4007e8 <.text+0x4e8>
               	ldur	x24, [x29, #-0x8]
               	add	x20, x24, #0xf
               	ldrb	w24, [x20]
               	mov	x17, #0x41              // =65
               	eor	x20, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x20, x17
               	cmp	x24, #0x0
               	cset	x20, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x38
               	str	x20, [x17]
               	b	0x4007e8 <.text+0x4e8>
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x38
               	ldr	x20, [x16]
               	cbz	x20, 0x400828 <.text+0x528>
               	mov	x24, #0x2               // =2
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
               	ldur	x20, [x29, #-0x10]
               	ldrb	w24, [x20]
               	mov	x17, #0x42              // =66
               	eor	x20, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x20, x17
               	cmp	x24, #0x0
               	cset	x20, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x40
               	str	x20, [x17]
               	cbnz	x20, 0x400894 <.text+0x594>
               	ldur	x24, [x29, #-0x10]
               	add	x20, x24, #0xf
               	ldrb	w24, [x20]
               	mov	x17, #0x42              // =66
               	eor	x20, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x20, x17
               	cmp	x24, #0x0
               	cset	x20, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x40
               	str	x20, [x17]
               	b	0x400894 <.text+0x594>
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x40
               	ldr	x20, [x16]
               	cbz	x20, 0x4008d4 <.text+0x5d4>
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
               	mov	x20, #0x0               // =0
               	mov	x0, x20
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
               	b	0x40093c <.text+0x63c>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x15, [x29, #0x10]
               	cmp	x14, x15
               	b.ge	0x4009b0 <.text+0x6b0>
               	b	0x400964 <.text+0x664>
               	sub	x15, x29, #0x10
               	ldrsw	x13, [x15]
               	add	x14, x13, #0x1
               	str	w14, [x15]
               	b	0x40093c <.text+0x63c>
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
               	add	x14, x13, x12
               	str	w14, [x15]
               	b	0x400950 <.text+0x650>
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
               	bl	0x400ee4 <memset>
               	mov	x12, x0
               	mov	x23, #0x14              // =20
               	mov	x0, x23
               	bl	0x400904 <.text+0x604>
               	mov	x22, x0
               	stur	w22, [x29, #-0x10]
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0x18]
               	b	0x400a60 <.text+0x760>
               	ldursw	x23, [x29, #-0x18]
               	cmp	x23, #0x40
               	b.ge	0x400aac <.text+0x7ac>
               	b	0x400a84 <.text+0x784>
               	sub	x23, x29, #0x18
               	ldrsw	x22, [x23]
               	add	x21, x22, #0x1
               	str	w21, [x23]
               	b	0x400a60 <.text+0x760>
               	ldur	x21, [x29, #-0x8]
               	ldursw	x22, [x29, #-0x18]
               	add	x23, x21, x22
               	ldrb	w22, [x23]
               	ldursw	x23, [x29, #0x10]
               	mov	x17, #0xff              // =255
               	and	x21, x23, x17
               	cmp	x22, x21
               	b.eq	0x400af8 <.text+0x7f8>
               	b	0x400abc <.text+0x7bc>
               	ldursw	x23, [x29, #-0x10]
               	cmp	x23, #0xbe
               	b.eq	0x400b38 <.text+0x838>
               	b	0x400afc <.text+0x7fc>
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
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
               	b	0x400a70 <.text+0x770>
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
               	bl	0x400450 <.text+0x150>
               	mov	x15, x0
               	cmp	x15, #0x0
               	b.eq	0x400bdc <.text+0x8dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400ef0 <printf>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x1               // =1
               	mov	x0, x14
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
               	bl	0x400568 <.text+0x268>
               	mov	x14, x0
               	cmp	x14, #0x11d
               	b.eq	0x400c4c <.text+0x94c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x165
               	mov	x20, x19
               	mov	x22, #0xa               // =10
               	mov	x0, x22
               	bl	0x400568 <.text+0x268>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400ef0 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400694 <.text+0x394>
               	mov	x21, x0
               	cmp	x21, #0x0
               	b.eq	0x400ca0 <.text+0x9a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x177
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x400ef0 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x3               // =3
               	mov	x0, x23
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
               	bl	0x400904 <.text+0x604>
               	mov	x23, x0
               	cmp	x23, #0x4c9
               	b.eq	0x400d10 <.text+0xa10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x186
               	mov	x22, x19
               	mov	x23, #0x32              // =50
               	mov	x0, x23
               	bl	0x400904 <.text+0x604>
               	mov	x21, x0
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400ef0 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x4               // =4
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x33              // =51
               	mov	x0, x20
               	bl	0x4009cc <.text+0x6cc>
               	mov	x23, x0
               	cmp	x23, #0x0
               	b.eq	0x400d6c <.text+0xa6c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x197
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400ef0 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
