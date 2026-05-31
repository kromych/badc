
c4.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x404a74 <.text+0x4614>
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
               	add	x19, x19, #0x138
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x4004ec <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x138
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
               	add	x19, x19, #0x150
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x156
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x15d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x406d18 <dlsym>
               	cbz	x0, 0x400574 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x138
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400574 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x138
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
               	sub	sp, sp, #0x190
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	b	0x4005e0 <.text+0x180>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x15, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x14, x19
               	ldr	x13, [x14]
               	ldrb	w14, [x13]
               	str	x14, [x15]
               	cbz	x14, 0x40063c <.text+0x1dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x13, x19
               	ldr	x14, [x13]
               	add	x14, x14, #0x1
               	str	x14, [x13]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x15, x19
               	ldr	x14, [x15]
               	cmp	x14, #0xa
               	b.ne	0x400690 <.text+0x230>
               	b	0x400674 <.text+0x214>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e8
               	mov	x15, x19
               	ldr	x14, [x15]
               	cbz	x14, 0x400714 <.text+0x2b4>
               	b	0x4006ac <.text+0x24c>
               	b	0x4005e0 <.text+0x180>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x23
               	b.ne	0x400824 <.text+0x3c4>
               	b	0x40081c <.text+0x3bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f8
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x14, x19
               	ldr	x21, [x14]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x12, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x190
               	mov	x23, x19
               	ldr	x10, [x23]
               	sub	x24, x12, x10
               	ldr	x25, [x23]
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	ldr	x0, [x22]
               	str	x0, [x23]
               	b	0x400730 <.text+0x2d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x1
               	str	x0, [x22]
               	b	0x40068c <.text+0x22c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x0, x19
               	ldr	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x22, x23
               	b.ge	0x4007bc <.text+0x35c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x201
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x207
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x25, x25, #0x8
               	str	x25, [x23]
               	ldr	x24, [x25]
               	mov	x17, #0x5               // =5
               	mul	x24, x24, x17
               	add	x22, x22, x24
               	mov	x0, x26
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	ldr	x0, [x23]
               	ldr	x23, [x0]
               	cmp	x23, #0x7
               	b.gt	0x400800 <.text+0x3a0>
               	b	0x4007c0 <.text+0x360>
               	b	0x400714 <.text+0x2b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2cb
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	ldr	x27, [x22]
               	mov	x0, x24
               	mov	x1, x27
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	b	0x4007fc <.text+0x39c>
               	b	0x400730 <.text+0x2d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d0
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	b	0x4007fc <.text+0x39c>
               	b	0x400848 <.text+0x3e8>
               	b	0x40068c <.text+0x22c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x61
               	cset	x22, ge
               	stur	x22, [x29, #-0x48]
               	cbz	x22, 0x400900 <.text+0x4a0>
               	b	0x4008e0 <.text+0x480>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldrb	w0, [x24]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	cbz	x0, 0x4008d4 <.text+0x474>
               	b	0x40089c <.text+0x43c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x1
               	str	x24, [x0]
               	b	0x400848 <.text+0x3e8>
               	b	0x400820 <.text+0x3c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	mov	x17, #0xa               // =10
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, ne
               	stur	x24, [x29, #-0x30]
               	b	0x4008d4 <.text+0x474>
               	ldur	x24, [x29, #-0x30]
               	cbz	x24, 0x400898 <.text+0x438>
               	b	0x40087c <.text+0x41c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x7a
               	cset	x22, le
               	stur	x22, [x29, #-0x48]
               	b	0x400900 <.text+0x4a0>
               	ldur	x22, [x29, #-0x48]
               	stur	x22, [x29, #-0x40]
               	cbnz	x22, 0x400930 <.text+0x4d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x41
               	cset	x22, ge
               	stur	x22, [x29, #-0x50]
               	cbz	x22, 0x400960 <.text+0x500>
               	b	0x400940 <.text+0x4e0>
               	ldur	x22, [x29, #-0x40]
               	stur	x22, [x29, #-0x38]
               	cbnz	x22, 0x40098c <.text+0x52c>
               	b	0x40096c <.text+0x50c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x5a
               	cset	x22, le
               	stur	x22, [x29, #-0x50]
               	b	0x400960 <.text+0x500>
               	ldur	x22, [x29, #-0x50]
               	stur	x22, [x29, #-0x40]
               	b	0x400930 <.text+0x4d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x5f
               	cset	x22, eq
               	stur	x22, [x29, #-0x38]
               	b	0x40098c <.text+0x52c>
               	ldur	x22, [x29, #-0x38]
               	cbz	x22, 0x4009b0 <.text+0x550>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x22, [x24]
               	sub	x22, x22, #0x1
               	b	0x4009d4 <.text+0x574>
               	b	0x400820 <.text+0x3c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x0, [x27]
               	cmp	x0, #0x30
               	cset	x0, ge
               	stur	x0, [x29, #-0x90]
               	cbz	x0, 0x400d8c <.text+0x92c>
               	b	0x400d6c <.text+0x90c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	cmp	x24, #0x61
               	cset	x24, ge
               	stur	x24, [x29, #-0x70]
               	cbz	x24, 0x400ab4 <.text+0x654>
               	b	0x400a90 <.text+0x630>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x17, #0x93              // =147
               	mul	x24, x24, x17
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x21, x25, #0x1
               	str	x21, [x23]
               	ldrb	w20, [x25]
               	add	x24, x24, x20
               	str	x24, [x0]
               	b	0x4009d4 <.text+0x574>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x20, [x24]
               	lsl	x20, x20, #6
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x25, [x0]
               	sub	x25, x25, x22
               	add	x20, x20, x25
               	str	x20, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x20, x19
               	ldr	x24, [x20]
               	str	x24, [x25]
               	b	0x400bd4 <.text+0x774>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldrb	w0, [x24]
               	cmp	x0, #0x7a
               	cset	x0, le
               	stur	x0, [x29, #-0x70]
               	b	0x400ab4 <.text+0x654>
               	ldur	x0, [x29, #-0x70]
               	stur	x0, [x29, #-0x68]
               	cbnz	x0, 0x400ae8 <.text+0x688>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	cmp	x24, #0x41
               	cset	x24, ge
               	stur	x24, [x29, #-0x78]
               	cbz	x24, 0x400b1c <.text+0x6bc>
               	b	0x400af8 <.text+0x698>
               	ldur	x0, [x29, #-0x68]
               	stur	x0, [x29, #-0x60]
               	cbnz	x0, 0x400b50 <.text+0x6f0>
               	b	0x400b28 <.text+0x6c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldrb	w0, [x24]
               	cmp	x0, #0x5a
               	cset	x0, le
               	stur	x0, [x29, #-0x78]
               	b	0x400b1c <.text+0x6bc>
               	ldur	x0, [x29, #-0x78]
               	stur	x0, [x29, #-0x68]
               	b	0x400ae8 <.text+0x688>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	cmp	x24, #0x30
               	cset	x24, ge
               	stur	x24, [x29, #-0x80]
               	cbz	x24, 0x400b84 <.text+0x724>
               	b	0x400b60 <.text+0x700>
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x58]
               	cbnz	x0, 0x400bc8 <.text+0x768>
               	b	0x400b90 <.text+0x730>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldrb	w0, [x24]
               	cmp	x0, #0x39
               	cset	x0, le
               	stur	x0, [x29, #-0x80]
               	b	0x400b84 <.text+0x724>
               	ldur	x0, [x29, #-0x80]
               	stur	x0, [x29, #-0x60]
               	b	0x400b50 <.text+0x6f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	mov	x17, #0x5f              // =95
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	stur	x24, [x29, #-0x58]
               	b	0x400bc8 <.text+0x768>
               	ldur	x24, [x29, #-0x58]
               	cbz	x24, 0x400a3c <.text+0x5dc>
               	b	0x4009fc <.text+0x59c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x20, [x24]
               	ldr	x24, [x20]
               	cbz	x24, 0x400c28 <.text+0x7c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x24, [x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x25, [x20]
               	add	x25, x25, #0x8
               	ldr	x20, [x25]
               	cmp	x24, x20
               	cset	x24, eq
               	stur	x24, [x29, #-0x88]
               	cbz	x24, 0x400cf0 <.text+0x890>
               	b	0x400ca0 <.text+0x840>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x10
               	str	x22, [x24]
               	ldr	x27, [x0]
               	add	x27, x27, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	str	x22, [x27]
               	ldr	x25, [x0]
               	mov	x0, #0x0                // =0
               	mov	x22, #0x85              // =133
               	str	x22, [x25]
               	str	x22, [x24]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x24, [x20]
               	add	x24, x24, #0x10
               	ldr	x27, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	sub	x25, x25, x22
               	mov	x0, x27
               	mov	x2, x25
               	mov	x1, x22
               	bl	0x406d30 <memcmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x0, [x29, #-0x88]
               	b	0x400cf0 <.text+0x890>
               	ldur	x0, [x29, #-0x88]
               	cbz	x0, 0x400d50 <.text+0x8f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x27, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x24, [x27]
               	str	x24, [x25]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x27, x19
               	ldr	x0, [x27]
               	add	x0, x0, #0x48
               	str	x0, [x27]
               	b	0x400bd4 <.text+0x774>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x0, [x27]
               	cmp	x0, #0x39
               	cset	x0, le
               	stur	x0, [x29, #-0x90]
               	b	0x400d8c <.text+0x92c>
               	ldur	x0, [x29, #-0x90]
               	cbz	x0, 0x400dc4 <.text+0x964>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	sub	x22, x22, #0x30
               	str	x22, [x27]
               	cbz	x22, 0x400e30 <.text+0x9d0>
               	b	0x400de0 <.text+0x980>
               	b	0x4009ac <.text+0x54c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x24, [x27]
               	cmp	x24, #0x2f
               	b.ne	0x4011e8 <.text+0xd88>
               	b	0x4011b0 <.text+0xd50>
               	b	0x400e6c <.text+0xa0c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x27, #0x80              // =128
               	str	x27, [x22]
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x21, [x22]
               	ldrb	w22, [x21]
               	mov	x17, #0x78              // =120
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	cset	x22, eq
               	stur	x22, [x29, #-0xa0]
               	cbnz	x22, 0x400f44 <.text+0xae4>
               	b	0x400f0c <.text+0xaac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x22, [x0]
               	ldrb	w0, [x22]
               	cmp	x0, #0x30
               	cset	x0, ge
               	stur	x0, [x29, #-0x98]
               	cbz	x0, 0x400f00 <.text+0xaa0>
               	b	0x400edc <.text+0xa7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x17, #0xa               // =10
               	mul	x22, x22, x17
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	add	x25, x24, #0x1
               	str	x25, [x27]
               	ldrb	w21, [x24]
               	add	x22, x22, x21
               	sub	x22, x22, #0x30
               	str	x22, [x0]
               	b	0x400e6c <.text+0xa0c>
               	b	0x400de4 <.text+0x984>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x0, [x22]
               	ldrb	w22, [x0]
               	cmp	x22, #0x39
               	cset	x22, le
               	stur	x22, [x29, #-0x98]
               	b	0x400f00 <.text+0xaa0>
               	ldur	x22, [x29, #-0x98]
               	cbz	x22, 0x400ed8 <.text+0xa78>
               	b	0x400e94 <.text+0xa34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x22, [x21]
               	ldrb	w21, [x22]
               	mov	x17, #0x58              // =88
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	cset	x21, eq
               	stur	x21, [x29, #-0xa0]
               	b	0x400f44 <.text+0xae4>
               	ldur	x21, [x29, #-0xa0]
               	cbz	x21, 0x400f54 <.text+0xaf4>
               	b	0x400f58 <.text+0xaf8>
               	b	0x400de4 <.text+0x984>
               	b	0x401114 <.text+0xcb4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x1
               	str	x0, [x21]
               	ldrb	w24, [x0]
               	str	x24, [x22]
               	stur	x24, [x29, #-0xa8]
               	cbz	x24, 0x400ff8 <.text+0xb98>
               	b	0x400fd4 <.text+0xb74>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x24, [x0]
               	lsl	x24, x24, #4
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x21, [x22]
               	mov	x17, #0xf               // =15
               	and	x21, x21, x17
               	add	x24, x24, x21
               	ldr	x21, [x22]
               	cmp	x21, #0x41
               	b.lt	0x4010f8 <.text+0xc98>
               	b	0x4010ec <.text+0xc8c>
               	b	0x400f50 <.text+0xaf0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x30
               	cset	x24, ge
               	stur	x24, [x29, #-0xc0]
               	cbz	x24, 0x401024 <.text+0xbc4>
               	b	0x401004 <.text+0xba4>
               	ldur	x24, [x29, #-0xa8]
               	cbz	x24, 0x400fd0 <.text+0xb70>
               	b	0x400f90 <.text+0xb30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x39
               	cset	x24, le
               	stur	x24, [x29, #-0xc0]
               	b	0x401024 <.text+0xbc4>
               	ldur	x24, [x29, #-0xc0]
               	stur	x24, [x29, #-0xb8]
               	cbnz	x24, 0x401054 <.text+0xbf4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x61
               	cset	x24, ge
               	stur	x24, [x29, #-0xc8]
               	cbz	x24, 0x401084 <.text+0xc24>
               	b	0x401064 <.text+0xc04>
               	ldur	x24, [x29, #-0xb8]
               	stur	x24, [x29, #-0xb0]
               	cbnz	x24, 0x4010b4 <.text+0xc54>
               	b	0x401090 <.text+0xc30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x66
               	cset	x24, le
               	stur	x24, [x29, #-0xc8]
               	b	0x401084 <.text+0xc24>
               	ldur	x24, [x29, #-0xc8]
               	stur	x24, [x29, #-0xb8]
               	b	0x401054 <.text+0xbf4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x41
               	cset	x24, ge
               	stur	x24, [x29, #-0xd0]
               	cbz	x24, 0x4010e0 <.text+0xc80>
               	b	0x4010c0 <.text+0xc60>
               	ldur	x24, [x29, #-0xb0]
               	stur	x24, [x29, #-0xa8]
               	b	0x400ff8 <.text+0xb98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x46
               	cset	x24, le
               	stur	x24, [x29, #-0xd0]
               	b	0x4010e0 <.text+0xc80>
               	ldur	x24, [x29, #-0xd0]
               	stur	x24, [x29, #-0xb0]
               	b	0x4010b4 <.text+0xc54>
               	mov	x22, #0x9               // =9
               	stur	x22, [x29, #-0xd8]
               	b	0x401104 <.text+0xca4>
               	mov	x22, #0x0               // =0
               	stur	x22, [x29, #-0xd8]
               	b	0x401104 <.text+0xca4>
               	ldur	x22, [x29, #-0xd8]
               	add	x24, x24, x22
               	str	x24, [x0]
               	b	0x400f58 <.text+0xaf8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x22, [x24]
               	ldrb	w24, [x22]
               	cmp	x24, #0x30
               	cset	x24, ge
               	stur	x24, [x29, #-0xe0]
               	cbz	x24, 0x4011a4 <.text+0xd44>
               	b	0x401180 <.text+0xd20>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x24, x19
               	ldr	x22, [x24]
               	lsl	x22, x22, #3
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x25, x21, #0x1
               	str	x25, [x0]
               	ldrb	w27, [x21]
               	add	x22, x22, x27
               	sub	x22, x22, #0x30
               	str	x22, [x24]
               	b	0x401114 <.text+0xcb4>
               	b	0x400f50 <.text+0xaf0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x24, [x22]
               	ldrb	w22, [x24]
               	cmp	x22, #0x37
               	cset	x22, le
               	stur	x22, [x29, #-0xe0]
               	b	0x4011a4 <.text+0xd44>
               	ldur	x22, [x29, #-0xe0]
               	cbz	x22, 0x40117c <.text+0xd1c>
               	b	0x40113c <.text+0xcdc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	ldrb	w27, [x24]
               	mov	x17, #0x2f              // =47
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	0x40122c <.text+0xdcc>
               	b	0x40120c <.text+0xdac>
               	b	0x400dc0 <.text+0x960>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x27, [x24]
               	cmp	x27, #0x27
               	cset	x27, eq
               	stur	x27, [x29, #-0xf0]
               	cbnz	x27, 0x401330 <.text+0xed0>
               	b	0x401310 <.text+0xeb0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x27, [x24]
               	add	x27, x27, #0x1
               	str	x27, [x24]
               	b	0x401278 <.text+0xe18>
               	b	0x4011e4 <.text+0xd84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x24, #0xa0              // =160
               	str	x24, [x22]
               	mov	x27, #0x0               // =0
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x22, [x27]
               	ldrb	w27, [x22]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	cset	x27, ne
               	stur	x27, [x29, #-0xe8]
               	cbz	x27, 0x401304 <.text+0xea4>
               	b	0x4012cc <.text+0xe6c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x22, [x27]
               	add	x22, x22, #0x1
               	str	x22, [x27]
               	b	0x401278 <.text+0xe18>
               	b	0x401228 <.text+0xdc8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x27, [x22]
               	ldrb	w22, [x27]
               	mov	x17, #0xa               // =10
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xe8]
               	b	0x401304 <.text+0xea4>
               	ldur	x22, [x29, #-0xe8]
               	cbz	x22, 0x4012c8 <.text+0xe68>
               	b	0x4012ac <.text+0xe4c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x27, [x24]
               	cmp	x27, #0x22
               	cset	x27, eq
               	stur	x27, [x29, #-0xf0]
               	b	0x401330 <.text+0xed0>
               	ldur	x27, [x29, #-0xf0]
               	cbz	x27, 0x401350 <.text+0xef0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x24, x19
               	ldr	x27, [x24]
               	b	0x40136c <.text+0xf0c>
               	b	0x4011e4 <.text+0xd84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x3d
               	b.ne	0x40158c <.text+0x112c>
               	b	0x401554 <.text+0x10f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x22, [x24]
               	ldrb	w24, [x22]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, ne
               	stur	x24, [x29, #-0xf8]
               	cbz	x24, 0x401440 <.text+0xfe0>
               	b	0x40140c <.text+0xfac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x25, x24, #0x1
               	str	x25, [x22]
               	ldrb	w0, [x24]
               	str	x0, [x21]
               	cmp	x0, #0x5c
               	b.ne	0x401484 <.text+0x1024>
               	b	0x40144c <.text+0xfec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x25, [x21]
               	add	x25, x25, #0x1
               	str	x25, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x22
               	b.ne	0x40153c <.text+0x10dc>
               	b	0x4014f0 <.text+0x1090>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x24, [x22]
               	ldrb	w22, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x22, x21
               	cset	x22, ne
               	stur	x22, [x29, #-0xf8]
               	b	0x401440 <.text+0xfe0>
               	ldur	x22, [x29, #-0xf8]
               	cbz	x22, 0x4013d8 <.text+0xf78>
               	b	0x4013a0 <.text+0xf40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x25, x21, #0x1
               	str	x25, [x0]
               	ldrb	w22, [x21]
               	str	x22, [x24]
               	cmp	x22, #0x6e
               	b.ne	0x4014b8 <.text+0x1058>
               	b	0x4014a0 <.text+0x1040>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x22
               	b.ne	0x4014ec <.text+0x108c>
               	b	0x4014bc <.text+0x105c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	mov	x22, #0xa               // =10
               	str	x22, [x21]
               	b	0x4014b8 <.text+0x1058>
               	b	0x401484 <.text+0x1024>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x21, x24, #0x1
               	str	x21, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x25, x19
               	ldr	x21, [x25]
               	strb	w21, [x24]
               	b	0x4014ec <.text+0x108c>
               	b	0x40136c <.text+0xf0c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x24, x19
               	str	x27, [x24]
               	b	0x401504 <.text+0x10a4>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x25, #0x80              // =128
               	str	x25, [x24]
               	b	0x401504 <.text+0x10a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x25, [x27]
               	ldrb	w27, [x25]
               	mov	x17, #0x3d              // =61
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	0x401610 <.text+0x11b0>
               	b	0x4015a8 <.text+0x1148>
               	b	0x40134c <.text+0xeec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x2b
               	b.ne	0x401660 <.text+0x1200>
               	b	0x401628 <.text+0x11c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x27, [x25]
               	add	x27, x27, #0x1
               	str	x27, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x27, #0x95              // =149
               	str	x27, [x24]
               	b	0x4015d8 <.text+0x1178>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x8e              // =142
               	str	x25, [x27]
               	b	0x4015d8 <.text+0x1178>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	ldrb	w24, [x25]
               	mov	x17, #0x2b              // =43
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	b.ne	0x4016e4 <.text+0x1284>
               	b	0x40167c <.text+0x121c>
               	b	0x401588 <.text+0x1128>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x2d
               	b.ne	0x401734 <.text+0x12d4>
               	b	0x4016fc <.text+0x129c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x1
               	str	x24, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x24, #0xa2              // =162
               	str	x24, [x27]
               	b	0x4016ac <.text+0x124c>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x25, #0x9d              // =157
               	str	x25, [x24]
               	b	0x4016ac <.text+0x124c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x25, [x27]
               	ldrb	w27, [x25]
               	mov	x17, #0x2d              // =45
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	0x4017b8 <.text+0x1358>
               	b	0x401750 <.text+0x12f0>
               	b	0x40165c <.text+0x11fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x21
               	b.ne	0x401808 <.text+0x13a8>
               	b	0x4017d0 <.text+0x1370>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x27, [x25]
               	add	x27, x27, #0x1
               	str	x27, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x27, #0xa3              // =163
               	str	x27, [x24]
               	b	0x401780 <.text+0x1320>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x9e              // =158
               	str	x25, [x27]
               	b	0x401780 <.text+0x1320>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	ldrb	w24, [x25]
               	mov	x17, #0x3d              // =61
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	b.ne	0x401854 <.text+0x13f4>
               	b	0x401824 <.text+0x13c4>
               	b	0x401730 <.text+0x12d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x3c
               	b.ne	0x4018c4 <.text+0x1464>
               	b	0x40188c <.text+0x142c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x1
               	str	x24, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x24, #0x96              // =150
               	str	x24, [x27]
               	b	0x401854 <.text+0x13f4>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	ldrb	w25, [x24]
               	mov	x17, #0x3d              // =61
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	b.ne	0x401948 <.text+0x14e8>
               	b	0x4018e0 <.text+0x1480>
               	b	0x401804 <.text+0x13a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x24, [x27]
               	cmp	x24, #0x3e
               	b.ne	0x4019fc <.text+0x159c>
               	b	0x4019c4 <.text+0x1564>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x1
               	str	x25, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x99              // =153
               	str	x25, [x27]
               	b	0x401910 <.text+0x14b0>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	ldrb	w25, [x24]
               	mov	x17, #0x3c              // =60
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	b.ne	0x4019ac <.text+0x154c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x1
               	str	x25, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x9b              // =155
               	str	x25, [x27]
               	b	0x4019a8 <.text+0x1548>
               	b	0x401910 <.text+0x14b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x24, #0x97              // =151
               	str	x24, [x25]
               	b	0x4019a8 <.text+0x1548>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	ldrb	w27, [x24]
               	mov	x17, #0x3d              // =61
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	0x401a80 <.text+0x1620>
               	b	0x401a18 <.text+0x15b8>
               	b	0x4018c0 <.text+0x1460>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x7c
               	b.ne	0x401b34 <.text+0x16d4>
               	b	0x401afc <.text+0x169c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x27, [x24]
               	add	x27, x27, #0x1
               	str	x27, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x27, #0x9a              // =154
               	str	x27, [x25]
               	b	0x401a48 <.text+0x15e8>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	ldrb	w27, [x24]
               	mov	x17, #0x3e              // =62
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	0x401ae4 <.text+0x1684>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x27, [x24]
               	add	x27, x27, #0x1
               	str	x27, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x27, #0x9c              // =156
               	str	x27, [x25]
               	b	0x401ae0 <.text+0x1680>
               	b	0x401a48 <.text+0x15e8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x24, #0x98              // =152
               	str	x24, [x27]
               	b	0x401ae0 <.text+0x1680>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	ldrb	w25, [x24]
               	mov	x17, #0x7c              // =124
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	b.ne	0x401bb8 <.text+0x1758>
               	b	0x401b50 <.text+0x16f0>
               	b	0x4019f8 <.text+0x1598>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x24, [x27]
               	cmp	x24, #0x26
               	b.ne	0x401c08 <.text+0x17a8>
               	b	0x401bd0 <.text+0x1770>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x1
               	str	x25, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x90              // =144
               	str	x25, [x27]
               	b	0x401b80 <.text+0x1720>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x24, #0x92              // =146
               	str	x24, [x25]
               	b	0x401b80 <.text+0x1720>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	ldrb	w27, [x24]
               	mov	x17, #0x26              // =38
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	0x401c8c <.text+0x182c>
               	b	0x401c24 <.text+0x17c4>
               	b	0x401b30 <.text+0x16d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x5e
               	b.ne	0x401cf4 <.text+0x1894>
               	b	0x401ca4 <.text+0x1844>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x27, [x24]
               	add	x27, x27, #0x1
               	str	x27, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x27, #0x91              // =145
               	str	x27, [x25]
               	b	0x401c54 <.text+0x17f4>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x24, #0x94              // =148
               	str	x24, [x27]
               	b	0x401c54 <.text+0x17f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x24, #0x93              // =147
               	str	x24, [x25]
               	mov	x27, #0x0               // =0
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401c04 <.text+0x17a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x27, [x24]
               	cmp	x27, #0x25
               	b.ne	0x401d5c <.text+0x18fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x27, #0xa1              // =161
               	str	x27, [x24]
               	mov	x25, #0x0               // =0
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401cf0 <.text+0x1890>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x2a
               	b.ne	0x401dc4 <.text+0x1964>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x9f              // =159
               	str	x25, [x27]
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401d58 <.text+0x18f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x5b
               	b.ne	0x401e2c <.text+0x19cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x24, #0xa4              // =164
               	str	x24, [x25]
               	mov	x27, #0x0               // =0
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401dc0 <.text+0x1960>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x27, [x24]
               	cmp	x27, #0x3f
               	b.ne	0x401e94 <.text+0x1a34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x27, #0x8f              // =143
               	str	x27, [x24]
               	mov	x25, #0x0               // =0
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401e28 <.text+0x19c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x7e
               	cset	x25, eq
               	sub	x17, x29, #0x138
               	str	x25, [x17]
               	cbnz	x25, 0x401edc <.text+0x1a7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x3b
               	cset	x25, eq
               	sub	x17, x29, #0x138
               	str	x25, [x17]
               	b	0x401edc <.text+0x1a7c>
               	sub	x16, x29, #0x138
               	ldr	x25, [x16]
               	sub	x17, x29, #0x130
               	str	x25, [x17]
               	cbnz	x25, 0x401f14 <.text+0x1ab4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x7b
               	cset	x25, eq
               	sub	x17, x29, #0x130
               	str	x25, [x17]
               	b	0x401f14 <.text+0x1ab4>
               	sub	x16, x29, #0x130
               	ldr	x25, [x16]
               	sub	x17, x29, #0x128
               	str	x25, [x17]
               	cbnz	x25, 0x401f4c <.text+0x1aec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x7d
               	cset	x25, eq
               	sub	x17, x29, #0x128
               	str	x25, [x17]
               	b	0x401f4c <.text+0x1aec>
               	sub	x16, x29, #0x128
               	ldr	x25, [x16]
               	sub	x17, x29, #0x120
               	str	x25, [x17]
               	cbnz	x25, 0x401f84 <.text+0x1b24>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x28
               	cset	x25, eq
               	sub	x17, x29, #0x120
               	str	x25, [x17]
               	b	0x401f84 <.text+0x1b24>
               	sub	x16, x29, #0x120
               	ldr	x25, [x16]
               	sub	x17, x29, #0x118
               	str	x25, [x17]
               	cbnz	x25, 0x401fbc <.text+0x1b5c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x29
               	cset	x25, eq
               	sub	x17, x29, #0x118
               	str	x25, [x17]
               	b	0x401fbc <.text+0x1b5c>
               	sub	x16, x29, #0x118
               	ldr	x25, [x16]
               	sub	x17, x29, #0x110
               	str	x25, [x17]
               	cbnz	x25, 0x401ff4 <.text+0x1b94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x5d
               	cset	x25, eq
               	sub	x17, x29, #0x110
               	str	x25, [x17]
               	b	0x401ff4 <.text+0x1b94>
               	sub	x16, x29, #0x110
               	ldr	x25, [x16]
               	sub	x17, x29, #0x108
               	str	x25, [x17]
               	cbnz	x25, 0x40202c <.text+0x1bcc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x2c
               	cset	x25, eq
               	sub	x17, x29, #0x108
               	str	x25, [x17]
               	b	0x40202c <.text+0x1bcc>
               	sub	x16, x29, #0x108
               	ldr	x25, [x16]
               	stur	x25, [x29, #-0x100]
               	cbnz	x25, 0x40205c <.text+0x1bfc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x3a
               	cset	x25, eq
               	stur	x25, [x29, #-0x100]
               	b	0x40205c <.text+0x1bfc>
               	ldur	x25, [x29, #-0x100]
               	cbz	x25, 0x40209c <.text+0x1c3c>
               	mov	x27, #0x0               // =0
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401e90 <.text+0x1a30>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x14, x19
               	ldr	x13, [x14]
               	cmp	x13, #0x0
               	b.ne	0x402138 <.text+0x1cd8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d2
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x13, x19
               	ldr	x22, [x13]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x402134 <.text+0x1cd4>
               	b	0x403238 <.text+0x2dd8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x80
               	b.ne	0x4021ac <.text+0x1d4c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	ldr	x11, [x23]
               	add	x11, x11, #0x8
               	str	x11, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x23, [x0]
               	str	x23, [x11]
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x22, [x0]
               	b	0x4021a8 <.text+0x1d48>
               	b	0x402134 <.text+0x1cd4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x22
               	b.ne	0x402210 <.text+0x1db0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x23]
               	ldr	x11, [x0]
               	add	x11, x11, #0x8
               	str	x11, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x22, x19
               	ldr	x0, [x22]
               	str	x0, [x11]
               	bl	0x4005ac <.text+0x14c>
               	b	0x40222c <.text+0x1dcc>
               	b	0x4021a8 <.text+0x1d48>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x8c
               	b.ne	0x4022b4 <.text+0x1e54>
               	b	0x402290 <.text+0x1e30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x22
               	b.ne	0x40224c <.text+0x1dec>
               	bl	0x4005ac <.text+0x14c>
               	b	0x40222c <.text+0x1dcc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	str	x0, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x11, x19
               	mov	x0, #0x2                // =2
               	str	x0, [x11]
               	b	0x40220c <.text+0x1dac>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x28
               	b.ne	0x402308 <.text+0x1ea8>
               	b	0x4022d0 <.text+0x1e70>
               	b	0x40220c <.text+0x1dac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x85
               	b.ne	0x4024f4 <.text+0x2094>
               	b	0x4024bc <.text+0x205c>
               	bl	0x4005ac <.text+0x14c>
               	b	0x4022d8 <.text+0x1e78>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x8a
               	b.ne	0x402360 <.text+0x1f00>
               	b	0x402354 <.text+0x1ef4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f4
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x4022d8 <.text+0x1e78>
               	bl	0x4005ac <.text+0x14c>
               	b	0x40235c <.text+0x1efc>
               	b	0x402398 <.text+0x1f38>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x0, [x21]
               	cmp	x0, #0x86
               	b.ne	0x402394 <.text+0x1f34>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x22, #0x0               // =0
               	str	x22, [x0]
               	b	0x402394 <.text+0x1f34>
               	b	0x40235c <.text+0x1efc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x9f
               	b.ne	0x4023d0 <.text+0x1f70>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x2
               	str	x24, [x0]
               	b	0x402398 <.text+0x1f38>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x29
               	b.ne	0x402438 <.text+0x1fd8>
               	bl	0x4005ac <.text+0x14c>
               	b	0x4023f0 <.text+0x1f90>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x21, #0x1               // =1
               	str	x21, [x0]
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldr	x24, [x21]
               	cmp	x24, #0x0
               	b.ne	0x402490 <.text+0x2030>
               	b	0x402484 <.text+0x2024>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x317
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x4023f0 <.text+0x1f90>
               	mov	x21, #0x1               // =1
               	stur	x21, [x29, #-0x30]
               	b	0x40249c <.text+0x203c>
               	mov	x21, #0x8               // =8
               	stur	x21, [x29, #-0x30]
               	b	0x40249c <.text+0x203c>
               	ldur	x21, [x29, #-0x30]
               	str	x21, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x24]
               	b	0x4022b0 <.text+0x1e50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x21, x19
               	ldr	x23, [x21]
               	stur	x23, [x29, #-0x10]
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x28
               	b.ne	0x402524 <.text+0x20c4>
               	b	0x402510 <.text+0x20b0>
               	b	0x4022b0 <.text+0x1e50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, #0x28
               	b.ne	0x4028fc <.text+0x249c>
               	b	0x4028d0 <.text+0x2470>
               	bl	0x4005ac <.text+0x14c>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	0x40253c <.text+0x20dc>
               	b	0x4024f0 <.text+0x2090>
               	ldur	x24, [x29, #-0x10]
               	add	x24, x24, #0x18
               	ldr	x0, [x24]
               	cmp	x0, #0x80
               	b.ne	0x402760 <.text+0x2300>
               	b	0x40270c <.text+0x22ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x29
               	b.eq	0x4025ac <.text+0x214c>
               	mov	x22, #0x8e              // =142
               	mov	x0, x22
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x24, #0xd               // =13
               	str	x24, [x22]
               	sub	x0, x29, #0x8
               	ldr	x24, [x0]
               	add	x24, x24, #0x1
               	str	x24, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x2c
               	b.ne	0x4025d4 <.text+0x2174>
               	b	0x4025c8 <.text+0x2168>
               	bl	0x4005ac <.text+0x14c>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x23, [x0]
               	cmp	x23, #0x82
               	b.ne	0x402610 <.text+0x21b0>
               	b	0x4025d8 <.text+0x2178>
               	bl	0x4005ac <.text+0x14c>
               	mov	x23, x0
               	b	0x4025d4 <.text+0x2174>
               	b	0x40253c <.text+0x20dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	ldur	x24, [x29, #-0x10]
               	add	x24, x24, #0x28
               	ldr	x0, [x24]
               	str	x0, [x23]
               	b	0x402604 <.text+0x21a4>
               	ldur	x23, [x29, #-0x8]
               	cbz	x23, 0x4026ec <.text+0x228c>
               	b	0x4026b4 <.text+0x2254>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x24, [x0]
               	cmp	x24, #0x81
               	b.ne	0x402668 <.text+0x2208>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x23, #0x3               // =3
               	str	x23, [x24]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x28
               	ldr	x0, [x23]
               	str	x0, [x21]
               	b	0x402664 <.text+0x2204>
               	b	0x402604 <.text+0x21a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x33b
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x0, x22
               	mov	x1, x25
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x402664 <.text+0x2204>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x7               // =7
               	str	x22, [x23]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x24]
               	b	0x4026ec <.text+0x228c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x20
               	ldr	x24, [x0]
               	str	x24, [x22]
               	b	0x402520 <.text+0x20c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x28
               	ldr	x24, [x0]
               	str	x24, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x22, [x0]
               	b	0x40275c <.text+0x22fc>
               	b	0x402520 <.text+0x20c0>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x24, [x0]
               	cmp	x24, #0x84
               	b.ne	0x402808 <.text+0x23a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x22, #0x0               // =0
               	str	x22, [x24]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x22, x19
               	ldr	x0, [x22]
               	ldur	x22, [x29, #-0x10]
               	add	x22, x22, #0x28
               	ldr	x24, [x22]
               	sub	x0, x0, x24
               	str	x0, [x23]
               	b	0x4027c8 <.text+0x2368>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x20
               	ldr	x24, [x23]
               	str	x24, [x25]
               	cmp	x24, #0x0
               	b.ne	0x4028b8 <.text+0x2458>
               	b	0x4028ac <.text+0x244c>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x24, [x0]
               	cmp	x24, #0x83
               	b.ne	0x402860 <.text+0x2400>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x24]
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x28
               	ldr	x0, [x23]
               	str	x0, [x22]
               	b	0x40285c <.text+0x23fc>
               	b	0x4027c8 <.text+0x2368>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x352
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x21, [x23]
               	mov	x0, x25
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x40285c <.text+0x23fc>
               	mov	x23, #0xa               // =10
               	stur	x23, [x29, #-0x38]
               	b	0x4028c4 <.text+0x2464>
               	mov	x23, #0x9               // =9
               	stur	x23, [x29, #-0x38]
               	b	0x4028c4 <.text+0x2464>
               	ldur	x23, [x29, #-0x38]
               	str	x23, [x0]
               	b	0x40275c <.text+0x22fc>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x8a
               	cset	x24, eq
               	stur	x24, [x29, #-0x40]
               	cbnz	x24, 0x402938 <.text+0x24d8>
               	b	0x402918 <.text+0x24b8>
               	b	0x4024f0 <.text+0x2090>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x9f
               	b.ne	0x402af4 <.text+0x2694>
               	b	0x402ac4 <.text+0x2664>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x86
               	cset	x24, eq
               	stur	x24, [x29, #-0x40]
               	b	0x402938 <.text+0x24d8>
               	ldur	x24, [x29, #-0x40]
               	cbz	x24, 0x402960 <.text+0x2500>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x8a
               	b.ne	0x402994 <.text+0x2534>
               	b	0x402988 <.text+0x2528>
               	b	0x4028f8 <.text+0x2498>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x29
               	b.ne	0x402a78 <.text+0x2618>
               	b	0x402a6c <.text+0x260c>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x48]
               	b	0x4029a0 <.text+0x2540>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x48]
               	b	0x4029a0 <.text+0x2540>
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x8]
               	bl	0x4005ac <.text+0x14c>
               	b	0x4029b0 <.text+0x2550>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x9f
               	b.ne	0x4029dc <.text+0x257c>
               	bl	0x4005ac <.text+0x14c>
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x8]
               	b	0x4029b0 <.text+0x2550>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x29
               	b.ne	0x402a20 <.text+0x25c0>
               	bl	0x4005ac <.text+0x14c>
               	b	0x4029fc <.text+0x259c>
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x21, [x29, #-0x8]
               	str	x21, [x0]
               	b	0x40295c <.text+0x24fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x36a
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x24
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x4029fc <.text+0x259c>
               	bl	0x4005ac <.text+0x14c>
               	b	0x402a74 <.text+0x2614>
               	b	0x40295c <.text+0x24fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x378
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x402a74 <.text+0x2614>
               	bl	0x4005ac <.text+0x14c>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x1
               	b.le	0x402b60 <.text+0x2700>
               	b	0x402b10 <.text+0x26b0>
               	b	0x4028f8 <.text+0x2498>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x21, [x23]
               	cmp	x21, #0x94
               	b.ne	0x402c0c <.text+0x27ac>
               	b	0x402bd0 <.text+0x2770>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x24, [x0]
               	sub	x24, x24, #0x2
               	str	x24, [x0]
               	b	0x402b2c <.text+0x26cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x21, [x23]
               	cmp	x21, #0x0
               	b.ne	0x402bb8 <.text+0x2758>
               	b	0x402bac <.text+0x274c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x392
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x24, [x21]
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x402b2c <.text+0x26cc>
               	mov	x23, #0xa               // =10
               	stur	x23, [x29, #-0x50]
               	b	0x402bc4 <.text+0x2764>
               	mov	x23, #0x9               // =9
               	stur	x23, [x29, #-0x50]
               	b	0x402bc4 <.text+0x2764>
               	ldur	x23, [x29, #-0x50]
               	str	x23, [x0]
               	b	0x402af0 <.text+0x2690>
               	bl	0x4005ac <.text+0x14c>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldr	x0, [x24]
               	cmp	x0, #0xa
               	cset	x0, eq
               	stur	x0, [x29, #-0x58]
               	cbnz	x0, 0x402c4c <.text+0x27ec>
               	b	0x402c28 <.text+0x27c8>
               	b	0x402af0 <.text+0x2690>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x21
               	b.ne	0x402d6c <.text+0x290c>
               	b	0x402ce8 <.text+0x2888>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldr	x24, [x0]
               	cmp	x24, #0x9
               	cset	x24, eq
               	stur	x24, [x29, #-0x58]
               	b	0x402c4c <.text+0x27ec>
               	ldur	x24, [x29, #-0x58]
               	cbz	x24, 0x402c9c <.text+0x283c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x24, x17
               	str	x24, [x0]
               	b	0x402c80 <.text+0x2820>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x2
               	str	x0, [x23]
               	b	0x402c08 <.text+0x27a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3a7
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x24, [x23]
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x402c80 <.text+0x2820>
               	bl	0x4005ac <.text+0x14c>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	ldr	x25, [x0]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x25]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x25, #0x0               // =0
               	str	x25, [x24]
               	ldr	x10, [x0]
               	add	x10, x10, #0x8
               	str	x10, [x0]
               	mov	x25, #0x11              // =17
               	str	x25, [x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x23, [x0]
               	b	0x402d68 <.text+0x2908>
               	b	0x402c08 <.text+0x27a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x7e
               	b.ne	0x402e14 <.text+0x29b4>
               	bl	0x4005ac <.text+0x14c>
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x23, #0xd               // =13
               	str	x23, [x21]
               	ldr	x10, [x0]
               	add	x10, x10, #0x8
               	str	x10, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x10]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x10, #0xffff            // =65535
               	movk	x10, #0xffff, lsl #16
               	movk	x10, #0xffff, lsl #32
               	movk	x10, #0xffff, lsl #48
               	str	x10, [x21]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x10, #0xf               // =15
               	str	x10, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x23, [x0]
               	b	0x402e10 <.text+0x29b0>
               	b	0x402d68 <.text+0x2908>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x10, [x0]
               	cmp	x10, #0x9d
               	b.ne	0x402e58 <.text+0x29f8>
               	bl	0x4005ac <.text+0x14c>
               	mov	x22, #0xa2              // =162
               	mov	x0, x22
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	b	0x402e54 <.text+0x29f4>
               	b	0x402e10 <.text+0x29b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x23, [x22]
               	cmp	x23, #0x9e
               	b.ne	0x402eb4 <.text+0x2a54>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x80
               	b.ne	0x402f38 <.text+0x2ad8>
               	b	0x402ed8 <.text+0x2a78>
               	b	0x402e54 <.text+0x29f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0xa2
               	cset	x0, eq
               	stur	x0, [x29, #-0x60]
               	cbnz	x0, 0x402fbc <.text+0x2b5c>
               	b	0x402f9c <.text+0x2b3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x0, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	str	x0, [x22]
               	bl	0x4005ac <.text+0x14c>
               	b	0x402f20 <.text+0x2ac0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x23]
               	b	0x402eb0 <.text+0x2a50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	str	x22, [x0]
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	mov	x22, #0xd               // =13
               	str	x22, [x24]
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x23, #0x1b              // =27
               	str	x23, [x0]
               	b	0x402f20 <.text+0x2ac0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0xa3
               	cset	x0, eq
               	stur	x0, [x29, #-0x60]
               	b	0x402fbc <.text+0x2b5c>
               	ldur	x0, [x29, #-0x60]
               	cbz	x0, 0x40300c <.text+0x2bac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	stur	x0, [x29, #-0x8]
               	bl	0x4005ac <.text+0x14c>
               	mov	x22, #0xa2              // =162
               	mov	x0, x22
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	ldr	x0, [x22]
               	cmp	x0, #0xa
               	b.ne	0x4030e4 <.text+0x2c84>
               	b	0x403058 <.text+0x2bf8>
               	b	0x402eb0 <.text+0x2a50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3dc
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x24
               	mov	x1, x25
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x403008 <.text+0x2ba8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x23, #0xa               // =10
               	str	x23, [x24]
               	b	0x403088 <.text+0x2c28>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x0]
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x25, #0x1               // =1
               	str	x25, [x23]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldr	x22, [x25]
               	cmp	x22, #0x2
               	b.le	0x40318c <.text+0x2d2c>
               	b	0x403180 <.text+0x2d20>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldr	x23, [x22]
               	cmp	x23, #0x9
               	b.ne	0x403134 <.text+0x2cd4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	mov	x24, #0xd               // =13
               	str	x24, [x23]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x24, #0x9               // =9
               	str	x24, [x0]
               	b	0x403130 <.text+0x2cd0>
               	b	0x403088 <.text+0x2c28>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3bb
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x24, [x22]
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x403130 <.text+0x2cd0>
               	mov	x25, #0x8               // =8
               	stur	x25, [x29, #-0x68]
               	b	0x403198 <.text+0x2d38>
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0x68]
               	b	0x403198 <.text+0x2d38>
               	ldur	x25, [x29, #-0x68]
               	str	x25, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x25, x25, #0x8
               	str	x25, [x22]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0xa2
               	b.ne	0x4031d0 <.text+0x2d70>
               	mov	x22, #0x19              // =25
               	stur	x22, [x29, #-0x70]
               	b	0x4031dc <.text+0x2d7c>
               	mov	x22, #0x1a              // =26
               	stur	x22, [x29, #-0x70]
               	b	0x4031dc <.text+0x2d7c>
               	ldur	x22, [x29, #-0x70]
               	str	x22, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x0
               	b.ne	0x403220 <.text+0x2dc0>
               	mov	x25, #0xc               // =12
               	stur	x25, [x29, #-0x78]
               	b	0x40322c <.text+0x2dcc>
               	mov	x25, #0xb               // =11
               	stur	x25, [x29, #-0x78]
               	b	0x40322c <.text+0x2dcc>
               	ldur	x25, [x29, #-0x78]
               	str	x25, [x22]
               	b	0x403008 <.text+0x2ba8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, x20
               	b.lt	0x403280 <.text+0x2e20>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x0, [x22]
               	stur	x0, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x8e
               	b.ne	0x4032e4 <.text+0x2e84>
               	b	0x4032b4 <.text+0x2e54>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	ldr	x0, [x25]
               	cmp	x0, #0xa
               	cset	x0, eq
               	stur	x0, [x29, #-0x80]
               	cbnz	x0, 0x403324 <.text+0x2ec4>
               	b	0x403300 <.text+0x2ea0>
               	b	0x403238 <.text+0x2dd8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x8f
               	b.ne	0x40345c <.text+0x2ffc>
               	b	0x4033fc <.text+0x2f9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	ldr	x25, [x0]
               	cmp	x25, #0x9
               	cset	x25, eq
               	stur	x25, [x29, #-0x80]
               	b	0x403324 <.text+0x2ec4>
               	ldur	x25, [x29, #-0x80]
               	cbz	x25, 0x40338c <.text+0x2f2c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x25]
               	b	0x403348 <.text+0x2ee8>
               	mov	x26, #0x8e              // =142
               	mov	x0, x26
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x22]
               	cmp	x0, #0x0
               	b.ne	0x4033e4 <.text+0x2f84>
               	b	0x4033d8 <.text+0x2f78>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3f0
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x26, [x24]
               	mov	x0, x22
               	mov	x1, x26
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x403348 <.text+0x2ee8>
               	mov	x23, #0xc               // =12
               	stur	x23, [x29, #-0x88]
               	b	0x4033f0 <.text+0x2f90>
               	mov	x23, #0xb               // =11
               	stur	x23, [x29, #-0x88]
               	b	0x4033f0 <.text+0x2f90>
               	ldur	x23, [x29, #-0x88]
               	str	x23, [x26]
               	b	0x4032e0 <.text+0x2e80>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x26, #0x4               // =4
               	str	x26, [x24]
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	stur	x22, [x29, #-0x10]
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x3a
               	b.ne	0x4034e0 <.text+0x3080>
               	b	0x403478 <.text+0x3018>
               	b	0x4032e0 <.text+0x2e80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x23, [x25]
               	cmp	x23, #0x90
               	b.ne	0x403598 <.text+0x3138>
               	b	0x40352c <.text+0x30cc>
               	bl	0x4005ac <.text+0x14c>
               	b	0x403480 <.text+0x3020>
               	ldur	x22, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x26, [x23]
               	add	x26, x26, #0x18
               	str	x26, [x22]
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	mov	x26, #0x2               // =2
               	str	x26, [x24]
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	stur	x22, [x29, #-0x10]
               	mov	x25, #0x8f              // =143
               	mov	x0, x25
               	bl	0x4020a0 <.text+0x1c40>
               	ldur	x0, [x29, #-0x10]
               	ldr	x25, [x23]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	b	0x403458 <.text+0x2ff8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x40e
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x26
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x403480 <.text+0x3020>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x25, #0x5               // =5
               	str	x25, [x23]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	stur	x24, [x29, #-0x10]
               	mov	x26, #0x91              // =145
               	mov	x0, x26
               	bl	0x4020a0 <.text+0x1c40>
               	ldur	x0, [x29, #-0x10]
               	ldr	x26, [x22]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x22]
               	b	0x403594 <.text+0x3134>
               	b	0x403458 <.text+0x2ff8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x91
               	b.ne	0x40361c <.text+0x31bc>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x24, [x26]
               	add	x24, x24, #0x8
               	str	x24, [x26]
               	mov	x22, #0x4               // =4
               	str	x22, [x24]
               	ldr	x23, [x26]
               	add	x23, x23, #0x8
               	str	x23, [x26]
               	stur	x23, [x29, #-0x10]
               	mov	x25, #0x92              // =146
               	mov	x0, x25
               	bl	0x4020a0 <.text+0x1c40>
               	ldur	x0, [x29, #-0x10]
               	ldr	x25, [x26]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x26]
               	b	0x403618 <.text+0x31b8>
               	b	0x403594 <.text+0x3134>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x92
               	b.ne	0x403694 <.text+0x3234>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x23]
               	mov	x22, #0x93              // =147
               	mov	x0, x22
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x22, #0xe               // =14
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	b	0x403690 <.text+0x3230>
               	b	0x403618 <.text+0x31b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x93
               	b.ne	0x40370c <.text+0x32ac>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x8
               	str	x26, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x24, #0x94              // =148
               	mov	x0, x24
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x24, #0xf               // =15
               	str	x24, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x22]
               	b	0x403708 <.text+0x32a8>
               	b	0x403690 <.text+0x3230>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x94
               	b.ne	0x403784 <.text+0x3324>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x8
               	str	x25, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x25]
               	mov	x23, #0x95              // =149
               	mov	x0, x23
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x23, #0x10              // =16
               	str	x23, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x24]
               	b	0x403780 <.text+0x3320>
               	b	0x403708 <.text+0x32a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x95
               	b.ne	0x4037fc <.text+0x339c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x24, #0xd               // =13
               	str	x24, [x22]
               	mov	x26, #0x97              // =151
               	mov	x0, x26
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x26, #0x11              // =17
               	str	x26, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x23]
               	b	0x4037f8 <.text+0x3398>
               	b	0x403780 <.text+0x3320>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x96
               	b.ne	0x403874 <.text+0x3414>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x24, [x26]
               	add	x24, x24, #0x8
               	str	x24, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	mov	x25, #0x97              // =151
               	mov	x0, x25
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x25, #0x12              // =18
               	str	x25, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x26]
               	b	0x403870 <.text+0x3410>
               	b	0x4037f8 <.text+0x3398>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x97
               	b.ne	0x4038ec <.text+0x348c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x23]
               	mov	x22, #0x9b              // =155
               	mov	x0, x22
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x22, #0x13              // =19
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	b	0x4038e8 <.text+0x3488>
               	b	0x403870 <.text+0x3410>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x98
               	b.ne	0x403964 <.text+0x3504>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x8
               	str	x26, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x24, #0x9b              // =155
               	mov	x0, x24
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x24, #0x14              // =20
               	str	x24, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x22]
               	b	0x403960 <.text+0x3500>
               	b	0x4038e8 <.text+0x3488>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x99
               	b.ne	0x4039dc <.text+0x357c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x8
               	str	x25, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x25]
               	mov	x23, #0x9b              // =155
               	mov	x0, x23
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x23, #0x15              // =21
               	str	x23, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x24]
               	b	0x4039d8 <.text+0x3578>
               	b	0x403960 <.text+0x3500>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x9a
               	b.ne	0x403a54 <.text+0x35f4>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x24, #0xd               // =13
               	str	x24, [x22]
               	mov	x26, #0x9b              // =155
               	mov	x0, x26
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x26, #0x16              // =22
               	str	x26, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x23]
               	b	0x403a50 <.text+0x35f0>
               	b	0x4039d8 <.text+0x3578>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x9b
               	b.ne	0x403acc <.text+0x366c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x24, [x26]
               	add	x24, x24, #0x8
               	str	x24, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	mov	x25, #0x9d              // =157
               	mov	x0, x25
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x25, #0x17              // =23
               	str	x25, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x26]
               	b	0x403ac8 <.text+0x3668>
               	b	0x403a50 <.text+0x35f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x9c
               	b.ne	0x403b44 <.text+0x36e4>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x23]
               	mov	x22, #0x9d              // =157
               	mov	x0, x22
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x22, #0x18              // =24
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	b	0x403b40 <.text+0x36e0>
               	b	0x403ac8 <.text+0x3668>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x9d
               	b.ne	0x403bb0 <.text+0x3750>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x22, #0x9f              // =159
               	mov	x0, x22
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x0]
               	cmp	x22, #0x2
               	b.le	0x403c2c <.text+0x37cc>
               	b	0x403bcc <.text+0x376c>
               	b	0x403b40 <.text+0x36e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x9e
               	b.ne	0x403c9c <.text+0x383c>
               	b	0x403c50 <.text+0x37f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x22, [x26]
               	add	x22, x22, #0x8
               	str	x22, [x26]
               	mov	x0, #0xd                // =13
               	str	x0, [x22]
               	ldr	x23, [x26]
               	add	x23, x23, #0x8
               	str	x23, [x26]
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	ldr	x22, [x26]
               	add	x22, x22, #0x8
               	str	x22, [x26]
               	mov	x0, #0x8                // =8
               	str	x0, [x22]
               	ldr	x23, [x26]
               	add	x23, x23, #0x8
               	str	x23, [x26]
               	mov	x0, #0x1b               // =27
               	str	x0, [x23]
               	b	0x403c2c <.text+0x37cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x23, #0x19              // =25
               	str	x23, [x26]
               	b	0x403bac <.text+0x374c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	mov	x26, #0xd               // =13
               	str	x26, [x25]
               	mov	x23, #0x9f              // =159
               	mov	x0, x23
               	bl	0x4020a0 <.text+0x1c40>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2
               	cset	x0, gt
               	stur	x0, [x29, #-0x90]
               	cbz	x0, 0x403cdc <.text+0x387c>
               	b	0x403cb8 <.text+0x3858>
               	b	0x403bac <.text+0x374c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x25, [x23]
               	cmp	x25, #0x9f
               	b.ne	0x403e84 <.text+0x3a24>
               	b	0x403e24 <.text+0x39c4>
               	ldur	x23, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x23, x25
               	cset	x23, eq
               	stur	x23, [x29, #-0x90]
               	b	0x403cdc <.text+0x387c>
               	ldur	x23, [x29, #-0x90]
               	cbz	x23, 0x403d6c <.text+0x390c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x0, #0x1a               // =26
               	str	x0, [x23]
               	ldr	x22, [x25]
               	add	x22, x22, #0x8
               	str	x22, [x25]
               	mov	x0, #0xd                // =13
               	str	x0, [x22]
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	ldr	x22, [x25]
               	add	x22, x22, #0x8
               	str	x22, [x25]
               	mov	x23, #0x8               // =8
               	str	x23, [x22]
               	ldr	x21, [x25]
               	add	x21, x21, #0x8
               	str	x21, [x25]
               	mov	x23, #0x1c              // =28
               	str	x23, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	str	x0, [x25]
               	b	0x403d68 <.text+0x3908>
               	b	0x403c98 <.text+0x3838>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldur	x23, [x29, #-0x8]
               	str	x23, [x25]
               	cmp	x23, #0x2
               	b.le	0x403e00 <.text+0x39a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x25, #0xd               // =13
               	str	x25, [x23]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x25, #0x8               // =8
               	str	x25, [x23]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x25, #0x1b              // =27
               	str	x25, [x21]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x25, #0x1a              // =26
               	str	x25, [x23]
               	b	0x403dfc <.text+0x399c>
               	b	0x403d68 <.text+0x3908>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x23, #0x1a              // =26
               	str	x23, [x0]
               	b	0x403dfc <.text+0x399c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x25, [x26]
               	add	x25, x25, #0x8
               	str	x25, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x25]
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x24, #0x1b              // =27
               	str	x24, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x26]
               	b	0x403e80 <.text+0x3a20>
               	b	0x403c98 <.text+0x3838>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0xa0
               	b.ne	0x403efc <.text+0x3a9c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	mov	x26, #0xd               // =13
               	str	x26, [x23]
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x21, #0x1c              // =28
               	str	x21, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x24]
               	b	0x403ef8 <.text+0x3a98>
               	b	0x403e80 <.text+0x3a20>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x0, [x21]
               	cmp	x0, #0xa1
               	b.ne	0x403f74 <.text+0x3b14>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x26, x26, #0x8
               	str	x26, [x21]
               	mov	x24, #0xd               // =13
               	str	x24, [x26]
               	mov	x25, #0xa2              // =162
               	mov	x0, x25
               	bl	0x4020a0 <.text+0x1c40>
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x25, #0x1d              // =29
               	str	x25, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	b	0x403f70 <.text+0x3b10>
               	b	0x403ef8 <.text+0x3a98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0xa2
               	cset	x0, eq
               	stur	x0, [x29, #-0x98]
               	cbnz	x0, 0x403fb4 <.text+0x3b54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0xa3
               	cset	x0, eq
               	stur	x0, [x29, #-0x98]
               	b	0x403fb4 <.text+0x3b54>
               	ldur	x0, [x29, #-0x98]
               	cbz	x0, 0x403fe0 <.text+0x3b80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	ldr	x25, [x0]
               	cmp	x25, #0xa
               	b.ne	0x404088 <.text+0x3c28>
               	b	0x403ffc <.text+0x3b9c>
               	b	0x403f70 <.text+0x3b10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0xa4
               	b.ne	0x404304 <.text+0x3ea4>
               	b	0x4042b4 <.text+0x3e54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x21, #0xd               // =13
               	str	x21, [x25]
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x21, #0xa               // =10
               	str	x21, [x26]
               	b	0x40402c <.text+0x3bcc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x24, #0xd               // =13
               	str	x24, [x0]
               	ldr	x21, [x25]
               	add	x21, x21, #0x8
               	str	x21, [x25]
               	mov	x24, #0x1               // =1
               	str	x24, [x21]
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x2
               	b.le	0x404130 <.text+0x3cd0>
               	b	0x404124 <.text+0x3cc4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	ldr	x21, [x0]
               	cmp	x21, #0x9
               	b.ne	0x4040d8 <.text+0x3c78>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x26, #0xd               // =13
               	str	x26, [x21]
               	ldr	x25, [x0]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	mov	x26, #0x9               // =9
               	str	x26, [x25]
               	b	0x4040d4 <.text+0x3c74>
               	b	0x40402c <.text+0x3bcc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x42d
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x26, [x0]
               	mov	x0, x24
               	mov	x1, x26
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x4040d4 <.text+0x3c74>
               	mov	x24, #0x8               // =8
               	stur	x24, [x29, #-0xa0]
               	b	0x40413c <.text+0x3cdc>
               	mov	x24, #0x1               // =1
               	stur	x24, [x29, #-0xa0]
               	b	0x40413c <.text+0x3cdc>
               	ldur	x24, [x29, #-0xa0]
               	str	x24, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0xa2
               	b.ne	0x404180 <.text+0x3d20>
               	mov	x0, #0x19               // =25
               	stur	x0, [x29, #-0xa8]
               	b	0x40418c <.text+0x3d2c>
               	mov	x0, #0x1a               // =26
               	stur	x0, [x29, #-0xa8]
               	b	0x40418c <.text+0x3d2c>
               	ldur	x0, [x29, #-0xa8]
               	str	x0, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x0
               	b.ne	0x4041d0 <.text+0x3d70>
               	mov	x24, #0xc               // =12
               	stur	x24, [x29, #-0xb0]
               	b	0x4041dc <.text+0x3d7c>
               	mov	x24, #0xb               // =11
               	stur	x24, [x29, #-0xb0]
               	b	0x4041dc <.text+0x3d7c>
               	ldur	x24, [x29, #-0xb0]
               	str	x24, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	mov	x0, #0xd                // =13
               	str	x0, [x24]
               	ldr	x21, [x25]
               	add	x21, x21, #0x8
               	str	x21, [x25]
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x2
               	b.le	0x404248 <.text+0x3de8>
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0xb8]
               	b	0x404254 <.text+0x3df4>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xb8]
               	b	0x404254 <.text+0x3df4>
               	ldur	x0, [x29, #-0xb8]
               	str	x0, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0xa2
               	b.ne	0x404298 <.text+0x3e38>
               	mov	x24, #0x1a              // =26
               	stur	x24, [x29, #-0xc0]
               	b	0x4042a4 <.text+0x3e44>
               	mov	x24, #0x19              // =25
               	stur	x24, [x29, #-0xc0]
               	b	0x4042a4 <.text+0x3e44>
               	ldur	x24, [x29, #-0xc0]
               	str	x24, [x0]
               	bl	0x4005ac <.text+0x14c>
               	b	0x403fdc <.text+0x3b7c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x24, #0x8e              // =142
               	mov	x0, x24
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x5d
               	b.ne	0x40437c <.text+0x3f1c>
               	b	0x404364 <.text+0x3f04>
               	b	0x403fdc <.text+0x3b7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x486
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x21, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x26, [x25]
               	mov	x0, x23
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404300 <.text+0x3ea0>
               	bl	0x4005ac <.text+0x14c>
               	b	0x40436c <.text+0x3f0c>
               	ldur	x26, [x29, #-0x8]
               	cmp	x26, #0x2
               	b.le	0x404478 <.text+0x4018>
               	b	0x4043c8 <.text+0x3f68>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x44f
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x0, x26
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x40436c <.text+0x3f0c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x25, #0x8               // =8
               	str	x25, [x26]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x25, #0x1b              // =27
               	str	x25, [x21]
               	b	0x404428 <.text+0x3fc8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x24, #0x19              // =25
               	str	x24, [x0]
               	ldr	x26, [x25]
               	add	x26, x26, #0x8
               	str	x26, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldur	x25, [x29, #-0x8]
               	sub	x25, x25, #0x2
               	str	x25, [x24]
               	cmp	x25, #0x0
               	b.ne	0x4044e0 <.text+0x4080>
               	b	0x4044d4 <.text+0x4074>
               	ldur	x25, [x29, #-0x8]
               	cmp	x25, #0x2
               	b.ge	0x4044d0 <.text+0x4070>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46b
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x23, [x25]
               	mov	x0, x24
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x4044d0 <.text+0x4070>
               	b	0x404428 <.text+0x3fc8>
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0xc8]
               	b	0x4044ec <.text+0x408c>
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0xc8]
               	b	0x4044ec <.text+0x408c>
               	ldur	x0, [x29, #-0xc8]
               	str	x0, [x26]
               	b	0x404300 <.text+0x3ea0>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x15, x19
               	ldr	x14, [x15]
               	cmp	x14, #0x89
               	b.ne	0x404578 <.text+0x4118>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x28
               	b.ne	0x4045c4 <.text+0x4164>
               	b	0x404594 <.text+0x4134>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x12, x19
               	ldr	x0, [x12]
               	cmp	x0, #0x8d
               	b.ne	0x40475c <.text+0x42fc>
               	b	0x404720 <.text+0x42c0>
               	bl	0x4005ac <.text+0x14c>
               	b	0x40459c <.text+0x413c>
               	mov	x20, #0x8e              // =142
               	mov	x0, x20
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x29
               	b.ne	0x404668 <.text+0x4208>
               	b	0x404610 <.text+0x41b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4a0
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x40459c <.text+0x413c>
               	bl	0x4005ac <.text+0x14c>
               	b	0x404618 <.text+0x41b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x22, #0x4               // =4
               	str	x22, [x0]
               	ldr	x12, [x21]
               	add	x12, x12, #0x8
               	str	x12, [x21]
               	stur	x12, [x29, #-0x10]
               	bl	0x4044f8 <.text+0x4098>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x12, [x0]
               	cmp	x12, #0x87
               	b.ne	0x404700 <.text+0x42a0>
               	b	0x4046b4 <.text+0x4254>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4b9
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404618 <.text+0x41b8>
               	ldur	x0, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	ldr	x21, [x12]
               	add	x21, x21, #0x18
               	str	x21, [x0]
               	ldr	x22, [x12]
               	add	x22, x22, #0x8
               	str	x22, [x12]
               	mov	x21, #0x2               // =2
               	str	x21, [x22]
               	ldr	x0, [x12]
               	add	x0, x0, #0x8
               	str	x0, [x12]
               	stur	x0, [x29, #-0x10]
               	bl	0x4005ac <.text+0x14c>
               	bl	0x4044f8 <.text+0x4098>
               	b	0x404700 <.text+0x42a0>
               	ldur	x21, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x12, [x0]
               	add	x12, x12, #0x8
               	str	x12, [x21]
               	b	0x404550 <.text+0x40f0>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x20, [x0]
               	add	x20, x20, #0x8
               	stur	x20, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x28
               	b.ne	0x4047a8 <.text+0x4348>
               	b	0x404778 <.text+0x4318>
               	b	0x404550 <.text+0x40f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x20, [x22]
               	cmp	x20, #0x8b
               	b.ne	0x4048dc <.text+0x447c>
               	b	0x4048b8 <.text+0x4458>
               	bl	0x4005ac <.text+0x14c>
               	b	0x404780 <.text+0x4320>
               	mov	x20, #0x8e              // =142
               	mov	x0, x20
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x29
               	b.ne	0x40486c <.text+0x440c>
               	b	0x4047f4 <.text+0x4394>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4d3
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404780 <.text+0x4320>
               	bl	0x4005ac <.text+0x14c>
               	b	0x4047fc <.text+0x439c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x21, #0x4               // =4
               	str	x21, [x0]
               	ldr	x22, [x20]
               	add	x22, x22, #0x8
               	str	x22, [x20]
               	stur	x22, [x29, #-0x10]
               	bl	0x4044f8 <.text+0x4098>
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x22, #0x2               // =2
               	str	x22, [x0]
               	ldr	x21, [x20]
               	add	x21, x21, #0x8
               	str	x21, [x20]
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x21]
               	ldur	x0, [x29, #-0x10]
               	ldr	x22, [x20]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	b	0x404758 <.text+0x42f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4ec
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x4047fc <.text+0x439c>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x3b
               	b.eq	0x404908 <.text+0x44a8>
               	b	0x4048f8 <.text+0x4498>
               	b	0x404758 <.text+0x42f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x7b
               	b.ne	0x4049a4 <.text+0x4544>
               	b	0x404998 <.text+0x4538>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x4020a0 <.text+0x1c40>
               	b	0x404908 <.text+0x44a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0x8               // =8
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0x3b
               	b.ne	0x40494c <.text+0x44ec>
               	bl	0x4005ac <.text+0x14c>
               	b	0x404948 <.text+0x44e8>
               	b	0x4048d8 <.text+0x4478>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x506
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404948 <.text+0x44e8>
               	bl	0x4005ac <.text+0x14c>
               	b	0x4049c0 <.text+0x4560>
               	b	0x4048d8 <.text+0x4478>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x3b
               	b.ne	0x4049f8 <.text+0x4598>
               	b	0x4049ec <.text+0x458c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x7d
               	b.eq	0x4049e4 <.text+0x4584>
               	bl	0x4044f8 <.text+0x4098>
               	mov	x22, x0
               	b	0x4049c0 <.text+0x4560>
               	bl	0x4005ac <.text+0x14c>
               	b	0x4049a0 <.text+0x4540>
               	bl	0x4005ac <.text+0x14c>
               	b	0x4049f4 <.text+0x4594>
               	b	0x4049a0 <.text+0x4540>
               	mov	x22, #0x8e              // =142
               	mov	x0, x22
               	bl	0x4020a0 <.text+0x1c40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x3b
               	b.ne	0x404a28 <.text+0x45c8>
               	bl	0x4005ac <.text+0x14c>
               	b	0x404a24 <.text+0x45c4>
               	b	0x4049f4 <.text+0x4594>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x51e
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404a24 <.text+0x45c4>
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x15, x0
               	stur	x15, [x29, #0x10]
               	mov	x14, x1
               	stur	x14, [x29, #0x20]
               	add	x15, x29, #0x10
               	ldr	x14, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x14, x14, x17
               	str	x14, [x15]
               	add	x13, x29, #0x20
               	ldr	x14, [x13]
               	add	x14, x14, #0x8
               	str	x14, [x13]
               	ldur	x15, [x29, #0x10]
               	cmp	x15, #0x0
               	cset	x15, gt
               	stur	x15, [x29, #-0xa0]
               	cbz	x15, 0x404b30 <.text+0x46d0>
               	ldur	x14, [x29, #0x20]
               	ldr	x15, [x14]
               	ldrb	w14, [x15]
               	mov	x17, #0x2d              // =45
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	cset	x14, eq
               	stur	x14, [x29, #-0xa0]
               	b	0x404b30 <.text+0x46d0>
               	ldur	x14, [x29, #-0xa0]
               	stur	x14, [x29, #-0x98]
               	cbz	x14, 0x404b70 <.text+0x4710>
               	ldur	x15, [x29, #0x20]
               	ldr	x14, [x15]
               	add	x14, x14, #0x1
               	ldrb	w15, [x14]
               	mov	x17, #0x73              // =115
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x98]
               	b	0x404b70 <.text+0x4710>
               	ldur	x15, [x29, #-0x98]
               	cbz	x15, 0x404bc0 <.text+0x4760>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e8
               	mov	x14, x19
               	mov	x15, #0x1               // =1
               	str	x15, [x14]
               	add	x13, x29, #0x10
               	ldr	x15, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x15, x15, x17
               	str	x15, [x13]
               	add	x14, x29, #0x20
               	ldr	x15, [x14]
               	add	x15, x15, #0x8
               	str	x15, [x14]
               	b	0x404bc0 <.text+0x4760>
               	ldur	x15, [x29, #0x10]
               	cmp	x15, #0x0
               	cset	x15, gt
               	stur	x15, [x29, #-0xb0]
               	cbz	x15, 0x404c04 <.text+0x47a4>
               	ldur	x13, [x29, #0x20]
               	ldr	x15, [x13]
               	ldrb	w13, [x15]
               	mov	x17, #0x2d              // =45
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, eq
               	stur	x13, [x29, #-0xb0]
               	b	0x404c04 <.text+0x47a4>
               	ldur	x13, [x29, #-0xb0]
               	stur	x13, [x29, #-0xa8]
               	cbz	x13, 0x404c44 <.text+0x47e4>
               	ldur	x15, [x29, #0x20]
               	ldr	x13, [x15]
               	add	x13, x13, #0x1
               	ldrb	w15, [x13]
               	mov	x17, #0x64              // =100
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0xa8]
               	b	0x404c44 <.text+0x47e4>
               	ldur	x15, [x29, #-0xa8]
               	cbz	x15, 0x404c94 <.text+0x4834>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f0
               	mov	x13, x19
               	mov	x15, #0x1               // =1
               	str	x15, [x13]
               	add	x14, x29, #0x10
               	ldr	x15, [x14]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x15, x15, x17
               	str	x15, [x14]
               	add	x13, x29, #0x20
               	ldr	x15, [x13]
               	add	x15, x15, #0x8
               	str	x15, [x13]
               	b	0x404c94 <.text+0x4834>
               	ldur	x15, [x29, #0x10]
               	cmp	x15, #0x1
               	b.ge	0x404cfc <.text+0x489c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x536
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldur	x20, [x29, #0x20]
               	ldr	x21, [x20]
               	mov	x22, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x406d48 <open>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ge	0x404d8c <.text+0x492c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x554
               	mov	x23, x19
               	ldur	x22, [x29, #0x20]
               	ldr	x21, [x22]
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x21, #0x40000           // =262144
               	sxtw	x21, w21
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x22, x19
               	mov	x0, x21
               	bl	0x406d54 <malloc>
               	str	x0, [x22]
               	cmp	x0, #0x0
               	b.ne	0x404e14 <.text+0x49b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x568
               	mov	x23, x19
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	mov	x0, x21
               	bl	0x406d54 <malloc>
               	str	x0, [x23]
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	0x404ea4 <.text+0x4a44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x58a
               	mov	x22, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x25, x19
               	mov	x0, x21
               	bl	0x406d54 <malloc>
               	str	x0, [x25]
               	cmp	x0, #0x0
               	b.ne	0x404f24 <.text+0x4ac4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5aa
               	mov	x22, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x0, x21
               	bl	0x406d54 <malloc>
               	stur	x0, [x29, #-0x38]
               	cmp	x0, #0x0
               	b.ne	0x404f98 <.text+0x4b38>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ca
               	mov	x24, x19
               	mov	x0, x24
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x24, x19
               	ldr	x22, [x24]
               	mov	x26, #0x0               // =0
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x26
               	bl	0x406d60 <memset>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x25
               	mov	x2, x21
               	mov	x1, x26
               	bl	0x406d60 <memset>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x26
               	bl	0x406d60 <memset>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5eb
               	mov	x22, x19
               	str	x22, [x0]
               	mov	x26, #0x86              // =134
               	stur	x26, [x29, #-0x58]
               	b	0x405024 <.text+0x4bc4>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x8d
               	b.gt	0x40505c <.text+0x4bfc>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x26, [x0]
               	sub	x0, x29, #0x58
               	ldr	x22, [x0]
               	add	x23, x22, #0x1
               	str	x23, [x0]
               	str	x22, [x26]
               	b	0x405024 <.text+0x4bc4>
               	mov	x22, #0x1e              // =30
               	stur	x22, [x29, #-0x58]
               	b	0x405068 <.text+0x4c08>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x26
               	b.gt	0x4050c4 <.text+0x4c64>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x18
               	mov	x26, #0x82              // =130
               	str	x26, [x22]
               	ldr	x23, [x0]
               	add	x23, x23, #0x20
               	mov	x26, #0x1               // =1
               	str	x26, [x23]
               	ldr	x22, [x0]
               	add	x22, x22, #0x28
               	sub	x0, x29, #0x58
               	ldr	x26, [x0]
               	add	x23, x26, #0x1
               	str	x23, [x0]
               	str	x26, [x22]
               	b	0x405068 <.text+0x4c08>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x25, [x24]
               	mov	x22, #0x86              // =134
               	str	x22, [x25]
               	bl	0x4005ac <.text+0x14c>
               	ldr	x23, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x190
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	mov	x0, x21
               	bl	0x406d54 <malloc>
               	str	x0, [x24]
               	str	x0, [x27]
               	cmp	x0, #0x0
               	b.ne	0x405178 <.text+0x4d18>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x655
               	mov	x25, x19
               	mov	x0, x25
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x26, [x25]
               	sub	x22, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x406d6c <read>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x58]
               	cmp	x0, #0x0
               	b.gt	0x405210 <.text+0x4db0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x677
               	mov	x27, x19
               	ldur	x22, [x29, #-0x58]
               	mov	x0, x27
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x0, [x22]
               	ldur	x22, [x29, #-0x58]
               	add	x0, x0, x22
               	mov	x22, #0x0               // =0
               	strb	w22, [x0]
               	mov	x0, x20
               	bl	0x406d78 <close>
               	sxtw	x0, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	mov	x20, #0x1               // =1
               	str	x20, [x0]
               	bl	0x4005ac <.text+0x14c>
               	b	0x405258 <.text+0x4df8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cbz	x0, 0x405290 <.text+0x4e30>
               	mov	x20, #0x1               // =1
               	stur	x20, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x8a
               	b.ne	0x4052b4 <.text+0x4e54>
               	b	0x4052a8 <.text+0x4e48>
               	add	x23, x23, #0x28
               	ldr	x25, [x23]
               	stur	x25, [x29, #-0x30]
               	cmp	x25, #0x0
               	b.ne	0x405f9c <.text+0x5b3c>
               	b	0x405f40 <.text+0x5ae0>
               	bl	0x4005ac <.text+0x14c>
               	b	0x4052b0 <.text+0x4e50>
               	b	0x405550 <.text+0x50f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x86
               	b.ne	0x4052e0 <.text+0x4e80>
               	bl	0x4005ac <.text+0x14c>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	b	0x4052dc <.text+0x4e7c>
               	b	0x4052b0 <.text+0x4e50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0x88
               	b.ne	0x405318 <.text+0x4eb8>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0x7b
               	b.eq	0x405324 <.text+0x4ec4>
               	b	0x40531c <.text+0x4ebc>
               	b	0x4052dc <.text+0x4e7c>
               	bl	0x4005ac <.text+0x14c>
               	b	0x405324 <.text+0x4ec4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x7b
               	b.ne	0x40534c <.text+0x4eec>
               	bl	0x4005ac <.text+0x14c>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x58]
               	b	0x405350 <.text+0x4ef0>
               	b	0x405318 <.text+0x4eb8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x7d
               	b.eq	0x405384 <.text+0x4f24>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x85
               	b.eq	0x405414 <.text+0x4fb4>
               	b	0x40538c <.text+0x4f2c>
               	bl	0x4005ac <.text+0x14c>
               	b	0x40534c <.text+0x4eec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x68b
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x25, [x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x22, [x20]
               	mov	x0, x26
               	mov	x2, x22
               	mov	x1, x25
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x8e
               	b.ne	0x405450 <.text+0x4ff0>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x80
               	b.eq	0x405524 <.text+0x50c4>
               	b	0x4054b4 <.text+0x5054>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x27, x19
               	ldr	x0, [x27]
               	add	x0, x0, #0x18
               	mov	x22, #0x80              // =128
               	str	x22, [x0]
               	ldr	x26, [x27]
               	add	x26, x26, #0x20
               	mov	x22, #0x1               // =1
               	str	x22, [x26]
               	ldr	x0, [x27]
               	add	x0, x0, #0x28
               	sub	x27, x29, #0x58
               	ldr	x22, [x27]
               	add	x26, x22, #0x1
               	str	x26, [x27]
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x2c
               	b.ne	0x40554c <.text+0x50ec>
               	b	0x405540 <.text+0x50e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6a7
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x27, [x20]
               	mov	x0, x22
               	mov	x1, x27
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x27, x19
               	ldr	x0, [x27]
               	stur	x0, [x29, #-0x58]
               	bl	0x4005ac <.text+0x14c>
               	b	0x405450 <.text+0x4ff0>
               	bl	0x4005ac <.text+0x14c>
               	mov	x20, x0
               	b	0x40554c <.text+0x50ec>
               	b	0x405350 <.text+0x4ef0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	cbz	x0, 0x4055a8 <.text+0x5148>
               	b	0x405588 <.text+0x5128>
               	ldur	x20, [x29, #-0x10]
               	stur	x20, [x29, #-0x18]
               	b	0x4055b4 <.text+0x5154>
               	bl	0x4005ac <.text+0x14c>
               	b	0x405258 <.text+0x4df8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x7d
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	b	0x4055a8 <.text+0x5148>
               	ldur	x0, [x29, #-0xb8]
               	cbz	x0, 0x405580 <.text+0x5120>
               	b	0x405574 <.text+0x5114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x9f
               	b.ne	0x4055e0 <.text+0x5180>
               	bl	0x4005ac <.text+0x14c>
               	ldur	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x18]
               	b	0x4055b4 <.text+0x5154>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x85
               	b.eq	0x405668 <.text+0x5208>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6c1
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x25, [x24]
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x18
               	ldr	x25, [x0]
               	cbz	x25, 0x4056f8 <.text+0x5298>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6dd
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x22, [x25]
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x25, [x0]
               	add	x25, x25, #0x20
               	ldur	x0, [x29, #-0x18]
               	str	x0, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x28
               	b.ne	0x405798 <.text+0x5338>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x18
               	mov	x25, #0x81              // =129
               	str	x25, [x0]
               	ldr	x26, [x24]
               	add	x26, x26, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x8
               	str	x25, [x26]
               	bl	0x4005ac <.text+0x14c>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x58]
               	b	0x4057e0 <.text+0x5380>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x2c
               	b.ne	0x405f3c <.text+0x5adc>
               	b	0x405f30 <.text+0x5ad0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x25, x25, #0x18
               	mov	x0, #0x83               // =131
               	str	x0, [x25]
               	ldr	x27, [x22]
               	add	x27, x27, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x0, [x22]
               	str	x0, [x27]
               	ldr	x25, [x22]
               	add	x25, x25, #0x8
               	str	x25, [x22]
               	b	0x40577c <.text+0x531c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x29
               	b.eq	0x40581c <.text+0x53bc>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x18]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x8a
               	b.ne	0x405848 <.text+0x53e8>
               	b	0x40583c <.text+0x53dc>
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x7b
               	b.eq	0x405ae4 <.text+0x5684>
               	b	0x405a74 <.text+0x5614>
               	bl	0x4005ac <.text+0x14c>
               	b	0x405844 <.text+0x53e4>
               	b	0x405874 <.text+0x5414>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x86
               	b.ne	0x405870 <.text+0x5410>
               	bl	0x4005ac <.text+0x14c>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	b	0x405870 <.text+0x5410>
               	b	0x405844 <.text+0x53e4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x9f
               	b.ne	0x4058a0 <.text+0x5440>
               	bl	0x4005ac <.text+0x14c>
               	ldur	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x18]
               	b	0x405874 <.text+0x5414>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x85
               	b.eq	0x405928 <.text+0x54c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6fe
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x20, [x25]
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x0, x0, #0x18
               	ldr	x20, [x0]
               	cmp	x20, #0x84
               	b.ne	0x4059b8 <.text+0x5558>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x71d
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x26, [x20]
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x0, [x26]
               	add	x0, x0, #0x30
               	ldr	x25, [x26]
               	add	x25, x25, #0x18
               	ldr	x24, [x25]
               	str	x24, [x0]
               	ldr	x25, [x26]
               	add	x25, x25, #0x18
               	mov	x24, #0x84              // =132
               	str	x24, [x25]
               	ldr	x0, [x26]
               	add	x0, x0, #0x38
               	ldr	x24, [x26]
               	add	x24, x24, #0x20
               	ldr	x25, [x24]
               	str	x25, [x0]
               	ldr	x24, [x26]
               	add	x24, x24, #0x20
               	ldur	x25, [x29, #-0x18]
               	str	x25, [x24]
               	ldr	x0, [x26]
               	add	x0, x0, #0x40
               	ldr	x25, [x26]
               	add	x25, x25, #0x28
               	ldr	x24, [x25]
               	str	x24, [x0]
               	ldr	x25, [x26]
               	add	x25, x25, #0x28
               	sub	x26, x29, #0x58
               	ldr	x24, [x26]
               	add	x0, x24, #0x1
               	str	x0, [x26]
               	str	x24, [x25]
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x2c
               	b.ne	0x405a70 <.text+0x5610>
               	bl	0x4005ac <.text+0x14c>
               	mov	x20, x0
               	b	0x405a70 <.text+0x5610>
               	b	0x4057e0 <.text+0x5380>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x741
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x22, [x20]
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x22, x19
               	sub	x0, x29, #0x58
               	ldr	x24, [x0]
               	add	x24, x24, #0x1
               	str	x24, [x0]
               	str	x24, [x22]
               	bl	0x4005ac <.text+0x14c>
               	b	0x405b0c <.text+0x56ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x8a
               	cset	x0, eq
               	stur	x0, [x29, #-0xc0]
               	cbnz	x0, 0x405bb8 <.text+0x5758>
               	b	0x405b98 <.text+0x5738>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x8a
               	b.ne	0x405bd0 <.text+0x5770>
               	b	0x405bc4 <.text+0x5764>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x20, #0x6               // =6
               	str	x20, [x0]
               	ldr	x22, [x25]
               	add	x22, x22, #0x8
               	str	x22, [x25]
               	ldur	x20, [x29, #-0x58]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x25, x19
               	ldr	x0, [x25]
               	sub	x20, x20, x0
               	str	x20, [x22]
               	b	0x405e18 <.text+0x59b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x86
               	cset	x0, eq
               	stur	x0, [x29, #-0xc0]
               	b	0x405bb8 <.text+0x5758>
               	ldur	x0, [x29, #-0xc0]
               	cbz	x0, 0x405b4c <.text+0x56ec>
               	b	0x405b30 <.text+0x56d0>
               	mov	x24, #0x1               // =1
               	stur	x24, [x29, #-0xc8]
               	b	0x405bdc <.text+0x577c>
               	mov	x24, #0x0               // =0
               	stur	x24, [x29, #-0xc8]
               	b	0x405bdc <.text+0x577c>
               	ldur	x24, [x29, #-0xc8]
               	stur	x24, [x29, #-0x10]
               	bl	0x4005ac <.text+0x14c>
               	b	0x405bec <.text+0x578c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x3b
               	b.eq	0x405c10 <.text+0x57b0>
               	ldur	x24, [x29, #-0x10]
               	stur	x24, [x29, #-0x18]
               	b	0x405c18 <.text+0x57b8>
               	bl	0x4005ac <.text+0x14c>
               	b	0x405b0c <.text+0x56ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x9f
               	b.ne	0x405c44 <.text+0x57e4>
               	bl	0x4005ac <.text+0x14c>
               	ldur	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x18]
               	b	0x405c18 <.text+0x57b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x85
               	b.eq	0x405ccc <.text+0x586c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x75e
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x25, [x20]
               	mov	x0, x24
               	mov	x1, x25
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x18
               	ldr	x25, [x0]
               	cmp	x25, #0x84
               	b.ne	0x405d5c <.text+0x58fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x779
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x22, [x25]
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x30
               	ldr	x20, [x22]
               	add	x20, x20, #0x18
               	ldr	x27, [x20]
               	str	x27, [x0]
               	ldr	x20, [x22]
               	add	x20, x20, #0x18
               	mov	x27, #0x84              // =132
               	str	x27, [x20]
               	ldr	x0, [x22]
               	add	x0, x0, #0x38
               	ldr	x27, [x22]
               	add	x27, x27, #0x20
               	ldr	x20, [x27]
               	str	x20, [x0]
               	ldr	x27, [x22]
               	add	x27, x27, #0x20
               	ldur	x20, [x29, #-0x18]
               	str	x20, [x27]
               	ldr	x0, [x22]
               	add	x0, x0, #0x40
               	ldr	x20, [x22]
               	add	x20, x20, #0x28
               	ldr	x27, [x20]
               	str	x27, [x0]
               	ldr	x20, [x22]
               	add	x20, x20, #0x28
               	sub	x22, x29, #0x58
               	ldr	x27, [x22]
               	add	x27, x27, #0x1
               	str	x27, [x22]
               	str	x27, [x20]
               	bl	0x4005ac <.text+0x14c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x27, [x0]
               	cmp	x27, #0x2c
               	b.ne	0x405e14 <.text+0x59b4>
               	bl	0x4005ac <.text+0x14c>
               	mov	x25, x0
               	b	0x405e14 <.text+0x59b4>
               	b	0x405bec <.text+0x578c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x7d
               	b.eq	0x405e38 <.text+0x59d8>
               	bl	0x4044f8 <.text+0x4098>
               	b	0x405e18 <.text+0x59b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x27, x19
               	ldr	x0, [x27]
               	add	x0, x0, #0x8
               	str	x0, [x27]
               	mov	x22, #0x8               // =8
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x22, x19
               	ldr	x0, [x22]
               	str	x0, [x27]
               	b	0x405e7c <.text+0x5a1c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x22, [x0]
               	ldr	x0, [x22]
               	cbz	x0, 0x405eb8 <.text+0x5a58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x18
               	ldr	x22, [x0]
               	cmp	x22, #0x84
               	b.ne	0x405f14 <.text+0x5ab4>
               	b	0x405ebc <.text+0x5a5c>
               	b	0x40577c <.text+0x531c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x18
               	ldr	x27, [x0]
               	add	x27, x27, #0x30
               	ldr	x25, [x27]
               	str	x25, [x22]
               	ldr	x27, [x0]
               	add	x27, x27, #0x20
               	ldr	x25, [x0]
               	add	x25, x25, #0x38
               	ldr	x22, [x25]
               	str	x22, [x27]
               	ldr	x25, [x0]
               	add	x25, x25, #0x28
               	ldr	x22, [x0]
               	add	x22, x22, #0x40
               	ldr	x0, [x22]
               	str	x0, [x25]
               	b	0x405f14 <.text+0x5ab4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x48
               	str	x22, [x0]
               	b	0x405e7c <.text+0x5a1c>
               	bl	0x4005ac <.text+0x14c>
               	mov	x25, x0
               	b	0x405f3c <.text+0x5adc>
               	b	0x405550 <.text+0x50f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x799
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e8
               	mov	x20, x19
               	ldr	x0, [x20]
               	cbz	x0, 0x405fec <.text+0x5b8c>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldur	x0, [x29, #-0x38]
               	add	x0, x0, x21
               	stur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x40]
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	x0, [x21]
               	mov	x20, #0x26              // =38
               	str	x20, [x0]
               	sub	x21, x29, #0x38
               	ldr	x20, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x20, x17
               	str	x20, [x21]
               	mov	x0, #0xd                // =13
               	str	x0, [x20]
               	ldur	x21, [x29, #-0x38]
               	stur	x21, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldr	x21, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x0]
               	ldur	x20, [x29, #0x10]
               	str	x20, [x21]
               	sub	x0, x29, #0x38
               	ldr	x20, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x20, x17
               	str	x20, [x0]
               	ldur	x21, [x29, #0x20]
               	str	x21, [x20]
               	sub	x0, x29, #0x38
               	ldr	x21, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x0]
               	ldur	x20, [x29, #-0x60]
               	str	x20, [x21]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x50]
               	b	0x4060d8 <.text+0x5c78>
               	mov	x0, #0x1                // =1
               	cbz	x0, 0x406120 <.text+0x5cc0>
               	sub	x20, x29, #0x30
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	ldr	x25, [x0]
               	stur	x25, [x29, #-0x58]
               	sub	x0, x29, #0x50
               	ldr	x25, [x0]
               	add	x25, x25, #0x1
               	str	x25, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f0
               	mov	x21, x19
               	ldr	x25, [x21]
               	cbz	x25, 0x4061ac <.text+0x5d4c>
               	b	0x40615c <.text+0x5cfc>
               	mov	x27, #0x0               // =0
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x7ad
               	mov	x23, x19
               	ldur	x21, [x29, #-0x50]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x7b6
               	mov	x0, x19
               	ldur	x20, [x29, #-0x58]
               	mov	x17, #0x5               // =5
               	mul	x20, x20, x17
               	add	x25, x0, x20
               	mov	x0, x23
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x7
               	b.gt	0x4061e8 <.text+0x5d88>
               	b	0x4061bc <.text+0x5d5c>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x0
               	b.ne	0x406230 <.text+0x5dd0>
               	b	0x406204 <.text+0x5da4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x87a
               	mov	x22, x19
               	ldur	x0, [x29, #-0x30]
               	ldr	x25, [x0]
               	mov	x0, x22
               	mov	x1, x25
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	b	0x4061e4 <.text+0x5d84>
               	b	0x4061ac <.text+0x5d4c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x87f
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	b	0x4061e4 <.text+0x5d84>
               	ldur	x0, [x29, #-0x40]
               	sub	x21, x29, #0x30
               	ldr	x22, [x21]
               	add	x23, x22, #0x8
               	str	x23, [x21]
               	ldr	x20, [x22]
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	stur	x0, [x29, #-0x48]
               	b	0x40622c <.text+0x5dcc>
               	b	0x4060d8 <.text+0x5c78>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x1
               	b.ne	0x40625c <.text+0x5dfc>
               	sub	x20, x29, #0x30
               	ldr	x0, [x20]
               	add	x22, x0, #0x8
               	str	x22, [x20]
               	ldr	x23, [x0]
               	stur	x23, [x29, #-0x48]
               	b	0x406258 <.text+0x5df8>
               	b	0x40622c <.text+0x5dcc>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x2
               	b.ne	0x40627c <.text+0x5e1c>
               	ldur	x0, [x29, #-0x30]
               	ldr	x23, [x0]
               	stur	x23, [x29, #-0x30]
               	b	0x406278 <.text+0x5e18>
               	b	0x406258 <.text+0x5df8>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x3
               	b.ne	0x4062c8 <.text+0x5e68>
               	sub	x0, x29, #0x38
               	ldr	x23, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x23, x23, x17
               	str	x23, [x0]
               	ldur	x22, [x29, #-0x30]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	ldur	x0, [x29, #-0x30]
               	ldr	x22, [x0]
               	stur	x22, [x29, #-0x30]
               	b	0x4062c4 <.text+0x5e64>
               	b	0x406278 <.text+0x5e18>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x4
               	b.ne	0x4062e4 <.text+0x5e84>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, 0x406304 <.text+0x5ea4>
               	b	0x4062f4 <.text+0x5e94>
               	b	0x4062c4 <.text+0x5e64>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x5
               	b.ne	0x406330 <.text+0x5ed0>
               	b	0x406320 <.text+0x5ec0>
               	ldur	x22, [x29, #-0x30]
               	add	x22, x22, #0x8
               	stur	x22, [x29, #-0xd0]
               	b	0x406314 <.text+0x5eb4>
               	ldur	x22, [x29, #-0x30]
               	ldr	x0, [x22]
               	stur	x0, [x29, #-0xd0]
               	b	0x406314 <.text+0x5eb4>
               	ldur	x0, [x29, #-0xd0]
               	stur	x0, [x29, #-0x30]
               	b	0x4062e0 <.text+0x5e80>
               	ldur	x22, [x29, #-0x48]
               	cbz	x22, 0x406350 <.text+0x5ef0>
               	b	0x406340 <.text+0x5ee0>
               	b	0x4062e0 <.text+0x5e80>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x6
               	b.ne	0x4063c4 <.text+0x5f64>
               	b	0x40636c <.text+0x5f0c>
               	ldur	x0, [x29, #-0x30]
               	ldr	x22, [x0]
               	stur	x22, [x29, #-0xd8]
               	b	0x406360 <.text+0x5f00>
               	ldur	x22, [x29, #-0x30]
               	add	x22, x22, #0x8
               	stur	x22, [x29, #-0xd8]
               	b	0x406360 <.text+0x5f00>
               	ldur	x22, [x29, #-0xd8]
               	stur	x22, [x29, #-0x30]
               	b	0x40632c <.text+0x5ecc>
               	sub	x0, x29, #0x38
               	ldr	x22, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x22, x17
               	str	x22, [x0]
               	ldur	x23, [x29, #-0x40]
               	str	x23, [x22]
               	ldur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x40]
               	sub	x23, x29, #0x30
               	ldr	x22, [x23]
               	add	x20, x22, #0x8
               	str	x20, [x23]
               	ldr	x21, [x22]
               	lsl	x21, x21, #3
               	sub	x0, x0, x21
               	stur	x0, [x29, #-0x38]
               	b	0x4063c0 <.text+0x5f60>
               	b	0x40632c <.text+0x5ecc>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x7
               	b.ne	0x4063fc <.text+0x5f9c>
               	ldur	x21, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	ldr	x22, [x0]
               	add	x20, x22, #0x8
               	str	x20, [x0]
               	ldr	x23, [x22]
               	lsl	x23, x23, #3
               	add	x21, x21, x23
               	stur	x21, [x29, #-0x38]
               	b	0x4063f8 <.text+0x5f98>
               	b	0x4063c0 <.text+0x5f60>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x8
               	b.ne	0x406448 <.text+0x5fe8>
               	ldur	x23, [x29, #-0x40]
               	stur	x23, [x29, #-0x38]
               	sub	x21, x29, #0x38
               	ldr	x23, [x21]
               	add	x22, x23, #0x8
               	str	x22, [x21]
               	ldr	x20, [x23]
               	stur	x20, [x29, #-0x40]
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x22, x20, #0x8
               	str	x22, [x23]
               	ldr	x21, [x20]
               	stur	x21, [x29, #-0x30]
               	b	0x406444 <.text+0x5fe4>
               	b	0x4063f8 <.text+0x5f98>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x9
               	b.ne	0x406468 <.text+0x6008>
               	ldur	x20, [x29, #-0x48]
               	ldr	x21, [x20]
               	stur	x21, [x29, #-0x48]
               	b	0x406464 <.text+0x6004>
               	b	0x406444 <.text+0x5fe4>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xa
               	b.ne	0x406488 <.text+0x6028>
               	ldur	x20, [x29, #-0x48]
               	ldrb	w21, [x20]
               	stur	x21, [x29, #-0x48]
               	b	0x406484 <.text+0x6024>
               	b	0x406464 <.text+0x6004>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xb
               	b.ne	0x4064b8 <.text+0x6058>
               	sub	x20, x29, #0x38
               	ldr	x21, [x20]
               	add	x22, x21, #0x8
               	str	x22, [x20]
               	ldr	x23, [x21]
               	ldur	x21, [x29, #-0x48]
               	str	x21, [x23]
               	b	0x4064b4 <.text+0x6054>
               	b	0x406484 <.text+0x6024>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xc
               	b.ne	0x4064ec <.text+0x608c>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x23, x21, #0x8
               	str	x23, [x22]
               	ldr	x20, [x21]
               	ldur	x21, [x29, #-0x48]
               	strb	w21, [x20]
               	stur	x21, [x29, #-0x48]
               	b	0x4064e8 <.text+0x6088>
               	b	0x4064b4 <.text+0x6054>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xd
               	b.ne	0x406528 <.text+0x60c8>
               	sub	x23, x29, #0x38
               	ldr	x21, [x23]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x23]
               	ldur	x20, [x29, #-0x48]
               	str	x20, [x21]
               	b	0x406524 <.text+0x60c4>
               	b	0x4064e8 <.text+0x6088>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0xe
               	b.ne	0x40655c <.text+0x60fc>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	orr	x22, x22, x20
               	stur	x22, [x29, #-0x48]
               	b	0x406558 <.text+0x60f8>
               	b	0x406524 <.text+0x60c4>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0xf
               	b.ne	0x406590 <.text+0x6130>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	eor	x23, x23, x22
               	stur	x23, [x29, #-0x48]
               	b	0x40658c <.text+0x612c>
               	b	0x406558 <.text+0x60f8>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x10
               	b.ne	0x4065c4 <.text+0x6164>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	and	x20, x20, x23
               	stur	x20, [x29, #-0x48]
               	b	0x4065c0 <.text+0x6160>
               	b	0x40658c <.text+0x612c>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x11
               	b.ne	0x4065fc <.text+0x619c>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	cmp	x22, x20
               	cset	x22, eq
               	stur	x22, [x29, #-0x48]
               	b	0x4065f8 <.text+0x6198>
               	b	0x4065c0 <.text+0x6160>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x12
               	b.ne	0x406634 <.text+0x61d4>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	cmp	x23, x22
               	cset	x23, ne
               	stur	x23, [x29, #-0x48]
               	b	0x406630 <.text+0x61d0>
               	b	0x4065f8 <.text+0x6198>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x13
               	b.ne	0x40666c <.text+0x620c>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	cmp	x20, x23
               	cset	x20, lt
               	stur	x20, [x29, #-0x48]
               	b	0x406668 <.text+0x6208>
               	b	0x406630 <.text+0x61d0>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x14
               	b.ne	0x4066a4 <.text+0x6244>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	cmp	x22, x20
               	cset	x22, gt
               	stur	x22, [x29, #-0x48]
               	b	0x4066a0 <.text+0x6240>
               	b	0x406668 <.text+0x6208>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x15
               	b.ne	0x4066dc <.text+0x627c>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	cmp	x23, x22
               	cset	x23, le
               	stur	x23, [x29, #-0x48]
               	b	0x4066d8 <.text+0x6278>
               	b	0x4066a0 <.text+0x6240>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x16
               	b.ne	0x406714 <.text+0x62b4>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	cmp	x20, x23
               	cset	x20, ge
               	stur	x20, [x29, #-0x48]
               	b	0x406710 <.text+0x62b0>
               	b	0x4066d8 <.text+0x6278>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x17
               	b.ne	0x406748 <.text+0x62e8>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	lsl	x22, x22, x20
               	stur	x22, [x29, #-0x48]
               	b	0x406744 <.text+0x62e4>
               	b	0x406710 <.text+0x62b0>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x18
               	b.ne	0x40677c <.text+0x631c>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	asr	x23, x23, x22
               	stur	x23, [x29, #-0x48]
               	b	0x406778 <.text+0x6318>
               	b	0x406744 <.text+0x62e4>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x19
               	b.ne	0x4067b0 <.text+0x6350>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	add	x20, x20, x23
               	stur	x20, [x29, #-0x48]
               	b	0x4067ac <.text+0x634c>
               	b	0x406778 <.text+0x6318>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x1a
               	b.ne	0x4067e4 <.text+0x6384>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	sub	x22, x22, x20
               	stur	x22, [x29, #-0x48]
               	b	0x4067e0 <.text+0x6380>
               	b	0x4067ac <.text+0x634c>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x1b
               	b.ne	0x406818 <.text+0x63b8>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	mul	x23, x23, x22
               	stur	x23, [x29, #-0x48]
               	b	0x406814 <.text+0x63b4>
               	b	0x4067e0 <.text+0x6380>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x1c
               	b.ne	0x40684c <.text+0x63ec>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	sdiv	x20, x20, x23
               	stur	x20, [x29, #-0x48]
               	b	0x406848 <.text+0x63e8>
               	b	0x406814 <.text+0x63b4>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x1d
               	b.ne	0x406884 <.text+0x6424>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	sdiv	x17, x22, x20
               	msub	x22, x17, x20, x22
               	stur	x22, [x29, #-0x48]
               	b	0x406880 <.text+0x6420>
               	b	0x406848 <.text+0x63e8>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x1e
               	b.ne	0x4068bc <.text+0x645c>
               	ldur	x20, [x29, #-0x38]
               	add	x22, x20, #0x8
               	ldr	x25, [x22]
               	ldr	x21, [x20]
               	mov	x0, x25
               	mov	x1, x21
               	bl	0x406d48 <open>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x4068b8 <.text+0x6458>
               	b	0x406880 <.text+0x6420>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x1f
               	b.ne	0x406900 <.text+0x64a0>
               	ldur	x21, [x29, #-0x38]
               	add	x0, x21, #0x10
               	ldr	x22, [x0]
               	add	x0, x21, #0x8
               	ldr	x25, [x0]
               	ldr	x23, [x21]
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x406d6c <read>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x4068fc <.text+0x649c>
               	b	0x4068b8 <.text+0x6458>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x20
               	b.ne	0x40692c <.text+0x64cc>
               	ldur	x23, [x29, #-0x38]
               	ldr	x21, [x23]
               	mov	x0, x21
               	bl	0x406d78 <close>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x406928 <.text+0x64c8>
               	b	0x4068fc <.text+0x649c>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x21
               	b.ne	0x406a14 <.text+0x65b4>
               	ldur	x21, [x29, #-0x38]
               	ldur	x0, [x29, #-0x30]
               	add	x0, x0, #0x8
               	ldr	x25, [x0]
               	lsl	x25, x25, #3
               	add	x21, x21, x25
               	stur	x21, [x29, #-0x60]
               	ldur	x25, [x29, #-0x60]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x23, [x21]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x24, [x21]
               	mov	x17, #0xffe8            // =65512
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x22, [x21]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x20, [x21]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x27, [x21]
               	mov	x17, #0xffd0            // =65488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x25, x25, x17
               	ldr	x26, [x25]
               	mov	x0, x23
               	mov	x5, x26
               	mov	x4, x27
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x406a10 <.text+0x65b0>
               	b	0x406928 <.text+0x64c8>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x22
               	b.ne	0x406a3c <.text+0x65dc>
               	ldur	x26, [x29, #-0x38]
               	ldr	x25, [x26]
               	mov	x0, x25
               	bl	0x406d54 <malloc>
               	stur	x0, [x29, #-0x48]
               	b	0x406a38 <.text+0x65d8>
               	b	0x406a10 <.text+0x65b0>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x23
               	b.ne	0x406a64 <.text+0x6604>
               	ldur	x25, [x29, #-0x38]
               	ldr	x26, [x25]
               	mov	x0, x26
               	bl	0x406d84 <free>
               	sxtw	x0, w0
               	b	0x406a60 <.text+0x6600>
               	b	0x406a38 <.text+0x65d8>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x24
               	b.ne	0x406aa4 <.text+0x6644>
               	ldur	x0, [x29, #-0x38]
               	add	x26, x0, #0x10
               	ldr	x25, [x26]
               	add	x26, x0, #0x8
               	ldr	x27, [x26]
               	ldr	x20, [x0]
               	mov	x0, x25
               	mov	x2, x20
               	mov	x1, x27
               	bl	0x406d60 <memset>
               	stur	x0, [x29, #-0x48]
               	b	0x406aa0 <.text+0x6640>
               	b	0x406a60 <.text+0x6600>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x25
               	b.ne	0x406ae8 <.text+0x6688>
               	ldur	x20, [x29, #-0x38]
               	add	x0, x20, #0x10
               	ldr	x26, [x0]
               	add	x0, x20, #0x8
               	ldr	x27, [x0]
               	ldr	x25, [x20]
               	mov	x0, x26
               	mov	x2, x25
               	mov	x1, x27
               	bl	0x406d30 <memcmp>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x406ae4 <.text+0x6684>
               	b	0x406aa0 <.text+0x6640>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x26
               	b.ne	0x406b64 <.text+0x6704>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x881
               	mov	x20, x19
               	ldur	x0, [x29, #-0x38]
               	ldr	x25, [x0]
               	ldur	x27, [x29, #-0x50]
               	mov	x0, x20
               	mov	x2, x27
               	mov	x1, x25
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	ldur	x0, [x29, #-0x38]
               	ldr	x27, [x0]
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	b	0x406ae4 <.text+0x6684>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x896
               	mov	x26, x19
               	ldur	x21, [x29, #-0x58]
               	ldur	x27, [x29, #-0x50]
               	mov	x0, x26
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
