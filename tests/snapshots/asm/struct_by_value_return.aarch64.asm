
struct_by_value_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x15, x29, #0x8
               	ldursw	x14, [x29, #0x20]
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	ldursw	x14, [x29, #0x30]
               	str	w14, [x13]
               	ldur	x0, [x29, #0x10]
               	sub	x14, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x13, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	sxtw	x15, w0
               	mov	x14, #0xdead            // =57005
               	mov	x13, #0xbeef            // =48879
               	mov	x12, #0xcafe            // =51966
               	mov	x11, #0xacef            // =44271
               	movk	x11, #0xf, lsl #16
               	sxtw	x14, w14
               	sxtw	x13, w13
               	add	x14, x14, x13
               	sxtw	x14, w14
               	sxtw	x12, w12
               	add	x14, x14, x12
               	sxtw	x14, w14
               	sxtw	x11, w11
               	add	x14, x14, x11
               	sxtw	x14, w14
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x15, x29, #0x8
               	ldur	x14, [x29, #0x20]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x10
               	ldur	x14, [x29, #0x30]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x13]
               	ldr	x10, [sp], #0x10
               	mov	x15, x13
               	sub	x15, x29, #0x18
               	sub	x14, x29, #0x8
               	ldrsw	x14, [x14]
               	sub	x13, x29, #0x10
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	str	w14, [x15]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x4
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	add	x14, x14, x15
               	sxtw	x14, w14
               	str	w14, [x13]
               	ldur	x0, [x29, #0x10]
               	sub	x14, x29, #0x18
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x13, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	sub	x20, x29, #0x8
               	sub	x21, x29, #0x90
               	mov	x22, #0xb               // =11
               	mov	x23, #0x16              // =22
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x23, x20
               	mov	x23, #0x7               // =7
               	mov	x0, #0xdead             // =57005
               	mov	x20, #0xbeef            // =48879
               	mov	x22, #0xcafe            // =51966
               	mov	x21, #0xacef            // =44271
               	movk	x21, #0xf, lsl #16
               	sxtw	x0, w0
               	sxtw	x20, w20
               	add	x0, x0, x20
               	sxtw	x0, w0
               	sxtw	x22, w22
               	add	x0, x0, x22
               	sxtw	x0, w0
               	sxtw	x21, w21
               	add	x0, x0, x21
               	sxtw	x0, w0
               	add	x0, x0, x23
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x23, #0x63              // =99
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x20
               	sub	x25, x29, #0xa0
               	mov	x23, #0x3               // =3
               	mov	x21, #0x4               // =4
               	mov	x0, x25
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sub	x0, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x24]
               	ldr	x10, [sp], #0x10
               	mov	x21, x24
               	sub	x21, x29, #0x20
               	ldrsw	x21, [x21]
               	cmp	x21, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x20
               	add	x21, x21, #0x4
               	ldrsw	x21, [x21]
               	cmp	x21, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x30
               	sub	x21, x29, #0xb0
               	mov	x22, #0x64              // =100
               	mov	x24, #0xc8              // =200
               	mov	x0, x21
               	mov	x2, x24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0xb0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x24, x20
               	sub	x25, x29, #0x38
               	sub	x24, x29, #0xc0
               	mov	x23, #0x12c             // =300
               	mov	x20, #0x190             // =400
               	mov	x0, x24
               	mov	x2, x20
               	mov	x1, x23
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x25]
               	ldr	x10, [sp], #0x10
               	mov	x20, x25
               	sub	x20, x29, #0x30
               	ldrsw	x20, [x20]
               	cmp	x20, #0x64
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x30
               	add	x20, x20, #0x4
               	ldrsw	x20, [x20]
               	cmp	x20, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x38
               	ldrsw	x20, [x20]
               	cmp	x20, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x38
               	add	x20, x20, #0x4
               	ldrsw	x20, [x20]
               	cmp	x20, #0x190
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x50
               	sub	x20, x29, #0xd0
               	sub	x22, x29, #0xe0
               	mov	x25, #0x1               // =1
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x25
               	bl	<addr>
               	sub	x24, x29, #0xe0
               	sub	x26, x29, #0xf0
               	mov	x23, #0x3               // =3
               	mov	x25, #0x4               // =4
               	mov	x0, x26
               	mov	x2, x25
               	mov	x1, x23
               	bl	<addr>
               	sub	x22, x29, #0xf0
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	<addr>
               	sub	x0, x29, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [sp], #0x10
               	mov	x22, x21
               	sub	x22, x29, #0x50
               	ldrsw	x22, [x22]
               	cmp	x22, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x50
               	add	x22, x22, #0x4
               	ldrsw	x22, [x22]
               	cmp	x22, #0x6
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
