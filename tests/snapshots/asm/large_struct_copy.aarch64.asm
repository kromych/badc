
large_struct_copy.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400450 <.text+0x150>
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
               	bl	0x400dc8 <dlsym>
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
               	add	x14, x13, #0x4
               	mov	x13, #0xc8              // =200
               	str	w13, [x14]
               	sub	x15, x29, #0x210
               	add	x13, x15, #0x8
               	mov	x15, #0x12c             // =300
               	str	w15, [x13]
               	sub	x14, x29, #0x210
               	add	x15, x14, #0xc
               	mov	x14, #0x190             // =400
               	str	w14, [x15]
               	sub	x13, x29, #0x210
               	add	x14, x13, #0xb0
               	mov	x13, #0xffff            // =65535
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	str	w13, [x14]
               	sub	x15, x29, #0x210
               	add	x13, x15, #0x154
               	mov	x15, #0xfffe            // =65534
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	str	w15, [x13]
               	sub	x14, x29, #0x210
               	add	x15, x14, #0x1f8
               	mov	x14, #0xfffd            // =65533
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	str	w14, [x15]
               	sub	x13, x29, #0x210
               	add	x14, x13, #0x1fc
               	mov	x13, #0x1f4             // =500
               	str	w13, [x14]
               	sub	x15, x29, #0x210
               	add	x13, x15, #0x200
               	mov	x15, #0x258             // =600
               	str	w15, [x13]
               	sub	x14, x29, #0x210
               	add	x15, x14, #0x204
               	mov	x14, #0x2bc             // =700
               	str	w14, [x15]
               	sub	x13, x29, #0x210
               	add	x14, x13, #0x208
               	mov	x13, #0x320             // =800
               	str	w13, [x14]
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x428
               	str	w15, [x17]
               	b	0x400550 <.text+0x250>
               	sub	x16, x29, #0x428
               	ldrsw	x15, [x16]
               	cmp	x15, #0x28
               	b.ge	0x4005e8 <.text+0x2e8>
               	b	0x400578 <.text+0x278>
               	sub	x15, x29, #0x428
               	ldrsw	x13, [x15]
               	add	x14, x13, #0x1
               	str	w14, [x15]
               	b	0x400550 <.text+0x250>
               	sub	x14, x29, #0x210
               	add	x13, x14, #0x10
               	sub	x16, x29, #0x428
               	ldrsw	x14, [x16]
               	lsl	x15, x14, #2
               	add	x12, x13, x15
               	add	x15, x14, #0x3e8
               	sxtw	x15, w15
               	str	w15, [x12]
               	sub	x14, x29, #0x210
               	add	x15, x14, #0xb4
               	sub	x16, x29, #0x428
               	ldrsw	x14, [x16]
               	lsl	x12, x14, #2
               	add	x13, x15, x12
               	add	x12, x14, #0x7d0
               	sxtw	x12, w12
               	str	w12, [x13]
               	sub	x14, x29, #0x210
               	add	x12, x14, #0x158
               	sub	x16, x29, #0x428
               	ldrsw	x14, [x16]
               	lsl	x13, x14, #2
               	add	x15, x12, x13
               	add	x13, x14, #0xbb8
               	sxtw	x13, w13
               	str	w13, [x15]
               	b	0x400564 <.text+0x264>
               	sub	x20, x29, #0x420
               	mov	x21, #0x7e              // =126
               	mov	x22, #0x20c             // =524
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400dd4 <memset>
               	mov	x12, x0
               	sub	x12, x29, #0x420
               	sub	x22, x29, #0x210
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x12]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x12, #0x8]
               	ldr	x10, [x22, #0x10]
               	str	x10, [x12, #0x10]
               	ldr	x10, [x22, #0x18]
               	str	x10, [x12, #0x18]
               	ldr	x10, [x22, #0x20]
               	str	x10, [x12, #0x20]
               	ldr	x10, [x22, #0x28]
               	str	x10, [x12, #0x28]
               	ldr	x10, [x22, #0x30]
               	str	x10, [x12, #0x30]
               	ldr	x10, [x22, #0x38]
               	str	x10, [x12, #0x38]
               	ldr	x10, [x22, #0x40]
               	str	x10, [x12, #0x40]
               	ldr	x10, [x22, #0x48]
               	str	x10, [x12, #0x48]
               	ldr	x10, [x22, #0x50]
               	str	x10, [x12, #0x50]
               	ldr	x10, [x22, #0x58]
               	str	x10, [x12, #0x58]
               	ldr	x10, [x22, #0x60]
               	str	x10, [x12, #0x60]
               	ldr	x10, [x22, #0x68]
               	str	x10, [x12, #0x68]
               	ldr	x10, [x22, #0x70]
               	str	x10, [x12, #0x70]
               	ldr	x10, [x22, #0x78]
               	str	x10, [x12, #0x78]
               	ldr	x10, [x22, #0x80]
               	str	x10, [x12, #0x80]
               	ldr	x10, [x22, #0x88]
               	str	x10, [x12, #0x88]
               	ldr	x10, [x22, #0x90]
               	str	x10, [x12, #0x90]
               	ldr	x10, [x22, #0x98]
               	str	x10, [x12, #0x98]
               	ldr	x10, [x22, #0xa0]
               	str	x10, [x12, #0xa0]
               	ldr	x10, [x22, #0xa8]
               	str	x10, [x12, #0xa8]
               	ldr	x10, [x22, #0xb0]
               	str	x10, [x12, #0xb0]
               	ldr	x10, [x22, #0xb8]
               	str	x10, [x12, #0xb8]
               	ldr	x10, [x22, #0xc0]
               	str	x10, [x12, #0xc0]
               	ldr	x10, [x22, #0xc8]
               	str	x10, [x12, #0xc8]
               	ldr	x10, [x22, #0xd0]
               	str	x10, [x12, #0xd0]
               	ldr	x10, [x22, #0xd8]
               	str	x10, [x12, #0xd8]
               	ldr	x10, [x22, #0xe0]
               	str	x10, [x12, #0xe0]
               	ldr	x10, [x22, #0xe8]
               	str	x10, [x12, #0xe8]
               	ldr	x10, [x22, #0xf0]
               	str	x10, [x12, #0xf0]
               	ldr	x10, [x22, #0xf8]
               	str	x10, [x12, #0xf8]
               	ldr	x10, [x22, #0x100]
               	str	x10, [x12, #0x100]
               	ldr	x10, [x22, #0x108]
               	str	x10, [x12, #0x108]
               	ldr	x10, [x22, #0x110]
               	str	x10, [x12, #0x110]
               	ldr	x10, [x22, #0x118]
               	str	x10, [x12, #0x118]
               	ldr	x10, [x22, #0x120]
               	str	x10, [x12, #0x120]
               	ldr	x10, [x22, #0x128]
               	str	x10, [x12, #0x128]
               	ldr	x10, [x22, #0x130]
               	str	x10, [x12, #0x130]
               	ldr	x10, [x22, #0x138]
               	str	x10, [x12, #0x138]
               	ldr	x10, [x22, #0x140]
               	str	x10, [x12, #0x140]
               	ldr	x10, [x22, #0x148]
               	str	x10, [x12, #0x148]
               	ldr	x10, [x22, #0x150]
               	str	x10, [x12, #0x150]
               	ldr	x10, [x22, #0x158]
               	str	x10, [x12, #0x158]
               	ldr	x10, [x22, #0x160]
               	str	x10, [x12, #0x160]
               	ldr	x10, [x22, #0x168]
               	str	x10, [x12, #0x168]
               	ldr	x10, [x22, #0x170]
               	str	x10, [x12, #0x170]
               	ldr	x10, [x22, #0x178]
               	str	x10, [x12, #0x178]
               	ldr	x10, [x22, #0x180]
               	str	x10, [x12, #0x180]
               	ldr	x10, [x22, #0x188]
               	str	x10, [x12, #0x188]
               	ldr	x10, [x22, #0x190]
               	str	x10, [x12, #0x190]
               	ldr	x10, [x22, #0x198]
               	str	x10, [x12, #0x198]
               	ldr	x10, [x22, #0x1a0]
               	str	x10, [x12, #0x1a0]
               	ldr	x10, [x22, #0x1a8]
               	str	x10, [x12, #0x1a8]
               	ldr	x10, [x22, #0x1b0]
               	str	x10, [x12, #0x1b0]
               	ldr	x10, [x22, #0x1b8]
               	str	x10, [x12, #0x1b8]
               	ldr	x10, [x22, #0x1c0]
               	str	x10, [x12, #0x1c0]
               	ldr	x10, [x22, #0x1c8]
               	str	x10, [x12, #0x1c8]
               	ldr	x10, [x22, #0x1d0]
               	str	x10, [x12, #0x1d0]
               	ldr	x10, [x22, #0x1d8]
               	str	x10, [x12, #0x1d8]
               	ldr	x10, [x22, #0x1e0]
               	str	x10, [x12, #0x1e0]
               	ldr	x10, [x22, #0x1e8]
               	str	x10, [x12, #0x1e8]
               	ldr	x10, [x22, #0x1f0]
               	str	x10, [x12, #0x1f0]
               	ldr	x10, [x22, #0x1f8]
               	str	x10, [x12, #0x1f8]
               	ldr	x10, [x22, #0x200]
               	str	x10, [x12, #0x200]
               	ldrb	w10, [x22, #0x208]
               	strb	w10, [x12, #0x208]
               	ldrb	w10, [x22, #0x209]
               	strb	w10, [x12, #0x209]
               	ldrb	w10, [x22, #0x20a]
               	strb	w10, [x12, #0x20a]
               	ldrb	w10, [x22, #0x20b]
               	strb	w10, [x12, #0x20b]
               	ldr	x10, [sp], #0x10
               	mov	x21, x12
               	sub	x21, x29, #0x420
               	ldrsw	x22, [x21]
               	cmp	x22, #0x64
               	cset	x21, ne
               	sub	x17, x29, #0x458
               	str	x21, [x17]
               	cbnz	x21, 0x400880 <.text+0x580>
               	sub	x22, x29, #0x420
               	add	x21, x22, #0x4
               	ldrsw	x22, [x21]
               	cmp	x22, #0xc8
               	cset	x21, ne
               	sub	x17, x29, #0x458
               	str	x21, [x17]
               	b	0x400880 <.text+0x580>
               	sub	x16, x29, #0x458
               	ldr	x21, [x16]
               	sub	x17, x29, #0x450
               	str	x21, [x17]
               	cbnz	x21, 0x4008b4 <.text+0x5b4>
               	sub	x22, x29, #0x420
               	add	x21, x22, #0x8
               	ldrsw	x22, [x21]
               	cmp	x22, #0x12c
               	cset	x21, ne
               	sub	x17, x29, #0x450
               	str	x21, [x17]
               	b	0x4008b4 <.text+0x5b4>
               	sub	x16, x29, #0x450
               	ldr	x21, [x16]
               	sub	x17, x29, #0x448
               	str	x21, [x17]
               	cbnz	x21, 0x4008e8 <.text+0x5e8>
               	sub	x22, x29, #0x420
               	add	x21, x22, #0xc
               	ldrsw	x22, [x21]
               	cmp	x22, #0x190
               	cset	x21, ne
               	sub	x17, x29, #0x448
               	str	x21, [x17]
               	b	0x4008e8 <.text+0x5e8>
               	sub	x16, x29, #0x448
               	ldr	x21, [x16]
               	cbz	x21, 0x40091c <.text+0x61c>
               	mov	x22, #0x1               // =1
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
               	add	x22, x21, #0x1fc
               	ldrsw	x21, [x22]
               	cmp	x21, #0x1f4
               	cset	x22, ne
               	sub	x17, x29, #0x470
               	str	x22, [x17]
               	cbnz	x22, 0x40095c <.text+0x65c>
               	sub	x21, x29, #0x420
               	add	x22, x21, #0x200
               	ldrsw	x21, [x22]
               	cmp	x21, #0x258
               	cset	x22, ne
               	sub	x17, x29, #0x470
               	str	x22, [x17]
               	b	0x40095c <.text+0x65c>
               	sub	x16, x29, #0x470
               	ldr	x22, [x16]
               	sub	x17, x29, #0x468
               	str	x22, [x17]
               	cbnz	x22, 0x400990 <.text+0x690>
               	sub	x21, x29, #0x420
               	add	x22, x21, #0x204
               	ldrsw	x21, [x22]
               	cmp	x21, #0x2bc
               	cset	x22, ne
               	sub	x17, x29, #0x468
               	str	x22, [x17]
               	b	0x400990 <.text+0x690>
               	sub	x16, x29, #0x468
               	ldr	x22, [x16]
               	sub	x17, x29, #0x460
               	str	x22, [x17]
               	cbnz	x22, 0x4009c4 <.text+0x6c4>
               	sub	x21, x29, #0x420
               	add	x22, x21, #0x208
               	ldrsw	x21, [x22]
               	cmp	x21, #0x320
               	cset	x22, ne
               	sub	x17, x29, #0x460
               	str	x22, [x17]
               	b	0x4009c4 <.text+0x6c4>
               	sub	x16, x29, #0x460
               	ldr	x22, [x16]
               	cbz	x22, 0x4009f8 <.text+0x6f8>
               	mov	x21, #0x2               // =2
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
               	add	x21, x22, #0xb0
               	ldrsw	x22, [x21]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	b.eq	0x400a44 <.text+0x744>
               	mov	x22, #0x3               // =3
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
               	add	x22, x21, #0x154
               	ldrsw	x21, [x22]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	b.eq	0x400a90 <.text+0x790>
               	mov	x21, #0x4               // =4
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
               	add	x21, x22, #0x1f8
               	ldrsw	x22, [x21]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	b.eq	0x400adc <.text+0x7dc>
               	mov	x22, #0x5               // =5
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	sub	x17, x29, #0x428
               	str	w21, [x17]
               	b	0x400aec <.text+0x7ec>
               	sub	x16, x29, #0x428
               	ldrsw	x21, [x16]
               	cmp	x21, #0x28
               	b.ge	0x400b44 <.text+0x844>
               	b	0x400b14 <.text+0x814>
               	sub	x21, x29, #0x428
               	ldrsw	x22, [x21]
               	add	x12, x22, #0x1
               	str	w12, [x21]
               	b	0x400aec <.text+0x7ec>
               	sub	x12, x29, #0x420
               	add	x22, x12, #0x10
               	sub	x16, x29, #0x428
               	ldrsw	x12, [x16]
               	lsl	x21, x12, #2
               	add	x20, x22, x21
               	ldrsw	x21, [x20]
               	add	x20, x12, #0x3e8
               	sxtw	x20, w20
               	cmp	x21, x20
               	b.eq	0x400bbc <.text+0x8bc>
               	b	0x400b88 <.text+0x888>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x0, x23
               	bl	0x400de0 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x428
               	ldrsw	x20, [x16]
               	add	x12, x20, #0xa
               	sxtw	x12, w12
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x420
               	add	x12, x20, #0xb4
               	sub	x16, x29, #0x428
               	ldrsw	x20, [x16]
               	lsl	x21, x20, #2
               	add	x22, x12, x21
               	ldrsw	x21, [x22]
               	add	x22, x20, #0x7d0
               	sxtw	x22, w22
               	cmp	x21, x22
               	b.eq	0x400c1c <.text+0x91c>
               	sub	x16, x29, #0x428
               	ldrsw	x22, [x16]
               	add	x20, x22, #0x3c
               	sxtw	x20, w20
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x420
               	add	x20, x22, #0x158
               	sub	x16, x29, #0x428
               	ldrsw	x22, [x16]
               	lsl	x21, x22, #2
               	add	x12, x20, x21
               	ldrsw	x21, [x12]
               	add	x12, x22, #0xbb8
               	sxtw	x12, w12
               	cmp	x21, x12
               	b.eq	0x400c7c <.text+0x97c>
               	sub	x16, x29, #0x428
               	ldrsw	x12, [x16]
               	add	x22, x12, #0x6e
               	sxtw	x22, w22
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400b00 <.text+0x800>
