
integer_ops_exhaustive.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400408 <.text+0x148>
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
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x402438 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	b	0x400448 <.text+0x188>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x21, x17
               	cmp	x13, x12
               	cset	x11, hi
               	cmp	x11, #0x0
               	b.ne	0x4004dc <.text+0x21c>
               	b	0x400480 <.text+0x1c0>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400448 <.text+0x188>
               	b	0x4004e0 <.text+0x220>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x15a
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402444 <printf>
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
               	b	0x400474 <.text+0x1b4>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	cmp	x0, x23
               	cset	x22, lo
               	cmp	x22, #0x0
               	b.ne	0x400574 <.text+0x2b4>
               	b	0x400518 <.text+0x258>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4004e0 <.text+0x220>
               	b	0x400578 <.text+0x2b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x16d
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x177
               	mov	x22, x19
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x402444 <printf>
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
               	b	0x40050c <.text+0x24c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x21, x17
               	cmp	x0, x22
               	cset	x24, hs
               	cmp	x24, #0x0
               	b.ne	0x40060c <.text+0x34c>
               	b	0x4005b0 <.text+0x2f0>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400578 <.text+0x2b8>
               	b	0x400610 <.text+0x350>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x18a
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x194
               	mov	x24, x19
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x4005a4 <.text+0x2e4>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x20, x17
               	cmp	x0, x24
               	cset	x23, ls
               	cmp	x23, #0x0
               	b.ne	0x4006a4 <.text+0x3e4>
               	b	0x400648 <.text+0x388>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400610 <.text+0x350>
               	b	0x4006a8 <.text+0x3e8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b2
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402444 <printf>
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
               	b	0x40063c <.text+0x37c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x0, x23
               	cset	x22, ne
               	cmp	x22, #0x0
               	b.ne	0x40073c <.text+0x47c>
               	b	0x4006e0 <.text+0x420>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4006a8 <.text+0x3e8>
               	b	0x400740 <.text+0x480>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c6
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x402444 <printf>
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
               	b	0x4006d4 <.text+0x414>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x21, x17
               	cmp	x0, x22
               	cset	x24, eq
               	cmp	x24, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x4007f0 <.text+0x530>
               	b	0x400794 <.text+0x4d4>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400740 <.text+0x480>
               	mov	x24, #0xfffe            // =65534
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x25, #0x1               // =1
               	b	0x4007f4 <.text+0x534>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e4
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ee
               	mov	x22, x19
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x402444 <printf>
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
               	b	0x400774 <.text+0x4b4>
               	sxtw	x21, w24
               	sxtw	x20, w25
               	cmp	x21, x20
               	cset	x23, lt
               	cmp	x23, #0x0
               	b.ne	0x400878 <.text+0x5b8>
               	b	0x40081c <.text+0x55c>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4007f4 <.text+0x534>
               	b	0x40087c <.text+0x5bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x20c
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402444 <printf>
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
               	b	0x400810 <.text+0x550>
               	sxtw	x0, w25
               	sxtw	x23, w24
               	cmp	x0, x23
               	cset	x22, gt
               	cmp	x22, #0x0
               	b.ne	0x400900 <.text+0x640>
               	b	0x4008a4 <.text+0x5e4>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40087c <.text+0x5bc>
               	b	0x400904 <.text+0x644>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x217
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x221
               	mov	x22, x19
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x402444 <printf>
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
               	b	0x400898 <.text+0x5d8>
               	sxtw	x0, w24
               	sxtw	x22, w25
               	cmp	x0, x22
               	cset	x21, le
               	cmp	x21, #0x0
               	b.ne	0x400988 <.text+0x6c8>
               	b	0x40092c <.text+0x66c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400904 <.text+0x644>
               	b	0x40098c <.text+0x6cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22c
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x236
               	mov	x21, x19
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x400920 <.text+0x660>
               	sxtw	x0, w25
               	sxtw	x21, w24
               	cmp	x0, x21
               	cset	x23, ge
               	cmp	x23, #0x0
               	b.ne	0x400a24 <.text+0x764>
               	b	0x4009c8 <.text+0x708>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x40098c <.text+0x6cc>
               	mov	x21, #0xfffe            // =65534
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	b	0x400a28 <.text+0x768>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x242
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x24c
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402444 <printf>
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
               	b	0x4009a8 <.text+0x6e8>
               	cmp	x21, x20
               	cset	x25, hi
               	cmp	x25, #0x0
               	b.ne	0x400aa4 <.text+0x7e4>
               	b	0x400a48 <.text+0x788>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400a28 <.text+0x768>
               	b	0x400aa8 <.text+0x7e8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x258
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x262
               	mov	x25, x19
               	mov	x0, x23
               	mov	x1, x25
               	bl	0x402444 <printf>
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
               	b	0x400a3c <.text+0x77c>
               	cmp	x21, x20
               	cset	x0, hs
               	cmp	x0, #0x0
               	b.ne	0x400b24 <.text+0x864>
               	b	0x400ac8 <.text+0x808>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400aa8 <.text+0x7e8>
               	b	0x400b28 <.text+0x868>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x26f
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x279
               	mov	x24, x19
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x400abc <.text+0x7fc>
               	cmp	x20, x21
               	cset	x0, lo
               	cmp	x0, #0x0
               	b.ne	0x400bb8 <.text+0x8f8>
               	b	0x400b5c <.text+0x89c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400b28 <.text+0x868>
               	mov	x22, #0xfffe            // =65534
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x24, #0x1               // =1
               	b	0x400bbc <.text+0x8fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x287
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x291
               	mov	x25, x19
               	mov	x0, x23
               	mov	x1, x25
               	bl	0x402444 <printf>
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
               	b	0x400b3c <.text+0x87c>
               	cmp	x24, x22
               	cset	x20, gt
               	cmp	x20, #0x0
               	b.ne	0x400c38 <.text+0x978>
               	b	0x400bdc <.text+0x91c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400bbc <.text+0x8fc>
               	b	0x400c3c <.text+0x97c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x29e
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2a8
               	mov	x20, x19
               	mov	x0, x25
               	mov	x1, x20
               	bl	0x402444 <printf>
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
               	b	0x400bd0 <.text+0x910>
               	cmp	x22, #0x0
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	0x400cc0 <.text+0xa00>
               	b	0x400c64 <.text+0x9a4>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400c3c <.text+0x97c>
               	mov	x24, #0xfe              // =254
               	mov	x20, #0x1               // =1
               	b	0x400cc4 <.text+0xa04>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2b3
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2bd
               	mov	x21, x19
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x400c50 <.text+0x990>
               	mov	x17, #0xff              // =255
               	and	x22, x24, x17
               	mov	x17, #0xff              // =255
               	and	x23, x20, x17
               	cmp	x22, x23
               	cset	x25, gt
               	cmp	x25, #0x0
               	b.ne	0x400d50 <.text+0xa90>
               	b	0x400cf4 <.text+0xa34>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400cc4 <.text+0xa04>
               	b	0x400d54 <.text+0xa94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2c8
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d2
               	mov	x25, x19
               	mov	x0, x21
               	mov	x1, x25
               	bl	0x402444 <printf>
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
               	b	0x400ce8 <.text+0xa28>
               	mov	x17, #0xff              // =255
               	and	x0, x20, x17
               	mov	x17, #0xff              // =255
               	and	x25, x24, x17
               	cmp	x0, x25
               	cset	x21, lt
               	cmp	x21, #0x0
               	b.ne	0x400df4 <.text+0xb34>
               	b	0x400d98 <.text+0xad8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400d54 <.text+0xa94>
               	mov	x25, #0xfffe            // =65534
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x23, #0x1               // =1
               	b	0x400df8 <.text+0xb38>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2de
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x21, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x400d78 <.text+0xab8>
               	sxtb	x20, w25
               	sxtb	x24, w23
               	cmp	x20, x24
               	cset	x22, lt
               	cmp	x22, #0x0
               	b.ne	0x400e7c <.text+0xbbc>
               	b	0x400e20 <.text+0xb60>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400df8 <.text+0xb38>
               	b	0x400e80 <.text+0xbc0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f4
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2fe
               	mov	x22, x19
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x402444 <printf>
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
               	b	0x400e14 <.text+0xb54>
               	sxtb	x0, w23
               	sxtb	x22, w25
               	cmp	x0, x22
               	cset	x21, gt
               	cmp	x21, #0x0
               	b.ne	0x400f1c <.text+0xc5c>
               	b	0x400ec0 <.text+0xc00>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400e80 <.text+0xbc0>
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x68]
               	sub	x21, x29, #0x68
               	ldr	w0, [x21]
               	add	x23, x0, #0x5
               	str	w23, [x21]
               	b	0x400f20 <.text+0xc60>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x308
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x312
               	mov	x21, x19
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x400e9c <.text+0xbdc>
               	ldur	w23, [x29, #-0x68]
               	mov	x17, #0x69              // =105
               	eor	x0, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	cmp	x23, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400fc4 <.text+0xd04>
               	b	0x400f68 <.text+0xca8>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400f20 <.text+0xc60>
               	sub	x0, x29, #0x68
               	ldr	w24, [x0]
               	sub	x22, x24, #0xa
               	str	w22, [x0]
               	b	0x400fc8 <.text+0xd08>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x31c
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x326
               	mov	x24, x19
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x400f4c <.text+0xc8c>
               	ldur	w22, [x29, #-0x68]
               	mov	x17, #0x5f              // =95
               	eor	x24, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x24, x17
               	cmp	x22, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x40106c <.text+0xdac>
               	b	0x401010 <.text+0xd50>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400fc8 <.text+0xd08>
               	sub	x0, x29, #0x68
               	ldr	w24, [x0]
               	lsl	x21, x24, #1
               	str	w21, [x0]
               	b	0x401070 <.text+0xdb0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32f
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x339
               	mov	x24, x19
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x400ff4 <.text+0xd34>
               	ldur	w21, [x29, #-0x68]
               	mov	x17, #0xbe              // =190
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401118 <.text+0xe58>
               	b	0x4010bc <.text+0xdfc>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401070 <.text+0xdb0>
               	sub	x0, x29, #0x68
               	ldr	w24, [x0]
               	mov	x22, #0x5               // =5
               	udiv	x25, x24, x22
               	str	w25, [x0]
               	b	0x40111c <.text+0xe5c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x343
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x34d
               	mov	x24, x19
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x40109c <.text+0xddc>
               	ldur	w25, [x29, #-0x68]
               	mov	x17, #0x26              // =38
               	eor	x22, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x22, x17
               	cmp	x25, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x4011c8 <.text+0xf08>
               	b	0x40116c <.text+0xeac>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40111c <.text+0xe5c>
               	sub	x0, x29, #0x68
               	ldr	w22, [x0]
               	mov	x21, #0x7               // =7
               	udiv	x17, x22, x21
               	msub	x24, x17, x21, x22
               	str	w24, [x0]
               	b	0x4011cc <.text+0xf0c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x356
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x360
               	mov	x22, x19
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x402444 <printf>
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
               	b	0x401148 <.text+0xe88>
               	ldur	w24, [x29, #-0x68]
               	mov	x17, #0x3               // =3
               	eor	x21, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x21, x17
               	cmp	x24, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x401280 <.text+0xfc0>
               	b	0x401224 <.text+0xf64>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4011cc <.text+0xf0c>
               	mov	x0, #0x1                // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	sub	x0, x21, #0x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	b	0x401284 <.text+0xfc4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x369
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x373
               	mov	x21, x19
               	mov	x0, x25
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x4011f8 <.text+0xf38>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x40132c <.text+0x106c>
               	b	0x4012d0 <.text+0x1010>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401284 <.text+0xfc4>
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0x78]
               	sub	x25, x29, #0x78
               	ldr	x0, [x25]
               	add	x24, x0, #0x19f
               	str	x24, [x25]
               	b	0x401330 <.text+0x1070>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x37c
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x386
               	mov	x25, x19
               	mov	x0, x21
               	mov	x1, x25
               	bl	0x402444 <printf>
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
               	b	0x4012ac <.text+0xfec>
               	ldur	x24, [x29, #-0x78]
               	cmp	x24, #0x587
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4013c4 <.text+0x1104>
               	b	0x401368 <.text+0x10a8>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x401330 <.text+0x1070>
               	sub	x0, x29, #0x78
               	ldr	x23, [x0]
               	mov	x17, #0x3               // =3
               	mul	x22, x23, x17
               	str	x22, [x0]
               	b	0x4013c8 <.text+0x1108>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x394
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x39e
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x402444 <printf>
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
               	b	0x401348 <.text+0x1088>
               	ldur	x22, [x29, #-0x78]
               	mov	x17, #0x1095            // =4245
               	cmp	x22, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401460 <.text+0x11a0>
               	b	0x401404 <.text+0x1144>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4013c8 <.text+0x1108>
               	sub	x0, x29, #0x78
               	ldr	x23, [x0]
               	mov	x25, #0x5               // =5
               	udiv	x21, x23, x25
               	str	x21, [x0]
               	b	0x401464 <.text+0x11a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3a9
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3b3
               	mov	x23, x19
               	mov	x0, x25
               	mov	x1, x23
               	bl	0x402444 <printf>
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
               	b	0x4013e4 <.text+0x1124>
               	ldur	x21, [x29, #-0x78]
               	cmp	x21, #0x351
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x40153c <.text+0x127c>
               	b	0x4014e0 <.text+0x1220>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401464 <.text+0x11a4>
               	mov	x0, #0xff00             // =65280
               	movk	x0, #0xff00, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x21, x25, x17
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xf, lsl #16
               	orr	x24, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	eor	x22, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x20, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	b	0x401540 <.text+0x1280>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3bc
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3c6
               	mov	x25, x19
               	mov	x0, x22
               	mov	x1, x25
               	bl	0x402444 <printf>
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
               	b	0x40147c <.text+0x11bc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x21, x17
               	mov	x17, #0xf00             // =3840
               	movk	x17, #0xf00, lsl #16
               	eor	x10, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x10, x17
               	cmp	x20, #0x0
               	cset	x10, eq
               	cmp	x10, #0x0
               	b.ne	0x4015e0 <.text+0x1320>
               	b	0x401584 <.text+0x12c4>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401540 <.text+0x1280>
               	b	0x4015e4 <.text+0x1324>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3cf
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3d9
               	mov	x26, x19
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x402444 <printf>
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
               	b	0x401578 <.text+0x12b8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xff0f, lsl #16
               	cmp	x0, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401674 <.text+0x13b4>
               	b	0x401618 <.text+0x1358>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x4015e4 <.text+0x1324>
               	b	0x401678 <.text+0x13b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3df
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3e9
               	mov	x26, x19
               	mov	x0, x20
               	mov	x1, x26
               	bl	0x402444 <printf>
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
               	b	0x40160c <.text+0x134c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x22, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x26, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x26, x17
               	cmp	x0, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401718 <.text+0x1458>
               	b	0x4016bc <.text+0x13fc>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401678 <.text+0x13b8>
               	b	0x40171c <.text+0x145c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3ef
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3f9
               	mov	x26, x19
               	mov	x0, x21
               	mov	x1, x26
               	bl	0x402444 <printf>
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
               	b	0x4016b0 <.text+0x13f0>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x26, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x26, x17
               	cmp	x0, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x4017e0 <.text+0x1520>
               	b	0x401784 <.text+0x14c4>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x40171c <.text+0x145c>
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x0, x17
               	lsl	x0, x26, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x0, x17
               	b	0x4017e4 <.text+0x1524>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3ff
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x409
               	mov	x26, x19
               	mov	x0, x24
               	mov	x1, x26
               	bl	0x402444 <printf>
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
               	b	0x401754 <.text+0x1494>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x22, x17
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	eor	x23, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x4018a4 <.text+0x15e4>
               	b	0x401848 <.text+0x1588>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4017e4 <.text+0x1524>
               	mov	x0, #0x1                // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	lsl	x0, x23, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	b	0x4018a8 <.text+0x15e8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x40f
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x419
               	mov	x23, x19
               	mov	x0, x26
               	mov	x1, x23
               	bl	0x402444 <printf>
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
               	b	0x40181c <.text+0x155c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x401938 <.text+0x1678>
               	b	0x4018dc <.text+0x161c>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4018a8 <.text+0x15e8>
               	mov	x26, #0x1               // =1
               	b	0x40193c <.text+0x167c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x422
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x42c
               	mov	x22, x19
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x402444 <printf>
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
               	b	0x4018cc <.text+0x160c>
               	lsl	x22, x26, #63
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x22, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4019d4 <.text+0x1714>
               	b	0x401978 <.text+0x16b8>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x40193c <.text+0x167c>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x22, #0x1               // =1
               	b	0x4019d8 <.text+0x1718>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x436
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x440
               	mov	x24, x19
               	mov	x0, x27
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x401958 <.text+0x1698>
               	sxtw	x26, w23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x22, x17
               	cmp	x27, x26
               	cset	x21, hi
               	cmp	x21, #0x0
               	b.ne	0x401a70 <.text+0x17b0>
               	b	0x401a14 <.text+0x1754>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4019d8 <.text+0x1718>
               	b	0x401a74 <.text+0x17b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x44a
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x454
               	mov	x21, x19
               	mov	x0, x24
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x401a08 <.text+0x1748>
               	sxtw	x0, w23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x22, x17
               	sxtw	x21, w21
               	cmp	x0, x21
               	cset	x24, lt
               	cmp	x24, #0x0
               	b.ne	0x401b20 <.text+0x1860>
               	b	0x401ac4 <.text+0x1804>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401a74 <.text+0x17b4>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0xe0]
               	sub	x24, x29, #0xe0
               	ldr	w0, [x24]
               	add	x22, x0, #0x1
               	str	w22, [x24]
               	b	0x401b24 <.text+0x1864>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x460
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46a
               	mov	x24, x19
               	mov	x0, x27
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x401a9c <.text+0x17dc>
               	ldur	w22, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x22, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401bbc <.text+0x18fc>
               	b	0x401b60 <.text+0x18a0>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401b24 <.text+0x1864>
               	sub	x0, x29, #0xe0
               	ldr	w26, [x0]
               	add	x21, x26, #0x1
               	str	w21, [x0]
               	b	0x401bc0 <.text+0x1900>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x475
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x47f
               	mov	x26, x19
               	mov	x0, x21
               	mov	x1, x26
               	bl	0x402444 <printf>
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
               	b	0x401b44 <.text+0x1884>
               	ldur	w21, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x21, x17
               	cmp	x26, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x401c64 <.text+0x19a4>
               	b	0x401c08 <.text+0x1948>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401bc0 <.text+0x1900>
               	mov	x0, #0xfe               // =254
               	sturb	w0, [x29, #-0xe8]
               	sub	x21, x29, #0xe8
               	ldrb	w0, [x21]
               	add	x24, x0, #0x1
               	strb	w24, [x21]
               	b	0x401c68 <.text+0x19a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x48e
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x498
               	mov	x21, x19
               	mov	x0, x24
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x401be4 <.text+0x1924>
               	ldurb	w24, [x29, #-0xe8]
               	mov	x17, #0xff              // =255
               	eor	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	cmp	x24, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401d0c <.text+0x1a4c>
               	b	0x401cb0 <.text+0x19f0>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x401c68 <.text+0x19a8>
               	sub	x0, x29, #0xe8
               	ldrb	w22, [x0]
               	add	x26, x22, #0x1
               	strb	w26, [x0]
               	b	0x401d10 <.text+0x1a50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4aa
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4b4
               	mov	x22, x19
               	mov	x0, x26
               	mov	x1, x22
               	bl	0x402444 <printf>
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
               	b	0x401c94 <.text+0x19d4>
               	ldurb	w26, [x29, #-0xe8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x26, x17
               	cmp	x22, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401dc0 <.text+0x1b00>
               	b	0x401d64 <.text+0x1aa4>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401d10 <.text+0x1a50>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0xf0]
               	sub	x26, x29, #0xf0
               	ldr	x0, [x26]
               	add	x21, x0, #0x1
               	str	x21, [x26]
               	b	0x401dc4 <.text+0x1b04>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4c7
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4d1
               	mov	x26, x19
               	mov	x0, x21
               	mov	x1, x26
               	bl	0x402444 <printf>
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
               	b	0x401d34 <.text+0x1a74>
               	ldur	x21, [x29, #-0xf0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401e64 <.text+0x1ba4>
               	b	0x401e08 <.text+0x1b48>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401dc4 <.text+0x1b04>
               	sub	x0, x29, #0xf0
               	ldr	x24, [x0]
               	add	x22, x24, #0x1
               	str	x22, [x0]
               	b	0x401e68 <.text+0x1ba8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4e2
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4ec
               	mov	x24, x19
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x401dec <.text+0x1b2c>
               	ldur	x22, [x29, #-0xf0]
               	cmp	x22, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401ee8 <.text+0x1c28>
               	b	0x401e8c <.text+0x1bcc>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401e68 <.text+0x1ba8>
               	b	0x401eec <.text+0x1c2c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4fb
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x505
               	mov	x24, x19
               	mov	x0, x26
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x401e80 <.text+0x1bc0>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x401f64 <.text+0x1ca4>
               	b	0x401f08 <.text+0x1c48>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401eec <.text+0x1c2c>
               	b	0x401f68 <.text+0x1ca8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x517
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x521
               	mov	x21, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x401efc <.text+0x1c3c>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x401fe0 <.text+0x1d20>
               	b	0x401f84 <.text+0x1cc4>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401f68 <.text+0x1ca8>
               	b	0x401fe4 <.text+0x1d24>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x52c
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x536
               	mov	x24, x19
               	mov	x0, x26
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x401f78 <.text+0x1cb8>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x40205c <.text+0x1d9c>
               	b	0x402000 <.text+0x1d40>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401fe4 <.text+0x1d24>
               	b	0x402060 <.text+0x1da0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x544
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x54e
               	mov	x21, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x401ff4 <.text+0x1d34>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4020d8 <.text+0x1e18>
               	b	0x40207c <.text+0x1dbc>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x402060 <.text+0x1da0>
               	b	0x4020dc <.text+0x1e1c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x55a
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x564
               	mov	x24, x19
               	mov	x0, x26
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x402070 <.text+0x1db0>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x402154 <.text+0x1e94>
               	b	0x4020f8 <.text+0x1e38>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4020dc <.text+0x1e1c>
               	b	0x402158 <.text+0x1e98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x570
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x57a
               	mov	x21, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x4020ec <.text+0x1e2c>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4021d0 <.text+0x1f10>
               	b	0x402174 <.text+0x1eb4>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x402158 <.text+0x1e98>
               	b	0x4021d4 <.text+0x1f14>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x586
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x590
               	mov	x24, x19
               	mov	x0, x26
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x402168 <.text+0x1ea8>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x40224c <.text+0x1f8c>
               	b	0x4021f0 <.text+0x1f30>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4021d4 <.text+0x1f14>
               	b	0x402250 <.text+0x1f90>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5a4
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ae
               	mov	x21, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x402444 <printf>
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
               	b	0x4021e4 <.text+0x1f24>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4022f8 <.text+0x2038>
               	b	0x40229c <.text+0x1fdc>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x402250 <.text+0x1f90>
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
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5c4
               	mov	x24, x19
               	mov	x0, x26
               	mov	x1, x24
               	bl	0x402444 <printf>
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
               	b	0x402260 <.text+0x1fa0>
