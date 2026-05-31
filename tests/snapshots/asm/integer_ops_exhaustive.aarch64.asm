
integer_ops_exhaustive.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40040c <.text+0x14c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
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
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x402448 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	sub	sp, sp, #0x150
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	mov	x21, #0x1               // =1
               	b	0x40044c <.text+0x18c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x21, x17
               	cmp	x13, x12
               	cset	x13, hi
               	cmp	x13, #0x0
               	b.ne	0x4004e0 <.text+0x220>
               	b	0x400484 <.text+0x1c4>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x40044c <.text+0x18c>
               	b	0x4004e4 <.text+0x224>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x15a
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400478 <.text+0x1b8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	cmp	x0, x23
               	cset	x0, lo
               	cmp	x0, #0x0
               	b.ne	0x400578 <.text+0x2b8>
               	b	0x40051c <.text+0x25c>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4004e4 <.text+0x224>
               	b	0x40057c <.text+0x2bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x16d
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x177
               	mov	x23, x19
               	mov	x0, x24
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400510 <.text+0x250>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x0, x23
               	cset	x0, hs
               	cmp	x0, #0x0
               	b.ne	0x400610 <.text+0x350>
               	b	0x4005b4 <.text+0x2f4>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x40057c <.text+0x2bc>
               	b	0x400614 <.text+0x354>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x18a
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x194
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4005a8 <.text+0x2e8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	cmp	x0, x23
               	cset	x0, ls
               	cmp	x0, #0x0
               	b.ne	0x4006a8 <.text+0x3e8>
               	b	0x40064c <.text+0x38c>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400614 <.text+0x354>
               	b	0x4006ac <.text+0x3ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b2
               	mov	x23, x19
               	mov	x0, x24
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400640 <.text+0x380>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x0, x23
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	0x400740 <.text+0x480>
               	b	0x4006e4 <.text+0x424>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4006ac <.text+0x3ec>
               	b	0x400744 <.text+0x484>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c6
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4006d8 <.text+0x418>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x0, x23
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4007f4 <.text+0x534>
               	b	0x400798 <.text+0x4d8>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400744 <.text+0x484>
               	mov	x22, #0xfffe            // =65534
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x25, #0x1               // =1
               	b	0x4007f8 <.text+0x538>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e4
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ee
               	mov	x23, x19
               	mov	x0, x24
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400778 <.text+0x4b8>
               	sxtw	x21, w22
               	sxtw	x20, w25
               	cmp	x21, x20
               	cset	x21, lt
               	cmp	x21, #0x0
               	b.ne	0x40087c <.text+0x5bc>
               	b	0x400820 <.text+0x560>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4007f8 <.text+0x538>
               	b	0x400880 <.text+0x5c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x20c
               	mov	x20, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400814 <.text+0x554>
               	sxtw	x0, w25
               	sxtw	x20, w22
               	cmp	x0, x20
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	0x400904 <.text+0x644>
               	b	0x4008a8 <.text+0x5e8>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400880 <.text+0x5c0>
               	b	0x400908 <.text+0x648>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x217
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x221
               	mov	x20, x19
               	mov	x0, x24
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40089c <.text+0x5dc>
               	sxtw	x0, w22
               	sxtw	x20, w25
               	cmp	x0, x20
               	cset	x0, le
               	cmp	x0, #0x0
               	b.ne	0x40098c <.text+0x6cc>
               	b	0x400930 <.text+0x670>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400908 <.text+0x648>
               	b	0x400990 <.text+0x6d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22c
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x236
               	mov	x20, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400924 <.text+0x664>
               	sxtw	x0, w25
               	sxtw	x20, w22
               	cmp	x0, x20
               	cset	x0, ge
               	cmp	x0, #0x0
               	b.ne	0x400a28 <.text+0x768>
               	b	0x4009cc <.text+0x70c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400990 <.text+0x6d0>
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	0x400a2c <.text+0x76c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x242
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x24c
               	mov	x20, x19
               	mov	x0, x24
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4009ac <.text+0x6ec>
               	cmp	x23, x21
               	cset	x25, hi
               	cmp	x25, #0x0
               	b.ne	0x400aa8 <.text+0x7e8>
               	b	0x400a4c <.text+0x78c>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400a2c <.text+0x76c>
               	b	0x400aac <.text+0x7ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x258
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x262
               	mov	x22, x19
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400a40 <.text+0x780>
               	cmp	x23, x21
               	cset	x0, hs
               	cmp	x0, #0x0
               	b.ne	0x400b28 <.text+0x868>
               	b	0x400acc <.text+0x80c>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400aac <.text+0x7ec>
               	b	0x400b2c <.text+0x86c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x26f
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x279
               	mov	x22, x19
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400ac0 <.text+0x800>
               	cmp	x21, x23
               	cset	x0, lo
               	cmp	x0, #0x0
               	b.ne	0x400bbc <.text+0x8fc>
               	b	0x400b60 <.text+0x8a0>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400b2c <.text+0x86c>
               	mov	x24, #0xfffe            // =65534
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x25, #0x1               // =1
               	b	0x400bc0 <.text+0x900>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x287
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x291
               	mov	x22, x19
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400b40 <.text+0x880>
               	cmp	x25, x24
               	cset	x21, gt
               	cmp	x21, #0x0
               	b.ne	0x400c3c <.text+0x97c>
               	b	0x400be0 <.text+0x920>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400bc0 <.text+0x900>
               	b	0x400c40 <.text+0x980>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x29e
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2a8
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400bd4 <.text+0x914>
               	cmp	x24, #0x0
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	0x400cc4 <.text+0xa04>
               	b	0x400c68 <.text+0x9a8>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400c40 <.text+0x980>
               	mov	x25, #0xfe              // =254
               	mov	x21, #0x1               // =1
               	b	0x400cc8 <.text+0xa08>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2b3
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2bd
               	mov	x23, x19
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400c54 <.text+0x994>
               	mov	x17, #0xff              // =255
               	and	x24, x25, x17
               	mov	x17, #0xff              // =255
               	and	x20, x21, x17
               	cmp	x24, x20
               	cset	x24, gt
               	cmp	x24, #0x0
               	b.ne	0x400d54 <.text+0xa94>
               	b	0x400cf8 <.text+0xa38>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400cc8 <.text+0xa08>
               	b	0x400d58 <.text+0xa98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2c8
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d2
               	mov	x20, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400cec <.text+0xa2c>
               	mov	x17, #0xff              // =255
               	and	x0, x21, x17
               	mov	x17, #0xff              // =255
               	and	x20, x25, x17
               	cmp	x0, x20
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	0x400df8 <.text+0xb38>
               	b	0x400d9c <.text+0xadc>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400d58 <.text+0xa98>
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x24, #0x1               // =1
               	b	0x400dfc <.text+0xb3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2de
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x20, x19
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400d7c <.text+0xabc>
               	sxtb	x21, w23
               	sxtb	x25, w24
               	cmp	x21, x25
               	cset	x21, lt
               	cmp	x21, #0x0
               	b.ne	0x400e80 <.text+0xbc0>
               	b	0x400e24 <.text+0xb64>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400dfc <.text+0xb3c>
               	b	0x400e84 <.text+0xbc4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f4
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2fe
               	mov	x25, x19
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400e18 <.text+0xb58>
               	sxtb	x0, w24
               	sxtb	x25, w23
               	cmp	x0, x25
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	0x400f20 <.text+0xc60>
               	b	0x400ec4 <.text+0xc04>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400e84 <.text+0xbc4>
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x68]
               	sub	x25, x29, #0x68
               	ldr	w0, [x25]
               	add	x0, x0, #0x5
               	str	w0, [x25]
               	b	0x400f24 <.text+0xc64>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x308
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x312
               	mov	x25, x19
               	mov	x0, x22
               	mov	x1, x25
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400ea0 <.text+0xbe0>
               	ldur	w0, [x29, #-0x68]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400fc8 <.text+0xd08>
               	b	0x400f6c <.text+0xcac>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400f24 <.text+0xc64>
               	sub	x0, x29, #0x68
               	ldr	w24, [x0]
               	sub	x24, x24, #0xa
               	str	w24, [x0]
               	b	0x400fcc <.text+0xd0c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x31c
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x326
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400f50 <.text+0xc90>
               	ldur	w24, [x29, #-0x68]
               	mov	x17, #0x5f              // =95
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401070 <.text+0xdb0>
               	b	0x401014 <.text+0xd54>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400fcc <.text+0xd0c>
               	sub	x0, x29, #0x68
               	ldr	w20, [x0]
               	lsl	x20, x20, #1
               	str	w20, [x0]
               	b	0x401074 <.text+0xdb4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32f
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x339
               	mov	x20, x19
               	mov	x0, x25
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400ff8 <.text+0xd38>
               	ldur	w20, [x29, #-0x68]
               	mov	x17, #0xbe              // =190
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x40111c <.text+0xe5c>
               	b	0x4010c0 <.text+0xe00>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401074 <.text+0xdb4>
               	sub	x0, x29, #0x68
               	ldr	w25, [x0]
               	mov	x24, #0x5               // =5
               	udiv	x25, x25, x24
               	str	w25, [x0]
               	b	0x401120 <.text+0xe60>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x343
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x34d
               	mov	x25, x19
               	mov	x0, x24
               	mov	x1, x25
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4010a0 <.text+0xde0>
               	ldur	w25, [x29, #-0x68]
               	mov	x17, #0x26              // =38
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4011cc <.text+0xf0c>
               	b	0x401170 <.text+0xeb0>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401120 <.text+0xe60>
               	sub	x0, x29, #0x68
               	ldr	w24, [x0]
               	mov	x20, #0x7               // =7
               	udiv	x17, x24, x20
               	msub	x24, x17, x20, x24
               	str	w24, [x0]
               	b	0x4011d0 <.text+0xf10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x356
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x360
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40114c <.text+0xe8c>
               	ldur	w24, [x29, #-0x68]
               	mov	x17, #0x3               // =3
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401284 <.text+0xfc4>
               	b	0x401228 <.text+0xf68>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4011d0 <.text+0xf10>
               	mov	x0, #0x1                // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	sub	x0, x0, #0x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	b	0x401288 <.text+0xfc8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x369
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x373
               	mov	x20, x19
               	mov	x0, x25
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4011fc <.text+0xf3c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401330 <.text+0x1070>
               	b	0x4012d4 <.text+0x1014>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401288 <.text+0xfc8>
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0x78]
               	sub	x25, x29, #0x78
               	ldr	x0, [x25]
               	add	x0, x0, #0x19f
               	str	x0, [x25]
               	b	0x401334 <.text+0x1074>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x37c
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x386
               	mov	x25, x19
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4012b0 <.text+0xff0>
               	ldur	x0, [x29, #-0x78]
               	cmp	x0, #0x587
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4013c8 <.text+0x1108>
               	b	0x40136c <.text+0x10ac>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401334 <.text+0x1074>
               	sub	x0, x29, #0x78
               	ldr	x24, [x0]
               	mov	x17, #0x3               // =3
               	mul	x24, x24, x17
               	str	x24, [x0]
               	b	0x4013cc <.text+0x110c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x394
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x39e
               	mov	x24, x19
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40134c <.text+0x108c>
               	ldur	x24, [x29, #-0x78]
               	mov	x17, #0x1095            // =4245
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401464 <.text+0x11a4>
               	b	0x401408 <.text+0x1148>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4013cc <.text+0x110c>
               	sub	x0, x29, #0x78
               	ldr	x23, [x0]
               	mov	x25, #0x5               // =5
               	udiv	x23, x23, x25
               	str	x23, [x0]
               	b	0x401468 <.text+0x11a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3a9
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3b3
               	mov	x23, x19
               	mov	x0, x25
               	mov	x1, x23
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4013e8 <.text+0x1128>
               	ldur	x23, [x29, #-0x78]
               	cmp	x23, #0x351
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401540 <.text+0x1280>
               	b	0x4014e4 <.text+0x1224>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401468 <.text+0x11a8>
               	mov	x0, #0xff00             // =65280
               	movk	x0, #0xff00, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x23, x0, x17
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xf, lsl #16
               	orr	x25, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	eor	x24, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x0, x17
               	b	0x401544 <.text+0x1284>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3bc
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3c6
               	mov	x25, x19
               	mov	x0, x24
               	mov	x1, x25
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401480 <.text+0x11c0>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	mov	x17, #0xf00             // =3840
               	movk	x17, #0xf00, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4015e4 <.text+0x1324>
               	b	0x401588 <.text+0x12c8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401544 <.text+0x1284>
               	b	0x4015e8 <.text+0x1328>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3cf
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3d9
               	mov	x21, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40157c <.text+0x12bc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xff0f, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401678 <.text+0x13b8>
               	b	0x40161c <.text+0x135c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4015e8 <.text+0x1328>
               	b	0x40167c <.text+0x13bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3df
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3e9
               	mov	x21, x19
               	mov	x0, x26
               	mov	x1, x21
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401610 <.text+0x1350>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x40171c <.text+0x145c>
               	b	0x4016c0 <.text+0x1400>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x40167c <.text+0x13bc>
               	b	0x401720 <.text+0x1460>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3ef
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3f9
               	mov	x21, x19
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4016b4 <.text+0x13f4>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4017e4 <.text+0x1524>
               	b	0x401788 <.text+0x14c8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401720 <.text+0x1460>
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	b	0x4017e8 <.text+0x1528>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3ff
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x409
               	mov	x21, x19
               	mov	x0, x25
               	mov	x1, x21
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401758 <.text+0x1498>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4018a8 <.text+0x15e8>
               	b	0x40184c <.text+0x158c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4017e8 <.text+0x1528>
               	mov	x0, #0x1                // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	b	0x4018ac <.text+0x15ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x40f
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x419
               	mov	x20, x19
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401820 <.text+0x1560>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x40193c <.text+0x167c>
               	b	0x4018e0 <.text+0x1620>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x4018ac <.text+0x15ec>
               	mov	x21, #0x1               // =1
               	b	0x401940 <.text+0x1680>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x422
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x42c
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4018d0 <.text+0x1610>
               	lsl	x24, x21, #63
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4019d8 <.text+0x1718>
               	b	0x40197c <.text+0x16bc>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401940 <.text+0x1680>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x24, #0x1               // =1
               	b	0x4019dc <.text+0x171c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x436
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x440
               	mov	x25, x19
               	mov	x0, x27
               	mov	x1, x25
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40195c <.text+0x169c>
               	sxtw	x21, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x24, x17
               	cmp	x21, x27
               	cset	x21, hi
               	cmp	x21, #0x0
               	b.ne	0x401a74 <.text+0x17b4>
               	b	0x401a18 <.text+0x1758>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4019dc <.text+0x171c>
               	b	0x401a78 <.text+0x17b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x44a
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x454
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401a0c <.text+0x174c>
               	sxtw	x0, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x24, x17
               	sxtw	x27, w27
               	cmp	x0, x27
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	0x401b24 <.text+0x1864>
               	b	0x401ac8 <.text+0x1808>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401a78 <.text+0x17b8>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0xe0]
               	sub	x27, x29, #0xe0
               	ldr	w0, [x27]
               	add	x0, x0, #0x1
               	str	w0, [x27]
               	b	0x401b28 <.text+0x1868>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x460
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46a
               	mov	x27, x19
               	mov	x0, x23
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401aa0 <.text+0x17e0>
               	ldur	w0, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401bc0 <.text+0x1900>
               	b	0x401b64 <.text+0x18a4>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401b28 <.text+0x1868>
               	sub	x0, x29, #0xe0
               	ldr	w24, [x0]
               	add	x24, x24, #0x1
               	str	w24, [x0]
               	b	0x401bc4 <.text+0x1904>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x475
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x47f
               	mov	x24, x19
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401b48 <.text+0x1888>
               	ldur	w24, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401c68 <.text+0x19a8>
               	b	0x401c0c <.text+0x194c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401bc4 <.text+0x1904>
               	mov	x0, #0xfe               // =254
               	sturb	w0, [x29, #-0xe8]
               	sub	x25, x29, #0xe8
               	ldrb	w0, [x25]
               	add	x0, x0, #0x1
               	strb	w0, [x25]
               	b	0x401c6c <.text+0x19ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x48e
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x498
               	mov	x25, x19
               	mov	x0, x27
               	mov	x1, x25
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401be8 <.text+0x1928>
               	ldurb	w0, [x29, #-0xe8]
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401d10 <.text+0x1a50>
               	b	0x401cb4 <.text+0x19f4>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401c6c <.text+0x19ac>
               	sub	x0, x29, #0xe8
               	ldrb	w27, [x0]
               	add	x27, x27, #0x1
               	strb	w27, [x0]
               	b	0x401d14 <.text+0x1a54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4aa
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4b4
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401c98 <.text+0x19d8>
               	ldurb	w27, [x29, #-0xe8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401dc4 <.text+0x1b04>
               	b	0x401d68 <.text+0x1aa8>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401d14 <.text+0x1a54>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0xf0]
               	sub	x24, x29, #0xf0
               	ldr	x0, [x24]
               	add	x0, x0, #0x1
               	str	x0, [x24]
               	b	0x401dc8 <.text+0x1b08>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4c7
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4d1
               	mov	x24, x19
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401d38 <.text+0x1a78>
               	ldur	x0, [x29, #-0xf0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401e68 <.text+0x1ba8>
               	b	0x401e0c <.text+0x1b4c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401dc8 <.text+0x1b08>
               	sub	x0, x29, #0xf0
               	ldr	x25, [x0]
               	add	x25, x25, #0x1
               	str	x25, [x0]
               	b	0x401e6c <.text+0x1bac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4e2
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4ec
               	mov	x25, x19
               	mov	x0, x27
               	mov	x1, x25
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401df0 <.text+0x1b30>
               	ldur	x25, [x29, #-0xf0]
               	cmp	x25, #0x0
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401eec <.text+0x1c2c>
               	b	0x401e90 <.text+0x1bd0>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401e6c <.text+0x1bac>
               	b	0x401ef0 <.text+0x1c30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4fb
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x505
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401e84 <.text+0x1bc4>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x401f68 <.text+0x1ca8>
               	b	0x401f0c <.text+0x1c4c>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401ef0 <.text+0x1c30>
               	b	0x401f6c <.text+0x1cac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x517
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x521
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401f00 <.text+0x1c40>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x401fe4 <.text+0x1d24>
               	b	0x401f88 <.text+0x1cc8>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401f6c <.text+0x1cac>
               	b	0x401fe8 <.text+0x1d28>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x52c
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x536
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401f7c <.text+0x1cbc>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x402060 <.text+0x1da0>
               	b	0x402004 <.text+0x1d44>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401fe8 <.text+0x1d28>
               	b	0x402064 <.text+0x1da4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x544
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x54e
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401ff8 <.text+0x1d38>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4020dc <.text+0x1e1c>
               	b	0x402080 <.text+0x1dc0>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x402064 <.text+0x1da4>
               	b	0x4020e0 <.text+0x1e20>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x55a
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x564
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x402074 <.text+0x1db4>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x402158 <.text+0x1e98>
               	b	0x4020fc <.text+0x1e3c>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4020e0 <.text+0x1e20>
               	b	0x40215c <.text+0x1e9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x570
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x57a
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4020f0 <.text+0x1e30>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4021d4 <.text+0x1f14>
               	b	0x402178 <.text+0x1eb8>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x40215c <.text+0x1e9c>
               	b	0x4021d8 <.text+0x1f18>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x586
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x590
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40216c <.text+0x1eac>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x402250 <.text+0x1f90>
               	b	0x4021f4 <.text+0x1f34>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4021d8 <.text+0x1f18>
               	b	0x402254 <.text+0x1f94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5a4
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ae
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4021e8 <.text+0x1f28>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4022fc <.text+0x203c>
               	b	0x4022a0 <.text+0x1fe0>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x402254 <.text+0x1f94>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ba
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5c4
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	0x402454 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x402264 <.text+0x1fa4>
