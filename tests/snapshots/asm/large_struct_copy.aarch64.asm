
large_struct_copy.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40044c <.text+0x14c>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40038c <.text+0x8c>
               	adrp	x19, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x126
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400da8 <dlsym>
               	cbz	x0, 0x400414 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400414 <.text+0x114>
               	adrp	x19, 0x410000
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
               	sub	sp, sp, #0x4a0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
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
               	b	0x40054c <.text+0x24c>
               	sub	x16, x29, #0x428
               	ldrsw	x13, [x16]
               	cmp	x13, #0x28
               	b.ge	0x4005e4 <.text+0x2e4>
               	b	0x400574 <.text+0x274>
               	sub	x14, x29, #0x428
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	b	0x40054c <.text+0x24c>
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
               	b	0x400560 <.text+0x260>
               	sub	x20, x29, #0x420
               	mov	x21, #0x7e              // =126
               	mov	x22, #0x20c             // =524
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400db4 <memset>
               	sub	x0, x29, #0x420
               	sub	x22, x29, #0x210
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x0]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x22, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x22, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x22, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x22, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x22, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x22, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x22, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x22, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x22, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x22, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x22, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x22, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x22, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x22, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [x22, #0x80]
               	str	x10, [x0, #0x80]
               	ldr	x10, [x22, #0x88]
               	str	x10, [x0, #0x88]
               	ldr	x10, [x22, #0x90]
               	str	x10, [x0, #0x90]
               	ldr	x10, [x22, #0x98]
               	str	x10, [x0, #0x98]
               	ldr	x10, [x22, #0xa0]
               	str	x10, [x0, #0xa0]
               	ldr	x10, [x22, #0xa8]
               	str	x10, [x0, #0xa8]
               	ldr	x10, [x22, #0xb0]
               	str	x10, [x0, #0xb0]
               	ldr	x10, [x22, #0xb8]
               	str	x10, [x0, #0xb8]
               	ldr	x10, [x22, #0xc0]
               	str	x10, [x0, #0xc0]
               	ldr	x10, [x22, #0xc8]
               	str	x10, [x0, #0xc8]
               	ldr	x10, [x22, #0xd0]
               	str	x10, [x0, #0xd0]
               	ldr	x10, [x22, #0xd8]
               	str	x10, [x0, #0xd8]
               	ldr	x10, [x22, #0xe0]
               	str	x10, [x0, #0xe0]
               	ldr	x10, [x22, #0xe8]
               	str	x10, [x0, #0xe8]
               	ldr	x10, [x22, #0xf0]
               	str	x10, [x0, #0xf0]
               	ldr	x10, [x22, #0xf8]
               	str	x10, [x0, #0xf8]
               	ldr	x10, [x22, #0x100]
               	str	x10, [x0, #0x100]
               	ldr	x10, [x22, #0x108]
               	str	x10, [x0, #0x108]
               	ldr	x10, [x22, #0x110]
               	str	x10, [x0, #0x110]
               	ldr	x10, [x22, #0x118]
               	str	x10, [x0, #0x118]
               	ldr	x10, [x22, #0x120]
               	str	x10, [x0, #0x120]
               	ldr	x10, [x22, #0x128]
               	str	x10, [x0, #0x128]
               	ldr	x10, [x22, #0x130]
               	str	x10, [x0, #0x130]
               	ldr	x10, [x22, #0x138]
               	str	x10, [x0, #0x138]
               	ldr	x10, [x22, #0x140]
               	str	x10, [x0, #0x140]
               	ldr	x10, [x22, #0x148]
               	str	x10, [x0, #0x148]
               	ldr	x10, [x22, #0x150]
               	str	x10, [x0, #0x150]
               	ldr	x10, [x22, #0x158]
               	str	x10, [x0, #0x158]
               	ldr	x10, [x22, #0x160]
               	str	x10, [x0, #0x160]
               	ldr	x10, [x22, #0x168]
               	str	x10, [x0, #0x168]
               	ldr	x10, [x22, #0x170]
               	str	x10, [x0, #0x170]
               	ldr	x10, [x22, #0x178]
               	str	x10, [x0, #0x178]
               	ldr	x10, [x22, #0x180]
               	str	x10, [x0, #0x180]
               	ldr	x10, [x22, #0x188]
               	str	x10, [x0, #0x188]
               	ldr	x10, [x22, #0x190]
               	str	x10, [x0, #0x190]
               	ldr	x10, [x22, #0x198]
               	str	x10, [x0, #0x198]
               	ldr	x10, [x22, #0x1a0]
               	str	x10, [x0, #0x1a0]
               	ldr	x10, [x22, #0x1a8]
               	str	x10, [x0, #0x1a8]
               	ldr	x10, [x22, #0x1b0]
               	str	x10, [x0, #0x1b0]
               	ldr	x10, [x22, #0x1b8]
               	str	x10, [x0, #0x1b8]
               	ldr	x10, [x22, #0x1c0]
               	str	x10, [x0, #0x1c0]
               	ldr	x10, [x22, #0x1c8]
               	str	x10, [x0, #0x1c8]
               	ldr	x10, [x22, #0x1d0]
               	str	x10, [x0, #0x1d0]
               	ldr	x10, [x22, #0x1d8]
               	str	x10, [x0, #0x1d8]
               	ldr	x10, [x22, #0x1e0]
               	str	x10, [x0, #0x1e0]
               	ldr	x10, [x22, #0x1e8]
               	str	x10, [x0, #0x1e8]
               	ldr	x10, [x22, #0x1f0]
               	str	x10, [x0, #0x1f0]
               	ldr	x10, [x22, #0x1f8]
               	str	x10, [x0, #0x1f8]
               	ldr	x10, [x22, #0x200]
               	str	x10, [x0, #0x200]
               	ldrb	w10, [x22, #0x208]
               	strb	w10, [x0, #0x208]
               	ldrb	w10, [x22, #0x209]
               	strb	w10, [x0, #0x209]
               	ldrb	w10, [x22, #0x20a]
               	strb	w10, [x0, #0x20a]
               	ldrb	w10, [x22, #0x20b]
               	strb	w10, [x0, #0x20b]
               	ldr	x10, [sp], #0x10
               	mov	x21, x0
               	sub	x21, x29, #0x420
               	ldrsw	x22, [x21]
               	cmp	x22, #0x64
               	cset	x22, ne
               	sub	x17, x29, #0x458
               	str	x22, [x17]
               	cbnz	x22, 0x400878 <.text+0x578>
               	sub	x21, x29, #0x420
               	add	x21, x21, #0x4
               	ldrsw	x22, [x21]
               	cmp	x22, #0xc8
               	cset	x22, ne
               	sub	x17, x29, #0x458
               	str	x22, [x17]
               	b	0x400878 <.text+0x578>
               	sub	x16, x29, #0x458
               	ldr	x22, [x16]
               	sub	x17, x29, #0x450
               	str	x22, [x17]
               	cbnz	x22, 0x4008ac <.text+0x5ac>
               	sub	x21, x29, #0x420
               	add	x21, x21, #0x8
               	ldrsw	x22, [x21]
               	cmp	x22, #0x12c
               	cset	x22, ne
               	sub	x17, x29, #0x450
               	str	x22, [x17]
               	b	0x4008ac <.text+0x5ac>
               	sub	x16, x29, #0x450
               	ldr	x22, [x16]
               	sub	x17, x29, #0x448
               	str	x22, [x17]
               	cbnz	x22, 0x4008e0 <.text+0x5e0>
               	sub	x21, x29, #0x420
               	add	x21, x21, #0xc
               	ldrsw	x22, [x21]
               	cmp	x22, #0x190
               	cset	x22, ne
               	sub	x17, x29, #0x448
               	str	x22, [x17]
               	b	0x4008e0 <.text+0x5e0>
               	sub	x16, x29, #0x448
               	ldr	x22, [x16]
               	cbz	x22, 0x400914 <.text+0x614>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x420
               	add	x22, x22, #0x1fc
               	ldrsw	x21, [x22]
               	cmp	x21, #0x1f4
               	cset	x21, ne
               	sub	x17, x29, #0x470
               	str	x21, [x17]
               	cbnz	x21, 0x400954 <.text+0x654>
               	sub	x22, x29, #0x420
               	add	x22, x22, #0x200
               	ldrsw	x21, [x22]
               	cmp	x21, #0x258
               	cset	x21, ne
               	sub	x17, x29, #0x470
               	str	x21, [x17]
               	b	0x400954 <.text+0x654>
               	sub	x16, x29, #0x470
               	ldr	x21, [x16]
               	sub	x17, x29, #0x468
               	str	x21, [x17]
               	cbnz	x21, 0x400988 <.text+0x688>
               	sub	x22, x29, #0x420
               	add	x22, x22, #0x204
               	ldrsw	x21, [x22]
               	cmp	x21, #0x2bc
               	cset	x21, ne
               	sub	x17, x29, #0x468
               	str	x21, [x17]
               	b	0x400988 <.text+0x688>
               	sub	x16, x29, #0x468
               	ldr	x21, [x16]
               	sub	x17, x29, #0x460
               	str	x21, [x17]
               	cbnz	x21, 0x4009bc <.text+0x6bc>
               	sub	x22, x29, #0x420
               	add	x22, x22, #0x208
               	ldrsw	x21, [x22]
               	cmp	x21, #0x320
               	cset	x21, ne
               	sub	x17, x29, #0x460
               	str	x21, [x17]
               	b	0x4009bc <.text+0x6bc>
               	sub	x16, x29, #0x460
               	ldr	x21, [x16]
               	cbz	x21, 0x4009f0 <.text+0x6f0>
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x420
               	add	x21, x21, #0xb0
               	ldrsw	x22, [x21]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	b.eq	0x400a3c <.text+0x73c>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x420
               	add	x22, x22, #0x154
               	ldrsw	x21, [x22]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	b.eq	0x400a88 <.text+0x788>
               	mov	x22, #0x4               // =4
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x420
               	add	x21, x21, #0x1f8
               	ldrsw	x22, [x21]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	b.eq	0x400ad4 <.text+0x7d4>
               	mov	x21, #0x5               // =5
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	sub	x17, x29, #0x428
               	str	w22, [x17]
               	b	0x400ae4 <.text+0x7e4>
               	sub	x16, x29, #0x428
               	ldrsw	x22, [x16]
               	cmp	x22, #0x28
               	b.ge	0x400b3c <.text+0x83c>
               	b	0x400b0c <.text+0x80c>
               	sub	x21, x29, #0x428
               	ldrsw	x22, [x21]
               	add	x22, x22, #0x1
               	str	w22, [x21]
               	b	0x400ae4 <.text+0x7e4>
               	sub	x22, x29, #0x420
               	add	x22, x22, #0x10
               	sub	x16, x29, #0x428
               	ldrsw	x0, [x16]
               	lsl	x21, x0, #2
               	add	x22, x22, x21
               	ldrsw	x21, [x22]
               	add	x0, x0, #0x3e8
               	sxtw	x0, w0
               	cmp	x21, x0
               	b.eq	0x400ba8 <.text+0x8a8>
               	b	0x400b78 <.text+0x878>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x0, x23
               	bl	0x400dc0 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x428
               	ldrsw	x0, [x16]
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x420
               	add	x21, x21, #0xb4
               	sub	x16, x29, #0x428
               	ldrsw	x0, [x16]
               	lsl	x22, x0, #2
               	add	x21, x21, x22
               	ldrsw	x22, [x21]
               	add	x0, x0, #0x7d0
               	sxtw	x0, w0
               	cmp	x22, x0
               	b.eq	0x400c04 <.text+0x904>
               	sub	x16, x29, #0x428
               	ldrsw	x0, [x16]
               	add	x0, x0, #0x3c
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x420
               	add	x22, x22, #0x158
               	sub	x16, x29, #0x428
               	ldrsw	x0, [x16]
               	lsl	x21, x0, #2
               	add	x22, x22, x21
               	ldrsw	x21, [x22]
               	add	x0, x0, #0xbb8
               	sxtw	x0, w0
               	cmp	x21, x0
               	b.eq	0x400c60 <.text+0x960>
               	sub	x16, x29, #0x428
               	ldrsw	x0, [x16]
               	add	x0, x0, #0x6e
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400af8 <.text+0x7f8>
