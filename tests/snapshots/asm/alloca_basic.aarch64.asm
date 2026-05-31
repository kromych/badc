
alloca_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400b44 <.text+0x844>
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
               	bl	0x400e78 <dlsym>
               	cbz	x0, 0x400414 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400414 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
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
               	bl	0x400e84 <memset>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	b	0x4004b4 <.text+0x1b4>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x20
               	b.ge	0x400508 <.text+0x208>
               	b	0x4004d8 <.text+0x1d8>
               	sub	x0, x29, #0x10
               	ldrsw	x22, [x0]
               	add	x21, x22, #0x1
               	str	w21, [x0]
               	b	0x4004b4 <.text+0x1b4>
               	ldur	x21, [x29, #-0x8]
               	ldursw	x22, [x29, #-0x10]
               	add	x0, x21, x22
               	ldrb	w22, [x0]
               	mov	x17, #0x55              // =85
               	eor	x0, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x0, x17
               	cmp	x22, #0x0
               	b.eq	0x400554 <.text+0x254>
               	b	0x40052c <.text+0x22c>
               	mov	x0, #0x0                // =0
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
               	b	0x4004c4 <.text+0x1c4>
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
               	b	0x4005b8 <.text+0x2b8>
               	ldursw	x15, [x29, #-0x10]
               	ldursw	x14, [x29, #0x10]
               	cmp	x15, x14
               	b.ge	0x40060c <.text+0x30c>
               	b	0x4005e0 <.text+0x2e0>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	add	x15, x13, #0x1
               	str	w15, [x14]
               	b	0x4005b8 <.text+0x2b8>
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
               	b	0x4005cc <.text+0x2cc>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x10]
               	b	0x400618 <.text+0x318>
               	ldursw	x13, [x29, #-0x10]
               	ldursw	x14, [x29, #0x10]
               	cmp	x13, x14
               	b.ge	0x400668 <.text+0x368>
               	b	0x400640 <.text+0x340>
               	sub	x14, x29, #0x10
               	ldrsw	x12, [x14]
               	add	x13, x12, #0x1
               	str	w13, [x14]
               	b	0x400618 <.text+0x318>
               	sub	x13, x29, #0x18
               	ldrsw	x12, [x13]
               	ldur	x14, [x29, #-0x8]
               	ldursw	x15, [x29, #-0x10]
               	lsl	x11, x15, #2
               	add	x15, x14, x11
               	ldrsw	x11, [x15]
               	add	x15, x12, x11
               	str	w15, [x13]
               	b	0x40062c <.text+0x32c>
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
               	b.ne	0x400730 <.text+0x430>
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
               	bl	0x400e84 <memset>
               	ldur	x23, [x29, #-0x10]
               	mov	x24, #0x42              // =66
               	mov	x0, x23
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x400e84 <memset>
               	ldur	x0, [x29, #-0x8]
               	ldrb	w24, [x0]
               	mov	x17, #0x41              // =65
               	eor	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	cmp	x24, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x38
               	str	x0, [x17]
               	cbnz	x0, 0x4007d0 <.text+0x4d0>
               	ldur	x24, [x29, #-0x8]
               	add	x0, x24, #0xf
               	ldrb	w24, [x0]
               	mov	x17, #0x41              // =65
               	eor	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	cmp	x24, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x38
               	str	x0, [x17]
               	b	0x4007d0 <.text+0x4d0>
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x38
               	ldr	x0, [x16]
               	cbz	x0, 0x400810 <.text+0x510>
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
               	ldur	x0, [x29, #-0x10]
               	ldrb	w24, [x0]
               	mov	x17, #0x42              // =66
               	eor	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	cmp	x24, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x40
               	str	x0, [x17]
               	cbnz	x0, 0x40087c <.text+0x57c>
               	ldur	x24, [x29, #-0x10]
               	add	x0, x24, #0xf
               	ldrb	w24, [x0]
               	mov	x17, #0x42              // =66
               	eor	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	cmp	x24, #0x0
               	cset	x0, ne
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x40
               	str	x0, [x17]
               	b	0x40087c <.text+0x57c>
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x40
               	ldr	x0, [x16]
               	cbz	x0, 0x4008bc <.text+0x5bc>
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
               	b	0x400920 <.text+0x620>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x15, [x29, #0x10]
               	cmp	x14, x15
               	b.ge	0x400994 <.text+0x694>
               	b	0x400948 <.text+0x648>
               	sub	x15, x29, #0x10
               	ldrsw	x13, [x15]
               	add	x14, x13, #0x1
               	str	w14, [x15]
               	b	0x400920 <.text+0x620>
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
               	b	0x400934 <.text+0x634>
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
               	bl	0x400e84 <memset>
               	mov	x23, #0x14              // =20
               	mov	x0, x23
               	bl	0x4008e8 <.text+0x5e8>
               	stur	w0, [x29, #-0x10]
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0x18]
               	b	0x400a3c <.text+0x73c>
               	ldursw	x23, [x29, #-0x18]
               	cmp	x23, #0x40
               	b.ge	0x400a88 <.text+0x788>
               	b	0x400a60 <.text+0x760>
               	sub	x23, x29, #0x18
               	ldrsw	x0, [x23]
               	add	x21, x0, #0x1
               	str	w21, [x23]
               	b	0x400a3c <.text+0x73c>
               	ldur	x21, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x18]
               	add	x23, x21, x0
               	ldrb	w0, [x23]
               	ldursw	x23, [x29, #0x10]
               	mov	x17, #0xff              // =255
               	and	x21, x23, x17
               	cmp	x0, x21
               	b.eq	0x400ad4 <.text+0x7d4>
               	b	0x400a98 <.text+0x798>
               	ldursw	x23, [x29, #-0x10]
               	cmp	x23, #0xbe
               	b.eq	0x400b14 <.text+0x814>
               	b	0x400ad8 <.text+0x7d8>
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
               	b	0x400a4c <.text+0x74c>
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
               	bl	0x400448 <.text+0x148>
               	cmp	x0, #0x0
               	b.eq	0x400bac <.text+0x8ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400e90 <printf>
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
               	bl	0x400558 <.text+0x258>
               	cmp	x0, #0x11d
               	b.eq	0x400c14 <.text+0x914>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x165
               	mov	x20, x19
               	mov	x22, #0xa               // =10
               	mov	x0, x22
               	bl	0x400558 <.text+0x258>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400e90 <printf>
               	sxtw	x0, w0
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400684 <.text+0x384>
               	cmp	x0, #0x0
               	b.eq	0x400c5c <.text+0x95c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x177
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400e90 <printf>
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
               	mov	x22, #0x32              // =50
               	mov	x0, x22
               	bl	0x4008e8 <.text+0x5e8>
               	cmp	x0, #0x4c9
               	b.eq	0x400cc0 <.text+0x9c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x186
               	mov	x21, x19
               	mov	x23, #0x32              // =50
               	mov	x0, x23
               	bl	0x4008e8 <.text+0x5e8>
               	mov	x22, x0
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400e90 <printf>
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
               	mov	x23, #0x33              // =51
               	mov	x0, x23
               	bl	0x4009b0 <.text+0x6b0>
               	cmp	x0, #0x0
               	b.eq	0x400d10 <.text+0xa10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x197
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x400e90 <printf>
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
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
