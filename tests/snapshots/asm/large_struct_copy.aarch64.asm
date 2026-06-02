
large_struct_copy.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x108
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x108
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
               	add	x12, x12, #0x120
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x126
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x12d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x108
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0x108
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x480
               	str	x19, [sp]
               	sub	x15, x29, #0x210
               	mov	x14, #0x64              // =100
               	str	w14, [x15]
               	sub	x13, x29, #0x210
               	add	x13, x13, #0x4
               	mov	x14, #0xc8              // =200
               	str	w14, [x13]
               	sub	x15, x29, #0x210
               	add	x15, x15, #0x8
               	mov	x14, #0x12c             // =300
               	str	w14, [x15]
               	sub	x13, x29, #0x210
               	add	x13, x13, #0xc
               	mov	x14, #0x190             // =400
               	str	w14, [x13]
               	sub	x15, x29, #0x210
               	add	x15, x15, #0xb0
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	str	w14, [x15]
               	sub	x13, x29, #0x210
               	add	x13, x13, #0x154
               	mov	x14, #0xfffe            // =65534
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	str	w14, [x13]
               	sub	x15, x29, #0x210
               	add	x15, x15, #0x1f8
               	mov	x14, #0xfffd            // =65533
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	str	w14, [x15]
               	sub	x13, x29, #0x210
               	add	x13, x13, #0x1fc
               	mov	x14, #0x1f4             // =500
               	str	w14, [x13]
               	sub	x15, x29, #0x210
               	add	x15, x15, #0x200
               	mov	x14, #0x258             // =600
               	str	w14, [x15]
               	sub	x13, x29, #0x210
               	add	x13, x13, #0x204
               	mov	x14, #0x2bc             // =700
               	str	w14, [x13]
               	sub	x15, x29, #0x210
               	add	x15, x15, #0x208
               	mov	x14, #0x320             // =800
               	str	w14, [x15]
               	mov	x13, #0x0               // =0
               	sub	x17, x29, #0x428
               	str	w13, [x17]
               	b	<addr>
               	sub	x16, x29, #0x428
               	ldrsw	x13, [x16]
               	cmp	x13, #0x28
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x428
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	b	<addr>
               	sub	x13, x29, #0x210
               	add	x13, x13, #0x10
               	sub	x16, x29, #0x428
               	ldrsw	x15, [x16]
               	lsl	x14, x15, #2
               	add	x13, x13, x14
               	add	x15, x15, #0x3e8
               	sxtw	x15, w15
               	str	w15, [x13]
               	sub	x14, x29, #0x210
               	add	x14, x14, #0xb4
               	sub	x16, x29, #0x428
               	ldrsw	x15, [x16]
               	lsl	x13, x15, #2
               	add	x14, x14, x13
               	add	x15, x15, #0x7d0
               	sxtw	x15, w15
               	str	w15, [x14]
               	sub	x13, x29, #0x210
               	add	x13, x13, #0x158
               	sub	x16, x29, #0x428
               	ldrsw	x15, [x16]
               	lsl	x14, x15, #2
               	add	x13, x13, x14
               	add	x15, x15, #0xbb8
               	sxtw	x15, w15
               	str	w15, [x13]
               	b	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x7e               // =126
               	mov	x2, #0x20c              // =524
               	bl	<addr>
               	mov	x12, x0
               	sub	x12, x29, #0x420
               	sub	x2, x29, #0x210
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x12]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x12, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x12, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x12, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x12, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x12, #0x28]
               	ldr	x10, [x2, #0x30]
               	str	x10, [x12, #0x30]
               	ldr	x10, [x2, #0x38]
               	str	x10, [x12, #0x38]
               	ldr	x10, [x2, #0x40]
               	str	x10, [x12, #0x40]
               	ldr	x10, [x2, #0x48]
               	str	x10, [x12, #0x48]
               	ldr	x10, [x2, #0x50]
               	str	x10, [x12, #0x50]
               	ldr	x10, [x2, #0x58]
               	str	x10, [x12, #0x58]
               	ldr	x10, [x2, #0x60]
               	str	x10, [x12, #0x60]
               	ldr	x10, [x2, #0x68]
               	str	x10, [x12, #0x68]
               	ldr	x10, [x2, #0x70]
               	str	x10, [x12, #0x70]
               	ldr	x10, [x2, #0x78]
               	str	x10, [x12, #0x78]
               	ldr	x10, [x2, #0x80]
               	str	x10, [x12, #0x80]
               	ldr	x10, [x2, #0x88]
               	str	x10, [x12, #0x88]
               	ldr	x10, [x2, #0x90]
               	str	x10, [x12, #0x90]
               	ldr	x10, [x2, #0x98]
               	str	x10, [x12, #0x98]
               	ldr	x10, [x2, #0xa0]
               	str	x10, [x12, #0xa0]
               	ldr	x10, [x2, #0xa8]
               	str	x10, [x12, #0xa8]
               	ldr	x10, [x2, #0xb0]
               	str	x10, [x12, #0xb0]
               	ldr	x10, [x2, #0xb8]
               	str	x10, [x12, #0xb8]
               	ldr	x10, [x2, #0xc0]
               	str	x10, [x12, #0xc0]
               	ldr	x10, [x2, #0xc8]
               	str	x10, [x12, #0xc8]
               	ldr	x10, [x2, #0xd0]
               	str	x10, [x12, #0xd0]
               	ldr	x10, [x2, #0xd8]
               	str	x10, [x12, #0xd8]
               	ldr	x10, [x2, #0xe0]
               	str	x10, [x12, #0xe0]
               	ldr	x10, [x2, #0xe8]
               	str	x10, [x12, #0xe8]
               	ldr	x10, [x2, #0xf0]
               	str	x10, [x12, #0xf0]
               	ldr	x10, [x2, #0xf8]
               	str	x10, [x12, #0xf8]
               	ldr	x10, [x2, #0x100]
               	str	x10, [x12, #0x100]
               	ldr	x10, [x2, #0x108]
               	str	x10, [x12, #0x108]
               	ldr	x10, [x2, #0x110]
               	str	x10, [x12, #0x110]
               	ldr	x10, [x2, #0x118]
               	str	x10, [x12, #0x118]
               	ldr	x10, [x2, #0x120]
               	str	x10, [x12, #0x120]
               	ldr	x10, [x2, #0x128]
               	str	x10, [x12, #0x128]
               	ldr	x10, [x2, #0x130]
               	str	x10, [x12, #0x130]
               	ldr	x10, [x2, #0x138]
               	str	x10, [x12, #0x138]
               	ldr	x10, [x2, #0x140]
               	str	x10, [x12, #0x140]
               	ldr	x10, [x2, #0x148]
               	str	x10, [x12, #0x148]
               	ldr	x10, [x2, #0x150]
               	str	x10, [x12, #0x150]
               	ldr	x10, [x2, #0x158]
               	str	x10, [x12, #0x158]
               	ldr	x10, [x2, #0x160]
               	str	x10, [x12, #0x160]
               	ldr	x10, [x2, #0x168]
               	str	x10, [x12, #0x168]
               	ldr	x10, [x2, #0x170]
               	str	x10, [x12, #0x170]
               	ldr	x10, [x2, #0x178]
               	str	x10, [x12, #0x178]
               	ldr	x10, [x2, #0x180]
               	str	x10, [x12, #0x180]
               	ldr	x10, [x2, #0x188]
               	str	x10, [x12, #0x188]
               	ldr	x10, [x2, #0x190]
               	str	x10, [x12, #0x190]
               	ldr	x10, [x2, #0x198]
               	str	x10, [x12, #0x198]
               	ldr	x10, [x2, #0x1a0]
               	str	x10, [x12, #0x1a0]
               	ldr	x10, [x2, #0x1a8]
               	str	x10, [x12, #0x1a8]
               	ldr	x10, [x2, #0x1b0]
               	str	x10, [x12, #0x1b0]
               	ldr	x10, [x2, #0x1b8]
               	str	x10, [x12, #0x1b8]
               	ldr	x10, [x2, #0x1c0]
               	str	x10, [x12, #0x1c0]
               	ldr	x10, [x2, #0x1c8]
               	str	x10, [x12, #0x1c8]
               	ldr	x10, [x2, #0x1d0]
               	str	x10, [x12, #0x1d0]
               	ldr	x10, [x2, #0x1d8]
               	str	x10, [x12, #0x1d8]
               	ldr	x10, [x2, #0x1e0]
               	str	x10, [x12, #0x1e0]
               	ldr	x10, [x2, #0x1e8]
               	str	x10, [x12, #0x1e8]
               	ldr	x10, [x2, #0x1f0]
               	str	x10, [x12, #0x1f0]
               	ldr	x10, [x2, #0x1f8]
               	str	x10, [x12, #0x1f8]
               	ldr	x10, [x2, #0x200]
               	str	x10, [x12, #0x200]
               	ldrb	w10, [x2, #0x208]
               	strb	w10, [x12, #0x208]
               	ldrb	w10, [x2, #0x209]
               	strb	w10, [x12, #0x209]
               	ldrb	w10, [x2, #0x20a]
               	strb	w10, [x12, #0x20a]
               	ldrb	w10, [x2, #0x20b]
               	strb	w10, [x12, #0x20b]
               	ldr	x10, [sp], #0x10
               	sub	x12, x29, #0x420
               	ldrsw	x12, [x12]
               	cmp	x12, #0x64
               	cset	x12, ne
               	sub	x17, x29, #0x458
               	str	x12, [x17]
               	cbnz	x12, <addr>
               	sub	x2, x29, #0x420
               	add	x2, x2, #0x4
               	ldrsw	x2, [x2]
               	cmp	x2, #0xc8
               	cset	x2, ne
               	sub	x17, x29, #0x458
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x458
               	ldr	x2, [x16]
               	sub	x17, x29, #0x450
               	str	x2, [x17]
               	cbnz	x2, <addr>
               	sub	x12, x29, #0x420
               	add	x12, x12, #0x8
               	ldrsw	x12, [x12]
               	cmp	x12, #0x12c
               	cset	x12, ne
               	sub	x17, x29, #0x450
               	str	x12, [x17]
               	b	<addr>
               	sub	x16, x29, #0x450
               	ldr	x12, [x16]
               	sub	x17, x29, #0x448
               	str	x12, [x17]
               	cbnz	x12, <addr>
               	sub	x2, x29, #0x420
               	add	x2, x2, #0xc
               	ldrsw	x2, [x2]
               	cmp	x2, #0x190
               	cset	x2, ne
               	sub	x17, x29, #0x448
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x448
               	ldr	x2, [x16]
               	cbz	x2, <addr>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x420
               	add	x2, x2, #0x1fc
               	ldrsw	x2, [x2]
               	cmp	x2, #0x1f4
               	cset	x2, ne
               	sub	x17, x29, #0x470
               	str	x2, [x17]
               	cbnz	x2, <addr>
               	sub	x12, x29, #0x420
               	add	x12, x12, #0x200
               	ldrsw	x12, [x12]
               	cmp	x12, #0x258
               	cset	x12, ne
               	sub	x17, x29, #0x470
               	str	x12, [x17]
               	b	<addr>
               	sub	x16, x29, #0x470
               	ldr	x12, [x16]
               	sub	x17, x29, #0x468
               	str	x12, [x17]
               	cbnz	x12, <addr>
               	sub	x2, x29, #0x420
               	add	x2, x2, #0x204
               	ldrsw	x2, [x2]
               	cmp	x2, #0x2bc
               	cset	x2, ne
               	sub	x17, x29, #0x468
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x468
               	ldr	x2, [x16]
               	sub	x17, x29, #0x460
               	str	x2, [x17]
               	cbnz	x2, <addr>
               	sub	x12, x29, #0x420
               	add	x12, x12, #0x208
               	ldrsw	x12, [x12]
               	cmp	x12, #0x320
               	cset	x12, ne
               	sub	x17, x29, #0x460
               	str	x12, [x17]
               	b	<addr>
               	sub	x16, x29, #0x460
               	ldr	x12, [x16]
               	cbz	x12, <addr>
               	mov	x2, #0x2                // =2
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x420
               	add	x12, x12, #0xb0
               	ldrsw	x12, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x2, #0x3                // =3
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x420
               	add	x12, x12, #0x154
               	ldrsw	x12, [x12]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x2, #0x4                // =4
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x420
               	add	x12, x12, #0x1f8
               	ldrsw	x12, [x12]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x12, x17
               	b.eq	<addr>
               	mov	x2, #0x5                // =5
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	sub	x17, x29, #0x428
               	str	w12, [x17]
               	b	<addr>
               	sub	x16, x29, #0x428
               	ldrsw	x12, [x16]
               	cmp	x12, #0x28
               	b.ge	<addr>
               	b	<addr>
               	sub	x2, x29, #0x428
               	ldrsw	x12, [x2]
               	add	x12, x12, #0x1
               	str	w12, [x2]
               	b	<addr>
               	sub	x12, x29, #0x420
               	add	x12, x12, #0x10
               	sub	x16, x29, #0x428
               	ldrsw	x1, [x16]
               	lsl	x2, x1, #2
               	add	x12, x12, x2
               	ldrsw	x12, [x12]
               	add	x1, x1, #0x3e8
               	sxtw	x1, w1
               	cmp	x12, x1
               	b.eq	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x428
               	ldrsw	x1, [x16]
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x420
               	add	x12, x12, #0xb4
               	sub	x16, x29, #0x428
               	ldrsw	x1, [x16]
               	lsl	x2, x1, #2
               	add	x12, x12, x2
               	ldrsw	x12, [x12]
               	add	x1, x1, #0x7d0
               	sxtw	x1, w1
               	cmp	x12, x1
               	b.eq	<addr>
               	sub	x16, x29, #0x428
               	ldrsw	x1, [x16]
               	add	x1, x1, #0x3c
               	sxtw	x1, w1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x420
               	add	x12, x12, #0x158
               	sub	x16, x29, #0x428
               	ldrsw	x1, [x16]
               	lsl	x2, x1, #2
               	add	x12, x12, x2
               	ldrsw	x12, [x12]
               	add	x1, x1, #0xbb8
               	sxtw	x1, w1
               	cmp	x12, x1
               	b.eq	<addr>
               	sub	x16, x29, #0x428
               	ldrsw	x1, [x16]
               	add	x1, x1, #0x6e
               	sxtw	x1, w1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
