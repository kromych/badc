
vfork_shared_stack_slot_reuse.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x430              // =1072
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0xc0
               	ldr	x16, [sp, #0xc0]
               	str	x16, [sp]
               	ldr	x16, [sp, #0xc8]
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0xd0]
               	str	x16, [sp, #0x20]
               	ldr	x16, [sp, #0xd8]
               	str	x16, [sp, #0x30]
               	ldr	x16, [sp, #0xe0]
               	str	x16, [sp, #0x40]
               	ldr	x16, [sp, #0xe8]
               	str	x16, [sp, #0x50]
               	ldr	x16, [sp, #0xf0]
               	str	x16, [sp, #0x60]
               	ldr	x16, [sp, #0xf8]
               	str	x16, [sp, #0x70]
               	ldr	x16, [sp, #0x100]
               	str	x16, [sp, #0x80]
               	ldr	x16, [sp, #0x108]
               	str	x16, [sp, #0x90]
               	ldr	x16, [sp, #0x110]
               	str	x16, [sp, #0xa0]
               	ldr	x16, [sp, #0x118]
               	str	x16, [sp, #0xb0]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ldursw	x1, [x29, #0x90]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0xa0]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0xb0]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0xc0]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0xd0]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0xe0]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0xf0]
               	add	x0, x0, x1
               	add	x16, x29, #0x100
               	ldrsw	x1, [x16]
               	add	x0, x0, x1
               	add	x16, x29, #0x110
               	ldrsw	x1, [x16]
               	add	x0, x0, x1
               	add	x16, x29, #0x120
               	ldrsw	x1, [x16]
               	add	x0, x0, x1
               	add	x16, x29, #0x130
               	ldrsw	x1, [x16]
               	add	x0, x0, x1
               	add	x16, x29, #0x140
               	ldrsw	x1, [x16]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x140
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x250
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x3, x0, #0x1
               	str	w3, [x2, x0, lsl #2]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x40
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	sxtw	x2, w1
               	sxtw	x20, w2
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x1
               	sxtw	x21, w1
               	ldrsw	x1, [x0, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x2
               	sxtw	x22, w1
               	ldrsw	x1, [x0, #0xc]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x3
               	sxtw	x23, w1
               	ldrsw	x1, [x0, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x4
               	sxtw	x24, w1
               	ldrsw	x1, [x0, #0x14]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x5
               	sxtw	x25, w1
               	ldrsw	x1, [x0, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x6
               	sxtw	x26, w1
               	ldrsw	x1, [x0, #0x1c]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x7
               	sxtw	x27, w1
               	ldrsw	x1, [x0, #0x20]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x8
               	sxtw	x28, w1
               	ldrsw	x1, [x0, #0x24]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0x9
               	sxtw	x16, w1
               	str	x16, [sp, #0x78]
               	ldrsw	x1, [x0, #0x28]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x16, w1
               	str	x16, [sp, #0x70]
               	ldrsw	x0, [x0, #0x2c]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0xb
               	sxtw	x16, w0
               	str	x16, [sp, #0x68]
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x60]
               	ldr	x16, [sp, #0x60]
               	stur	w16, [x29, #-0x78]
               	sxtw	x0, w0
               	sub	x1, x29, #0x78
               	ldr	x2, [sp, #0x60]
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x21, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x2               // =2
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	cmp	x22, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x4               // =4
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x23, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x8               // =8
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x4
               	sxtw	x0, w0
               	cmp	x24, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x10              // =16
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x14]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x5
               	sxtw	x0, w0
               	cmp	x25, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x20              // =32
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x18]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x6
               	sxtw	x0, w0
               	cmp	x26, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x40              // =64
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x7
               	sxtw	x0, w0
               	cmp	x27, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x80              // =128
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x20]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x8
               	sxtw	x0, w0
               	cmp	x28, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x100             // =256
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x24]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x9
               	sxtw	x0, w0
               	ldr	x16, [sp, #0x78]
               	cmp	x16, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x200             // =512
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x28]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldr	x16, [sp, #0x70]
               	cmp	x16, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x400             // =1024
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x2c]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0xb
               	sxtw	x0, w0
               	ldr	x16, [sp, #0x68]
               	cmp	x16, x0
               	b.eq	<addr>
               	ldr	x16, [sp, #0x60]
               	mov	x17, #0x800             // =2048
               	orr	x16, x16, x17
               	str	x16, [sp, #0x60]
               	ldr	x16, [sp, #0x60]
               	sxtw	x0, w16
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [sp, #0x60]
               	sxtw	x1, w16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x40]
               	mov	x17, #0x5               // =5
               	mul	x1, x1, x17
               	add	x1, x1, #0x1
               	ldrsw	x2, [x0, #0x44]
               	mov	x17, #0x5               // =5
               	mul	x2, x2, x17
               	add	x2, x2, #0x2
               	ldrsw	x3, [x0, #0x48]
               	mov	x17, #0x5               // =5
               	mul	x3, x3, x17
               	add	x3, x3, #0x3
               	ldrsw	x4, [x0, #0x4c]
               	mov	x17, #0x5               // =5
               	mul	x4, x4, x17
               	add	x4, x4, #0x4
               	ldrsw	x5, [x0, #0x50]
               	mov	x17, #0x5               // =5
               	mul	x5, x5, x17
               	add	x5, x5, #0x5
               	ldrsw	x6, [x0, #0x54]
               	mov	x17, #0x5               // =5
               	mul	x6, x6, x17
               	add	x6, x6, #0x6
               	ldrsw	x7, [x0, #0x58]
               	mov	x17, #0x5               // =5
               	mul	x7, x7, x17
               	add	x7, x7, #0x7
               	ldrsw	x8, [x0, #0x5c]
               	mov	x17, #0x5               // =5
               	mul	x8, x8, x17
               	add	x8, x8, #0x8
               	ldrsw	x9, [x0, #0x60]
               	mov	x17, #0x5               // =5
               	mul	x9, x9, x17
               	add	x9, x9, #0x9
               	sxtw	x9, w9
               	ldrsw	x10, [x0, #0x64]
               	mov	x17, #0x5               // =5
               	mul	x10, x10, x17
               	add	x10, x10, #0xa
               	sxtw	x10, w10
               	ldrsw	x11, [x0, #0x68]
               	mov	x17, #0x5               // =5
               	mul	x11, x11, x17
               	add	x11, x11, #0xb
               	sxtw	x11, w11
               	ldrsw	x12, [x0, #0x6c]
               	mov	x17, #0x5               // =5
               	mul	x12, x12, x17
               	add	x12, x12, #0xc
               	sxtw	x12, w12
               	ldrsw	x13, [x0, #0x70]
               	mov	x17, #0x5               // =5
               	mul	x13, x13, x17
               	add	x13, x13, #0xd
               	sxtw	x13, w13
               	ldrsw	x14, [x0, #0x74]
               	mov	x17, #0x5               // =5
               	mul	x14, x14, x17
               	add	x14, x14, #0xe
               	sxtw	x14, w14
               	ldrsw	x15, [x0, #0x78]
               	mov	x17, #0x5               // =5
               	mul	x15, x15, x17
               	add	x15, x15, #0xf
               	sxtw	x15, w15
               	ldrsw	x20, [x0, #0x7c]
               	mov	x17, #0x5               // =5
               	mul	x20, x20, x17
               	add	x20, x20, #0x10
               	sxtw	x20, w20
               	ldrsw	x21, [x0, #0x80]
               	mov	x17, #0x5               // =5
               	mul	x21, x21, x17
               	add	x21, x21, #0x11
               	sxtw	x21, w21
               	ldrsw	x22, [x0, #0x84]
               	mov	x17, #0x5               // =5
               	mul	x22, x22, x17
               	add	x22, x22, #0x12
               	sxtw	x22, w22
               	ldrsw	x23, [x0, #0x88]
               	mov	x17, #0x5               // =5
               	mul	x23, x23, x17
               	add	x23, x23, #0x13
               	sxtw	x23, w23
               	ldrsw	x0, [x0, #0x8c]
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x0, x0, #0x14
               	sxtw	x0, w0
               	sub	sp, sp, #0x60
               	str	x9, [sp]
               	str	x10, [sp, #0x8]
               	str	x11, [sp, #0x10]
               	str	x12, [sp, #0x18]
               	str	x13, [sp, #0x20]
               	str	x14, [sp, #0x28]
               	str	x15, [sp, #0x30]
               	str	x20, [sp, #0x38]
               	str	x21, [sp, #0x40]
               	str	x22, [sp, #0x48]
               	str	x23, [sp, #0x50]
               	str	x0, [sp, #0x58]
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x6
               	mov	x6, x7
               	mov	x7, x8
               	bl	<addr>
               	add	sp, sp, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
