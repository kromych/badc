
c4.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x404a78 <.text+0x4618>
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
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x4004ec <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x138
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
               	add	x19, x19, #0x150
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x156
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x15d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x406d18 <dlsym>
               	cbz	x0, 0x400574 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x138
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400574 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x138
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
               	b	0x4005dc <.text+0x17c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x15, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x14, x19
               	ldr	x13, [x14]
               	ldrb	w14, [x13]
               	str	x14, [x15]
               	cbz	x14, 0x400638 <.text+0x1d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x13, x19
               	ldr	x14, [x13]
               	add	x15, x14, #0x1
               	str	x15, [x13]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x14, x19
               	ldr	x15, [x14]
               	cmp	x15, #0xa
               	b.ne	0x40068c <.text+0x22c>
               	b	0x400670 <.text+0x210>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
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
               	cbz	x14, 0x400710 <.text+0x2b0>
               	b	0x4006a8 <.text+0x248>
               	b	0x4005dc <.text+0x17c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x23
               	b.ne	0x400820 <.text+0x3c0>
               	b	0x400818 <.text+0x3b8>
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
               	b	0x40072c <.text+0x2cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x25, x0, #0x1
               	str	x25, [x22]
               	b	0x400688 <.text+0x228>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x0, x19
               	ldr	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x22, x23
               	b.ge	0x4007b8 <.text+0x358>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x201
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x207
               	mov	x0, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x24, x25, #0x8
               	str	x24, [x23]
               	ldr	x25, [x24]
               	mov	x17, #0x5               // =5
               	mul	x24, x25, x17
               	add	x22, x0, x24
               	mov	x0, x26
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	ldr	x0, [x23]
               	ldr	x23, [x0]
               	cmp	x23, #0x7
               	b.gt	0x4007fc <.text+0x39c>
               	b	0x4007bc <.text+0x35c>
               	b	0x400710 <.text+0x2b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2cb
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x26, x22, #0x8
               	str	x26, [x0]
               	ldr	x23, [x26]
               	mov	x0, x25
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	b	0x4007f8 <.text+0x398>
               	b	0x40072c <.text+0x2cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d0
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	b	0x4007f8 <.text+0x398>
               	b	0x400844 <.text+0x3e4>
               	b	0x400688 <.text+0x228>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x61
               	cset	x22, ge
               	stur	x22, [x29, #-0x48]
               	cbz	x22, 0x4008fc <.text+0x49c>
               	b	0x4008dc <.text+0x47c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x25, [x0]
               	ldrb	w0, [x25]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	cmp	x25, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	cbz	x0, 0x4008d0 <.text+0x470>
               	b	0x400898 <.text+0x438>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x22, x0, #0x1
               	str	x22, [x25]
               	b	0x400844 <.text+0x3e4>
               	b	0x40081c <.text+0x3bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x0, [x25]
               	ldrb	w25, [x0]
               	mov	x17, #0xa               // =10
               	eor	x0, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	cmp	x25, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	b	0x4008d0 <.text+0x470>
               	ldur	x0, [x29, #-0x30]
               	cbz	x0, 0x400894 <.text+0x434>
               	b	0x400878 <.text+0x418>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x7a
               	cset	x0, le
               	stur	x0, [x29, #-0x48]
               	b	0x4008fc <.text+0x49c>
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x40]
               	cbnz	x0, 0x40092c <.text+0x4cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x41
               	cset	x22, ge
               	stur	x22, [x29, #-0x50]
               	cbz	x22, 0x40095c <.text+0x4fc>
               	b	0x40093c <.text+0x4dc>
               	ldur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x38]
               	cbnz	x0, 0x400988 <.text+0x528>
               	b	0x400968 <.text+0x508>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x5a
               	cset	x0, le
               	stur	x0, [x29, #-0x50]
               	b	0x40095c <.text+0x4fc>
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x40]
               	b	0x40092c <.text+0x4cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x5f
               	cset	x22, eq
               	stur	x22, [x29, #-0x38]
               	b	0x400988 <.text+0x528>
               	ldur	x22, [x29, #-0x38]
               	cbz	x22, 0x4009ac <.text+0x54c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x22, [x0]
               	sub	x23, x22, #0x1
               	b	0x4009d0 <.text+0x570>
               	b	0x40081c <.text+0x3bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x22, [x27]
               	cmp	x22, #0x30
               	cset	x27, ge
               	stur	x27, [x29, #-0x90]
               	cbz	x27, 0x400d90 <.text+0x930>
               	b	0x400d70 <.text+0x910>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x61
               	cset	x25, ge
               	stur	x25, [x29, #-0x70]
               	cbz	x25, 0x400ab0 <.text+0x650>
               	b	0x400a8c <.text+0x62c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x25, [x22]
               	mov	x17, #0x93              // =147
               	mul	x26, x25, x17
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x21, x24, #0x1
               	str	x21, [x25]
               	ldrb	w20, [x24]
               	add	x24, x26, x20
               	str	x24, [x22]
               	b	0x4009d0 <.text+0x570>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x20, [x24]
               	lsl	x22, x20, #6
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x26, [x20]
               	sub	x20, x26, x23
               	add	x26, x22, x20
               	str	x26, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x26, x19
               	ldr	x24, [x26]
               	str	x24, [x20]
               	b	0x400bd0 <.text+0x770>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x7a
               	cset	x25, le
               	stur	x25, [x29, #-0x70]
               	b	0x400ab0 <.text+0x650>
               	ldur	x25, [x29, #-0x70]
               	stur	x25, [x29, #-0x68]
               	cbnz	x25, 0x400ae4 <.text+0x684>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x41
               	cset	x25, ge
               	stur	x25, [x29, #-0x78]
               	cbz	x25, 0x400b18 <.text+0x6b8>
               	b	0x400af4 <.text+0x694>
               	ldur	x25, [x29, #-0x68]
               	stur	x25, [x29, #-0x60]
               	cbnz	x25, 0x400b4c <.text+0x6ec>
               	b	0x400b24 <.text+0x6c4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x5a
               	cset	x25, le
               	stur	x25, [x29, #-0x78]
               	b	0x400b18 <.text+0x6b8>
               	ldur	x25, [x29, #-0x78]
               	stur	x25, [x29, #-0x68]
               	b	0x400ae4 <.text+0x684>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x30
               	cset	x25, ge
               	stur	x25, [x29, #-0x80]
               	cbz	x25, 0x400b80 <.text+0x720>
               	b	0x400b5c <.text+0x6fc>
               	ldur	x25, [x29, #-0x60]
               	stur	x25, [x29, #-0x58]
               	cbnz	x25, 0x400bc4 <.text+0x764>
               	b	0x400b8c <.text+0x72c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x39
               	cset	x25, le
               	stur	x25, [x29, #-0x80]
               	b	0x400b80 <.text+0x720>
               	ldur	x25, [x29, #-0x80]
               	stur	x25, [x29, #-0x60]
               	b	0x400b4c <.text+0x6ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	mov	x17, #0x5f              // =95
               	eor	x25, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x25, x17
               	cmp	x22, #0x0
               	cset	x25, eq
               	stur	x25, [x29, #-0x58]
               	b	0x400bc4 <.text+0x764>
               	ldur	x25, [x29, #-0x58]
               	cbz	x25, 0x400a38 <.text+0x5d8>
               	b	0x4009f8 <.text+0x598>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x26, [x24]
               	ldr	x24, [x26]
               	cbz	x24, 0x400c24 <.text+0x7c4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x20, [x26]
               	add	x26, x20, #0x8
               	ldr	x20, [x26]
               	cmp	x24, x20
               	cset	x26, eq
               	stur	x26, [x29, #-0x88]
               	cbz	x26, 0x400cf0 <.text+0x890>
               	b	0x400ca0 <.text+0x840>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x27, x26, #0x10
               	str	x23, [x27]
               	ldr	x26, [x22]
               	add	x27, x26, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x23, [x26]
               	str	x23, [x27]
               	ldr	x0, [x22]
               	mov	x22, #0x0               // =0
               	mov	x23, #0x85              // =133
               	str	x23, [x0]
               	str	x23, [x26]
               	mov	x0, x22
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
               	ldr	x26, [x20]
               	add	x20, x26, #0x10
               	ldr	x27, [x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x24, [x20]
               	sub	x26, x24, x23
               	mov	x0, x27
               	mov	x2, x26
               	mov	x1, x23
               	bl	0x406d30 <memcmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x26, eq
               	stur	x26, [x29, #-0x88]
               	b	0x400cf0 <.text+0x890>
               	ldur	x26, [x29, #-0x88]
               	cbz	x26, 0x400d54 <.text+0x8f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x27, [x26]
               	mov	x26, #0x0               // =0
               	ldr	x22, [x27]
               	str	x22, [x0]
               	mov	x0, x26
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
               	ldr	x26, [x27]
               	add	x22, x26, #0x48
               	str	x22, [x27]
               	b	0x400bd0 <.text+0x770>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x27, [x22]
               	cmp	x27, #0x39
               	cset	x22, le
               	stur	x22, [x29, #-0x90]
               	b	0x400d90 <.text+0x930>
               	ldur	x22, [x29, #-0x90]
               	cbz	x22, 0x400dc8 <.text+0x968>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x23, [x22]
               	sub	x22, x23, #0x30
               	str	x22, [x27]
               	cbz	x22, 0x400e34 <.text+0x9d4>
               	b	0x400de4 <.text+0x984>
               	b	0x4009a8 <.text+0x548>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x23, [x26]
               	cmp	x23, #0x2f
               	b.ne	0x4011ec <.text+0xd8c>
               	b	0x4011b4 <.text+0xd54>
               	b	0x400e70 <.text+0xa10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x26, #0x80              // =128
               	str	x26, [x22]
               	mov	x23, #0x0               // =0
               	mov	x0, x23
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
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x78              // =120
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	cset	x26, eq
               	stur	x26, [x29, #-0xa0]
               	cbnz	x26, 0x400f48 <.text+0xae8>
               	b	0x400f10 <.text+0xab0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldrb	w23, [x22]
               	cmp	x23, #0x30
               	cset	x22, ge
               	stur	x22, [x29, #-0x98]
               	cbz	x22, 0x400f04 <.text+0xaa4>
               	b	0x400ee0 <.text+0xa80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x22, [x23]
               	mov	x17, #0xa               // =10
               	mul	x27, x22, x17
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x0, x26, #0x1
               	str	x0, [x22]
               	ldrb	w21, [x26]
               	add	x26, x27, x21
               	sub	x21, x26, #0x30
               	str	x21, [x23]
               	b	0x400e70 <.text+0xa10>
               	b	0x400de8 <.text+0x988>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldrb	w23, [x22]
               	cmp	x23, #0x39
               	cset	x22, le
               	stur	x22, [x29, #-0x98]
               	b	0x400f04 <.text+0xaa4>
               	ldur	x22, [x29, #-0x98]
               	cbz	x22, 0x400edc <.text+0xa7c>
               	b	0x400e98 <.text+0xa38>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x58              // =88
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	cset	x26, eq
               	stur	x26, [x29, #-0xa0]
               	b	0x400f48 <.text+0xae8>
               	ldur	x26, [x29, #-0xa0]
               	cbz	x26, 0x400f58 <.text+0xaf8>
               	b	0x400f5c <.text+0xafc>
               	b	0x400de8 <.text+0x988>
               	b	0x401118 <.text+0xcb8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x23, [x26]
               	add	x27, x23, #0x1
               	str	x27, [x26]
               	ldrb	w23, [x27]
               	str	x23, [x21]
               	stur	x23, [x29, #-0xa8]
               	cbz	x23, 0x400ffc <.text+0xb9c>
               	b	0x400fd8 <.text+0xb78>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x27, x19
               	ldr	x23, [x27]
               	lsl	x21, x23, #4
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	mov	x17, #0xf               // =15
               	and	x0, x26, x17
               	add	x26, x21, x0
               	ldr	x0, [x23]
               	cmp	x0, #0x41
               	b.lt	0x4010fc <.text+0xc9c>
               	b	0x4010f0 <.text+0xc90>
               	b	0x400f54 <.text+0xaf4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x23, [x27]
               	cmp	x23, #0x30
               	cset	x27, ge
               	stur	x27, [x29, #-0xc0]
               	cbz	x27, 0x401028 <.text+0xbc8>
               	b	0x401008 <.text+0xba8>
               	ldur	x23, [x29, #-0xa8]
               	cbz	x23, 0x400fd4 <.text+0xb74>
               	b	0x400f94 <.text+0xb34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x27, [x23]
               	cmp	x27, #0x39
               	cset	x23, le
               	stur	x23, [x29, #-0xc0]
               	b	0x401028 <.text+0xbc8>
               	ldur	x23, [x29, #-0xc0]
               	stur	x23, [x29, #-0xb8]
               	cbnz	x23, 0x401058 <.text+0xbf8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x23, [x27]
               	cmp	x23, #0x61
               	cset	x27, ge
               	stur	x27, [x29, #-0xc8]
               	cbz	x27, 0x401088 <.text+0xc28>
               	b	0x401068 <.text+0xc08>
               	ldur	x23, [x29, #-0xb8]
               	stur	x23, [x29, #-0xb0]
               	cbnz	x23, 0x4010b8 <.text+0xc58>
               	b	0x401094 <.text+0xc34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x27, [x23]
               	cmp	x27, #0x66
               	cset	x23, le
               	stur	x23, [x29, #-0xc8]
               	b	0x401088 <.text+0xc28>
               	ldur	x23, [x29, #-0xc8]
               	stur	x23, [x29, #-0xb8]
               	b	0x401058 <.text+0xbf8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x23, [x27]
               	cmp	x23, #0x41
               	cset	x27, ge
               	stur	x27, [x29, #-0xd0]
               	cbz	x27, 0x4010e4 <.text+0xc84>
               	b	0x4010c4 <.text+0xc64>
               	ldur	x23, [x29, #-0xb0]
               	stur	x23, [x29, #-0xa8]
               	b	0x400ffc <.text+0xb9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x27, [x23]
               	cmp	x27, #0x46
               	cset	x23, le
               	stur	x23, [x29, #-0xd0]
               	b	0x4010e4 <.text+0xc84>
               	ldur	x23, [x29, #-0xd0]
               	stur	x23, [x29, #-0xb0]
               	b	0x4010b8 <.text+0xc58>
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0xd8]
               	b	0x401108 <.text+0xca8>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0xd8]
               	b	0x401108 <.text+0xca8>
               	ldur	x0, [x29, #-0xd8]
               	add	x23, x26, x0
               	str	x23, [x27]
               	b	0x400f5c <.text+0xafc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x0, [x23]
               	ldrb	w23, [x0]
               	cmp	x23, #0x30
               	cset	x0, ge
               	stur	x0, [x29, #-0xe0]
               	cbz	x0, 0x4011a8 <.text+0xd48>
               	b	0x401184 <.text+0xd24>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x0, [x23]
               	lsl	x27, x0, #3
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x21, x26, #0x1
               	str	x21, [x0]
               	ldrb	w22, [x26]
               	add	x26, x27, x22
               	sub	x22, x26, #0x30
               	str	x22, [x23]
               	b	0x401118 <.text+0xcb8>
               	b	0x400f54 <.text+0xaf4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x0, [x23]
               	ldrb	w23, [x0]
               	cmp	x23, #0x37
               	cset	x0, le
               	stur	x0, [x29, #-0xe0]
               	b	0x4011a8 <.text+0xd48>
               	ldur	x0, [x29, #-0xe0]
               	cbz	x0, 0x401180 <.text+0xd20>
               	b	0x401140 <.text+0xce0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x26, [x23]
               	ldrb	w23, [x26]
               	mov	x17, #0x2f              // =47
               	eor	x26, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x26, x17
               	cmp	x23, #0x0
               	b.ne	0x401230 <.text+0xdd0>
               	b	0x401210 <.text+0xdb0>
               	b	0x400dc4 <.text+0x964>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x26, [x22]
               	cmp	x26, #0x27
               	cset	x22, eq
               	stur	x22, [x29, #-0xf0]
               	cbnz	x22, 0x401334 <.text+0xed4>
               	b	0x401314 <.text+0xeb4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x26, [x23]
               	add	x22, x26, #0x1
               	str	x22, [x23]
               	b	0x40127c <.text+0xe1c>
               	b	0x4011e8 <.text+0xd88>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	mov	x22, #0xa0              // =160
               	str	x22, [x23]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
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
               	ldr	x26, [x22]
               	ldrb	w22, [x26]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x22, x17
               	cmp	x26, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xe8]
               	cbz	x22, 0x401308 <.text+0xea8>
               	b	0x4012d0 <.text+0xe70>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x22, [x26]
               	add	x23, x22, #0x1
               	str	x23, [x26]
               	b	0x40127c <.text+0xe1c>
               	b	0x40122c <.text+0xdcc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x22, [x26]
               	ldrb	w26, [x22]
               	mov	x17, #0xa               // =10
               	eor	x22, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x22, x17
               	cmp	x26, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xe8]
               	b	0x401308 <.text+0xea8>
               	ldur	x22, [x29, #-0xe8]
               	cbz	x22, 0x4012cc <.text+0xe6c>
               	b	0x4012b0 <.text+0xe50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x22, [x26]
               	cmp	x22, #0x22
               	cset	x26, eq
               	stur	x26, [x29, #-0xf0]
               	b	0x401334 <.text+0xed4>
               	ldur	x26, [x29, #-0xf0]
               	cbz	x26, 0x401354 <.text+0xef4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x26, [x22]
               	b	0x401370 <.text+0xf10>
               	b	0x4011e8 <.text+0xd88>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x3d
               	b.ne	0x401590 <.text+0x1130>
               	b	0x401558 <.text+0x10f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x23, [x22]
               	ldrb	w22, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x22, x17
               	cmp	x23, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xf8]
               	cbz	x22, 0x401444 <.text+0xfe4>
               	b	0x401410 <.text+0xfb0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x21, x23, #0x1
               	str	x21, [x22]
               	ldrb	w0, [x23]
               	str	x0, [x27]
               	cmp	x0, #0x5c
               	b.ne	0x401488 <.text+0x1028>
               	b	0x401450 <.text+0xff0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x21, [x22]
               	add	x27, x21, #0x1
               	str	x27, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x27, [x21]
               	cmp	x27, #0x22
               	b.ne	0x401540 <.text+0x10e0>
               	b	0x4014f4 <.text+0x1094>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldrb	w23, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x27, [x22]
               	cmp	x23, x27
               	cset	x22, ne
               	stur	x22, [x29, #-0xf8]
               	b	0x401444 <.text+0xfe4>
               	ldur	x22, [x29, #-0xf8]
               	cbz	x22, 0x4013dc <.text+0xf7c>
               	b	0x4013a4 <.text+0xf44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x27, [x23]
               	add	x21, x27, #0x1
               	str	x21, [x23]
               	ldrb	w22, [x27]
               	str	x22, [x0]
               	cmp	x22, #0x6e
               	b.ne	0x4014bc <.text+0x105c>
               	b	0x4014a4 <.text+0x1044>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x0, [x27]
               	cmp	x0, #0x22
               	b.ne	0x4014f0 <.text+0x1090>
               	b	0x4014c0 <.text+0x1060>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x22, x19
               	mov	x27, #0xa               // =10
               	str	x27, [x22]
               	b	0x4014bc <.text+0x105c>
               	b	0x401488 <.text+0x1028>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x0, x19
               	ldr	x27, [x0]
               	add	x22, x27, #0x1
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	ldr	x22, [x21]
               	strb	w22, [x27]
               	b	0x4014f0 <.text+0x1090>
               	b	0x401370 <.text+0xf10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x27, x19
               	str	x26, [x27]
               	b	0x401508 <.text+0x10a8>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	mov	x21, #0x80              // =128
               	str	x21, [x27]
               	b	0x401508 <.text+0x10a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x3d              // =61
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	b.ne	0x401614 <.text+0x11b4>
               	b	0x4015ac <.text+0x114c>
               	b	0x401350 <.text+0xef0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x2b
               	b.ne	0x401664 <.text+0x1204>
               	b	0x40162c <.text+0x11cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x27, x26, #0x1
               	str	x27, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x27, #0x95              // =149
               	str	x27, [x26]
               	b	0x4015dc <.text+0x117c>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	mov	x21, #0x8e              // =142
               	str	x21, [x27]
               	b	0x4015dc <.text+0x117c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x2b              // =43
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	b.ne	0x4016e8 <.text+0x1288>
               	b	0x401680 <.text+0x1220>
               	b	0x40158c <.text+0x112c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x2d
               	b.ne	0x401738 <.text+0x12d8>
               	b	0x401700 <.text+0x12a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x27, x26, #0x1
               	str	x27, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x27, #0xa2              // =162
               	str	x27, [x26]
               	b	0x4016b0 <.text+0x1250>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	mov	x21, #0x9d              // =157
               	str	x21, [x27]
               	b	0x4016b0 <.text+0x1250>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x2d              // =45
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	b.ne	0x4017bc <.text+0x135c>
               	b	0x401754 <.text+0x12f4>
               	b	0x401660 <.text+0x1200>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x21
               	b.ne	0x40180c <.text+0x13ac>
               	b	0x4017d4 <.text+0x1374>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x27, x26, #0x1
               	str	x27, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x27, #0xa3              // =163
               	str	x27, [x26]
               	b	0x401784 <.text+0x1324>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	mov	x21, #0x9e              // =158
               	str	x21, [x27]
               	b	0x401784 <.text+0x1324>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x3d              // =61
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	b.ne	0x401858 <.text+0x13f8>
               	b	0x401828 <.text+0x13c8>
               	b	0x401734 <.text+0x12d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x27, [x21]
               	cmp	x27, #0x3c
               	b.ne	0x4018c8 <.text+0x1468>
               	b	0x401890 <.text+0x1430>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x27, x26, #0x1
               	str	x27, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x27, #0x96              // =150
               	str	x27, [x26]
               	b	0x401858 <.text+0x13f8>
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
               	ldr	x21, [x27]
               	ldrb	w27, [x21]
               	mov	x17, #0x3d              // =61
               	eor	x21, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x21, x17
               	cmp	x27, #0x0
               	b.ne	0x40194c <.text+0x14ec>
               	b	0x4018e4 <.text+0x1484>
               	b	0x401808 <.text+0x13a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x26, [x27]
               	cmp	x26, #0x3e
               	b.ne	0x401a00 <.text+0x15a0>
               	b	0x4019c8 <.text+0x1568>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x21, [x27]
               	add	x26, x21, #0x1
               	str	x26, [x27]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x26, #0x99              // =153
               	str	x26, [x21]
               	b	0x401914 <.text+0x14b4>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
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
               	mov	x26, x19
               	ldr	x27, [x26]
               	ldrb	w26, [x27]
               	mov	x17, #0x3c              // =60
               	eor	x27, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x27, x17
               	cmp	x26, #0x0
               	b.ne	0x4019b0 <.text+0x1550>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x27, [x26]
               	add	x21, x27, #0x1
               	str	x21, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x21, #0x9b              // =155
               	str	x21, [x27]
               	b	0x4019ac <.text+0x154c>
               	b	0x401914 <.text+0x14b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x26, #0x97              // =151
               	str	x26, [x21]
               	b	0x4019ac <.text+0x154c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x27, [x26]
               	ldrb	w26, [x27]
               	mov	x17, #0x3d              // =61
               	eor	x27, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x27, x17
               	cmp	x26, #0x0
               	b.ne	0x401a84 <.text+0x1624>
               	b	0x401a1c <.text+0x15bc>
               	b	0x4018c4 <.text+0x1464>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x7c
               	b.ne	0x401b38 <.text+0x16d8>
               	b	0x401b00 <.text+0x16a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x27, [x26]
               	add	x21, x27, #0x1
               	str	x21, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x21, #0x9a              // =154
               	str	x21, [x27]
               	b	0x401a4c <.text+0x15ec>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x3e              // =62
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	b.ne	0x401ae8 <.text+0x1688>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x27, x26, #0x1
               	str	x27, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x27, #0x9c              // =156
               	str	x27, [x26]
               	b	0x401ae4 <.text+0x1684>
               	b	0x401a4c <.text+0x15ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x21, #0x98              // =152
               	str	x21, [x27]
               	b	0x401ae4 <.text+0x1684>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x7c              // =124
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	b.ne	0x401bbc <.text+0x175c>
               	b	0x401b54 <.text+0x16f4>
               	b	0x4019fc <.text+0x159c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x26
               	b.ne	0x401c0c <.text+0x17ac>
               	b	0x401bd4 <.text+0x1774>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x27, x26, #0x1
               	str	x27, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x27, #0x90              // =144
               	str	x27, [x26]
               	b	0x401b84 <.text+0x1724>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	mov	x21, #0x92              // =146
               	str	x21, [x27]
               	b	0x401b84 <.text+0x1724>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	ldrb	w21, [x26]
               	mov	x17, #0x26              // =38
               	eor	x26, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	cmp	x21, #0x0
               	b.ne	0x401c90 <.text+0x1830>
               	b	0x401c28 <.text+0x17c8>
               	b	0x401b34 <.text+0x16d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x5e
               	b.ne	0x401cf8 <.text+0x1898>
               	b	0x401ca8 <.text+0x1848>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x27, x26, #0x1
               	str	x27, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x27, #0x91              // =145
               	str	x27, [x26]
               	b	0x401c58 <.text+0x17f8>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	mov	x21, #0x94              // =148
               	str	x21, [x27]
               	b	0x401c58 <.text+0x17f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x26, #0x93              // =147
               	str	x26, [x21]
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
               	b	0x401c08 <.text+0x17a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x27, [x26]
               	cmp	x27, #0x25
               	b.ne	0x401d60 <.text+0x1900>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x26, #0xa1              // =161
               	str	x26, [x27]
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	b	0x401cf4 <.text+0x1894>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x2a
               	b.ne	0x401dc8 <.text+0x1968>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x26, #0x9f              // =159
               	str	x26, [x21]
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
               	b	0x401d5c <.text+0x18fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x27, [x26]
               	cmp	x27, #0x5b
               	b.ne	0x401e30 <.text+0x19d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x26, #0xa4              // =164
               	str	x26, [x27]
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	b	0x401dc4 <.text+0x1964>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x3f
               	b.ne	0x401e98 <.text+0x1a38>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x26, #0x8f              // =143
               	str	x26, [x21]
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
               	b	0x401e2c <.text+0x19cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x27, [x26]
               	cmp	x27, #0x7e
               	cset	x26, eq
               	sub	x17, x29, #0x138
               	str	x26, [x17]
               	cbnz	x26, 0x401ee0 <.text+0x1a80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x26, [x27]
               	cmp	x26, #0x3b
               	cset	x27, eq
               	sub	x17, x29, #0x138
               	str	x27, [x17]
               	b	0x401ee0 <.text+0x1a80>
               	sub	x16, x29, #0x138
               	ldr	x27, [x16]
               	sub	x17, x29, #0x130
               	str	x27, [x17]
               	cbnz	x27, 0x401f18 <.text+0x1ab8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x27, [x26]
               	cmp	x27, #0x7b
               	cset	x26, eq
               	sub	x17, x29, #0x130
               	str	x26, [x17]
               	b	0x401f18 <.text+0x1ab8>
               	sub	x16, x29, #0x130
               	ldr	x26, [x16]
               	sub	x17, x29, #0x128
               	str	x26, [x17]
               	cbnz	x26, 0x401f50 <.text+0x1af0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x26, [x27]
               	cmp	x26, #0x7d
               	cset	x27, eq
               	sub	x17, x29, #0x128
               	str	x27, [x17]
               	b	0x401f50 <.text+0x1af0>
               	sub	x16, x29, #0x128
               	ldr	x27, [x16]
               	sub	x17, x29, #0x120
               	str	x27, [x17]
               	cbnz	x27, 0x401f88 <.text+0x1b28>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x27, [x26]
               	cmp	x27, #0x28
               	cset	x26, eq
               	sub	x17, x29, #0x120
               	str	x26, [x17]
               	b	0x401f88 <.text+0x1b28>
               	sub	x16, x29, #0x120
               	ldr	x26, [x16]
               	sub	x17, x29, #0x118
               	str	x26, [x17]
               	cbnz	x26, 0x401fc0 <.text+0x1b60>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x26, [x27]
               	cmp	x26, #0x29
               	cset	x27, eq
               	sub	x17, x29, #0x118
               	str	x27, [x17]
               	b	0x401fc0 <.text+0x1b60>
               	sub	x16, x29, #0x118
               	ldr	x27, [x16]
               	sub	x17, x29, #0x110
               	str	x27, [x17]
               	cbnz	x27, 0x401ff8 <.text+0x1b98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x27, [x26]
               	cmp	x27, #0x5d
               	cset	x26, eq
               	sub	x17, x29, #0x110
               	str	x26, [x17]
               	b	0x401ff8 <.text+0x1b98>
               	sub	x16, x29, #0x110
               	ldr	x26, [x16]
               	sub	x17, x29, #0x108
               	str	x26, [x17]
               	cbnz	x26, 0x402030 <.text+0x1bd0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x26, [x27]
               	cmp	x26, #0x2c
               	cset	x27, eq
               	sub	x17, x29, #0x108
               	str	x27, [x17]
               	b	0x402030 <.text+0x1bd0>
               	sub	x16, x29, #0x108
               	ldr	x27, [x16]
               	stur	x27, [x29, #-0x100]
               	cbnz	x27, 0x402060 <.text+0x1c00>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x27, [x26]
               	cmp	x27, #0x3a
               	cset	x26, eq
               	stur	x26, [x29, #-0x100]
               	b	0x402060 <.text+0x1c00>
               	ldur	x26, [x29, #-0x100]
               	cbz	x26, 0x4020a0 <.text+0x1c40>
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
               	b	0x401e94 <.text+0x1a34>
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
               	b.ne	0x40213c <.text+0x1cdc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d2
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x14, x19
               	ldr	x22, [x14]
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
               	b	0x402138 <.text+0x1cd8>
               	b	0x40323c <.text+0x2ddc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x80
               	b.ne	0x4021b0 <.text+0x1d50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x21, x23, #0x8
               	str	x21, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x21]
               	ldr	x11, [x0]
               	add	x21, x11, #0x8
               	str	x21, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x11, x19
               	ldr	x0, [x11]
               	str	x0, [x21]
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x22, [x0]
               	b	0x4021ac <.text+0x1d4c>
               	b	0x402138 <.text+0x1cd8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x11, [x0]
               	cmp	x11, #0x22
               	b.ne	0x402214 <.text+0x1db4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x11, x19
               	ldr	x0, [x11]
               	add	x22, x0, #0x8
               	str	x22, [x11]
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	ldr	x21, [x11]
               	add	x0, x21, #0x8
               	str	x0, [x11]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	ldr	x11, [x21]
               	str	x11, [x0]
               	bl	0x4005a8 <.text+0x148>
               	b	0x402230 <.text+0x1dd0>
               	b	0x4021ac <.text+0x1d4c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x8c
               	b.ne	0x4022b8 <.text+0x1e58>
               	b	0x402294 <.text+0x1e34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x11, x19
               	ldr	x0, [x11]
               	cmp	x0, #0x22
               	b.ne	0x402250 <.text+0x1df0>
               	bl	0x4005a8 <.text+0x148>
               	b	0x402230 <.text+0x1dd0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x21, x0, #0x8
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x21, x17
               	str	x0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x0, #0x2                // =2
               	str	x0, [x21]
               	b	0x402210 <.text+0x1db0>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x28
               	b.ne	0x40230c <.text+0x1eac>
               	b	0x4022d4 <.text+0x1e74>
               	b	0x402210 <.text+0x1db0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x85
               	b.ne	0x4024f8 <.text+0x2098>
               	b	0x4024c0 <.text+0x2060>
               	bl	0x4005a8 <.text+0x148>
               	b	0x4022dc <.text+0x1e7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x8a
               	b.ne	0x402364 <.text+0x1f04>
               	b	0x402358 <.text+0x1ef8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f4
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x24
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x4022dc <.text+0x1e7c>
               	bl	0x4005a8 <.text+0x148>
               	b	0x402360 <.text+0x1f00>
               	b	0x40239c <.text+0x1f3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x86
               	b.ne	0x402398 <.text+0x1f38>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x24, #0x0               // =0
               	str	x24, [x0]
               	b	0x402398 <.text+0x1f38>
               	b	0x402360 <.text+0x1f00>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x9f
               	b.ne	0x4023d4 <.text+0x1f74>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x21, x23, #0x2
               	str	x21, [x0]
               	b	0x40239c <.text+0x1f3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x29
               	b.ne	0x40243c <.text+0x1fdc>
               	bl	0x4005a8 <.text+0x148>
               	b	0x4023f4 <.text+0x1f94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x21, x0, #0x8
               	str	x21, [x23]
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	ldr	x22, [x23]
               	add	x0, x22, #0x8
               	str	x0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x23, [x22]
               	cmp	x23, #0x0
               	b.ne	0x402494 <.text+0x2034>
               	b	0x402488 <.text+0x2028>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x317
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x24, [x0]
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
               	b	0x4023f4 <.text+0x1f94>
               	mov	x23, #0x1               // =1
               	stur	x23, [x29, #-0x30]
               	b	0x4024a0 <.text+0x2040>
               	mov	x23, #0x8               // =8
               	stur	x23, [x29, #-0x30]
               	b	0x4024a0 <.text+0x2040>
               	ldur	x23, [x29, #-0x30]
               	str	x23, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x22]
               	b	0x4022b4 <.text+0x1e54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x23, [x0]
               	stur	x23, [x29, #-0x10]
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x28
               	b.ne	0x402528 <.text+0x20c8>
               	b	0x402514 <.text+0x20b4>
               	b	0x4022b4 <.text+0x1e54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0x28
               	b.ne	0x402900 <.text+0x24a0>
               	b	0x4028d4 <.text+0x2474>
               	bl	0x4005a8 <.text+0x148>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	0x402540 <.text+0x20e0>
               	b	0x4024f4 <.text+0x2094>
               	ldur	x0, [x29, #-0x10]
               	add	x23, x0, #0x18
               	ldr	x0, [x23]
               	cmp	x0, #0x80
               	b.ne	0x402764 <.text+0x2304>
               	b	0x402710 <.text+0x22b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x29
               	b.eq	0x4025b0 <.text+0x2150>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x22, x23, #0x8
               	str	x22, [x0]
               	mov	x23, #0xd               // =13
               	str	x23, [x22]
               	sub	x0, x29, #0x8
               	ldr	x23, [x0]
               	add	x22, x23, #0x1
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0x2c
               	b.ne	0x4025d8 <.text+0x2178>
               	b	0x4025cc <.text+0x216c>
               	bl	0x4005a8 <.text+0x148>
               	ldur	x0, [x29, #-0x10]
               	add	x23, x0, #0x18
               	ldr	x0, [x23]
               	cmp	x0, #0x82
               	b.ne	0x402614 <.text+0x21b4>
               	b	0x4025dc <.text+0x217c>
               	bl	0x4005a8 <.text+0x148>
               	mov	x23, x0
               	b	0x4025d8 <.text+0x2178>
               	b	0x402540 <.text+0x20e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x24, x23, #0x8
               	str	x24, [x0]
               	ldur	x23, [x29, #-0x10]
               	add	x0, x23, #0x28
               	ldr	x23, [x0]
               	str	x23, [x24]
               	b	0x402608 <.text+0x21a8>
               	ldur	x23, [x29, #-0x8]
               	cbz	x23, 0x4026f0 <.text+0x2290>
               	b	0x4026b8 <.text+0x2258>
               	ldur	x23, [x29, #-0x10]
               	add	x0, x23, #0x18
               	ldr	x23, [x0]
               	cmp	x23, #0x81
               	b.ne	0x40266c <.text+0x220c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x24, x0, #0x8
               	str	x24, [x23]
               	mov	x0, #0x3                // =3
               	str	x0, [x24]
               	ldr	x21, [x23]
               	add	x0, x21, #0x8
               	str	x0, [x23]
               	ldur	x21, [x29, #-0x10]
               	add	x23, x21, #0x28
               	ldr	x21, [x23]
               	str	x21, [x0]
               	b	0x402668 <.text+0x2208>
               	b	0x402608 <.text+0x21a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x33b
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x21, [x23]
               	mov	x0, x22
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
               	b	0x402668 <.text+0x2208>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x22, x23, #0x8
               	str	x22, [x0]
               	mov	x23, #0x7               // =7
               	str	x23, [x22]
               	ldr	x24, [x0]
               	add	x23, x24, #0x8
               	str	x23, [x0]
               	ldur	x24, [x29, #-0x8]
               	str	x24, [x23]
               	b	0x4026f0 <.text+0x2290>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldur	x0, [x29, #-0x10]
               	add	x23, x0, #0x20
               	ldr	x0, [x23]
               	str	x0, [x24]
               	b	0x402524 <.text+0x20c4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x24, x23, #0x8
               	str	x24, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x24]
               	ldr	x22, [x0]
               	add	x24, x22, #0x8
               	str	x24, [x0]
               	ldur	x22, [x29, #-0x10]
               	add	x0, x22, #0x28
               	ldr	x22, [x0]
               	str	x22, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x23, [x0]
               	b	0x402760 <.text+0x2300>
               	b	0x402524 <.text+0x20c4>
               	ldur	x0, [x29, #-0x10]
               	add	x22, x0, #0x18
               	ldr	x0, [x22]
               	cmp	x0, #0x84
               	b.ne	0x40280c <.text+0x23ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x23, x22, #0x8
               	str	x23, [x0]
               	mov	x22, #0x0               // =0
               	str	x22, [x23]
               	ldr	x24, [x0]
               	add	x22, x24, #0x8
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldur	x24, [x29, #-0x10]
               	add	x23, x24, #0x28
               	ldr	x24, [x23]
               	sub	x23, x0, x24
               	str	x23, [x22]
               	b	0x4027cc <.text+0x236c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x21, x0, #0x8
               	str	x21, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x23, [x29, #-0x10]
               	add	x22, x23, #0x20
               	ldr	x23, [x22]
               	str	x23, [x0]
               	cmp	x23, #0x0
               	b.ne	0x4028bc <.text+0x245c>
               	b	0x4028b0 <.text+0x2450>
               	ldur	x23, [x29, #-0x10]
               	add	x24, x23, #0x18
               	ldr	x23, [x24]
               	cmp	x23, #0x83
               	b.ne	0x402864 <.text+0x2404>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x24, [x23]
               	add	x22, x24, #0x8
               	str	x22, [x23]
               	mov	x24, #0x1               // =1
               	str	x24, [x22]
               	ldr	x0, [x23]
               	add	x24, x0, #0x8
               	str	x24, [x23]
               	ldur	x0, [x29, #-0x10]
               	add	x23, x0, #0x28
               	ldr	x0, [x23]
               	str	x0, [x24]
               	b	0x402860 <.text+0x2400>
               	b	0x4027cc <.text+0x236c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x352
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x0, x21
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
               	b	0x402860 <.text+0x2400>
               	mov	x23, #0xa               // =10
               	stur	x23, [x29, #-0x38]
               	b	0x4028c8 <.text+0x2468>
               	mov	x23, #0x9               // =9
               	stur	x23, [x29, #-0x38]
               	b	0x4028c8 <.text+0x2468>
               	ldur	x23, [x29, #-0x38]
               	str	x23, [x21]
               	b	0x402760 <.text+0x2300>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x8a
               	cset	x0, eq
               	stur	x0, [x29, #-0x40]
               	cbnz	x0, 0x40293c <.text+0x24dc>
               	b	0x40291c <.text+0x24bc>
               	b	0x4024f4 <.text+0x2094>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x9f
               	b.ne	0x402af8 <.text+0x2698>
               	b	0x402ac8 <.text+0x2668>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x86
               	cset	x25, eq
               	stur	x25, [x29, #-0x40]
               	b	0x40293c <.text+0x24dc>
               	ldur	x25, [x29, #-0x40]
               	cbz	x25, 0x402964 <.text+0x2504>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x8a
               	b.ne	0x402998 <.text+0x2538>
               	b	0x40298c <.text+0x252c>
               	b	0x4028fc <.text+0x249c>
               	mov	x21, #0x8e              // =142
               	mov	x0, x21
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x29
               	b.ne	0x402a7c <.text+0x261c>
               	b	0x402a70 <.text+0x2610>
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0x48]
               	b	0x4029a4 <.text+0x2544>
               	mov	x25, #0x0               // =0
               	stur	x25, [x29, #-0x48]
               	b	0x4029a4 <.text+0x2544>
               	ldur	x25, [x29, #-0x48]
               	stur	x25, [x29, #-0x8]
               	bl	0x4005a8 <.text+0x148>
               	b	0x4029b4 <.text+0x2554>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x9f
               	b.ne	0x4029e0 <.text+0x2580>
               	bl	0x4005a8 <.text+0x148>
               	ldur	x0, [x29, #-0x8]
               	add	x23, x0, #0x2
               	stur	x23, [x29, #-0x8]
               	b	0x4029b4 <.text+0x2554>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x29
               	b.ne	0x402a24 <.text+0x25c4>
               	bl	0x4005a8 <.text+0x148>
               	b	0x402a00 <.text+0x25a0>
               	mov	x25, #0xa2              // =162
               	mov	x0, x25
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x25, [x29, #-0x8]
               	str	x25, [x0]
               	b	0x402960 <.text+0x2500>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x36a
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x23
               	mov	x1, x25
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x402a00 <.text+0x25a0>
               	bl	0x4005a8 <.text+0x148>
               	b	0x402a78 <.text+0x2618>
               	b	0x402960 <.text+0x2500>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x378
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x21
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
               	b	0x402a78 <.text+0x2618>
               	bl	0x4005a8 <.text+0x148>
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x1
               	b.le	0x402b64 <.text+0x2704>
               	b	0x402b14 <.text+0x26b4>
               	b	0x4028fc <.text+0x249c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x94
               	b.ne	0x402c10 <.text+0x27b0>
               	b	0x402bd4 <.text+0x2774>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x0, [x23]
               	sub	x21, x0, #0x2
               	str	x21, [x23]
               	b	0x402b30 <.text+0x26d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x25, x0, #0x8
               	str	x25, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x0
               	b.ne	0x402bbc <.text+0x275c>
               	b	0x402bb0 <.text+0x2750>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x392
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
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
               	b	0x402b30 <.text+0x26d0>
               	mov	x23, #0xa               // =10
               	stur	x23, [x29, #-0x50]
               	b	0x402bc8 <.text+0x2768>
               	mov	x23, #0x9               // =9
               	stur	x23, [x29, #-0x50]
               	b	0x402bc8 <.text+0x2768>
               	ldur	x23, [x29, #-0x50]
               	str	x23, [x25]
               	b	0x402af4 <.text+0x2694>
               	bl	0x4005a8 <.text+0x148>
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	ldr	x0, [x23]
               	cmp	x0, #0xa
               	cset	x23, eq
               	stur	x23, [x29, #-0x58]
               	cbnz	x23, 0x402c50 <.text+0x27f0>
               	b	0x402c2c <.text+0x27cc>
               	b	0x402af4 <.text+0x2694>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x0, [x21]
               	cmp	x0, #0x21
               	b.ne	0x402d70 <.text+0x2910>
               	b	0x402cec <.text+0x288c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	ldr	x0, [x23]
               	cmp	x0, #0x9
               	cset	x23, eq
               	stur	x23, [x29, #-0x58]
               	b	0x402c50 <.text+0x27f0>
               	ldur	x23, [x29, #-0x58]
               	cbz	x23, 0x402ca0 <.text+0x2840>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x25, x23, x17
               	str	x25, [x0]
               	b	0x402c84 <.text+0x2824>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x21, x0, #0x2
               	str	x21, [x23]
               	b	0x402c0c <.text+0x27ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3a7
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x0, x21
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
               	b	0x402c84 <.text+0x2824>
               	bl	0x4005a8 <.text+0x148>
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x23, x21, #0x8
               	str	x23, [x0]
               	mov	x21, #0xd               // =13
               	str	x21, [x23]
               	ldr	x22, [x0]
               	add	x21, x22, #0x8
               	str	x21, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x21]
               	ldr	x23, [x0]
               	add	x21, x23, #0x8
               	str	x21, [x0]
               	mov	x23, #0x0               // =0
               	str	x23, [x21]
               	ldr	x10, [x0]
               	add	x23, x10, #0x8
               	str	x23, [x0]
               	mov	x10, #0x11              // =17
               	str	x10, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x22, [x0]
               	b	0x402d6c <.text+0x290c>
               	b	0x402c0c <.text+0x27ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x10, [x0]
               	cmp	x10, #0x7e
               	b.ne	0x402e18 <.text+0x29b8>
               	bl	0x4005a8 <.text+0x148>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x22, x24, #0x8
               	str	x22, [x0]
               	mov	x24, #0xd               // =13
               	str	x24, [x22]
               	ldr	x23, [x0]
               	add	x24, x23, #0x8
               	str	x24, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x24]
               	ldr	x22, [x0]
               	add	x24, x22, #0x8
               	str	x24, [x0]
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	str	x22, [x24]
               	ldr	x21, [x0]
               	add	x22, x21, #0x8
               	str	x22, [x0]
               	mov	x21, #0xf               // =15
               	str	x21, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x23, [x0]
               	b	0x402e14 <.text+0x29b4>
               	b	0x402d6c <.text+0x290c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x9d
               	b.ne	0x402e5c <.text+0x29fc>
               	bl	0x4005a8 <.text+0x148>
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x0]
               	b	0x402e58 <.text+0x29f8>
               	b	0x402e14 <.text+0x29b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x9e
               	b.ne	0x402eb8 <.text+0x2a58>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	add	x23, x25, #0x8
               	str	x23, [x0]
               	mov	x25, #0x1               // =1
               	str	x25, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x80
               	b.ne	0x402f3c <.text+0x2adc>
               	b	0x402edc <.text+0x2a7c>
               	b	0x402e58 <.text+0x29f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x25, [x21]
               	cmp	x25, #0xa2
               	cset	x21, eq
               	stur	x21, [x29, #-0x60]
               	cbnz	x21, 0x402fc0 <.text+0x2b60>
               	b	0x402fa0 <.text+0x2b40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x23, x0, #0x8
               	str	x23, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x25, x17
               	str	x0, [x23]
               	bl	0x4005a8 <.text+0x148>
               	b	0x402f24 <.text+0x2ac4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x0]
               	b	0x402eb4 <.text+0x2a54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x23, x0, #0x8
               	str	x23, [x21]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	x0, [x23]
               	ldr	x22, [x21]
               	add	x0, x22, #0x8
               	str	x0, [x21]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	mov	x25, #0xa2              // =162
               	mov	x0, x25
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x21]
               	add	x25, x0, #0x8
               	str	x25, [x21]
               	mov	x0, #0x1b               // =27
               	str	x0, [x25]
               	b	0x402f24 <.text+0x2ac4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x21, [x25]
               	cmp	x21, #0xa3
               	cset	x25, eq
               	stur	x25, [x29, #-0x60]
               	b	0x402fc0 <.text+0x2b60>
               	ldur	x25, [x29, #-0x60]
               	cbz	x25, 0x403010 <.text+0x2bb0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x25, [x21]
               	stur	x25, [x29, #-0x8]
               	bl	0x4005a8 <.text+0x148>
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	ldr	x0, [x23]
               	cmp	x0, #0xa
               	b.ne	0x4030e8 <.text+0x2c88>
               	b	0x40305c <.text+0x2bfc>
               	b	0x402eb4 <.text+0x2a54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3dc
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x25, [x21]
               	mov	x0, x23
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
               	b	0x40300c <.text+0x2bac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x21, #0xd               // =13
               	str	x21, [x23]
               	ldr	x22, [x0]
               	add	x21, x22, #0x8
               	str	x21, [x0]
               	mov	x22, #0xa               // =10
               	str	x22, [x21]
               	b	0x40308c <.text+0x2c2c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x25, x0, #0x8
               	str	x25, [x21]
               	mov	x0, #0xd                // =13
               	str	x0, [x25]
               	ldr	x22, [x21]
               	add	x0, x22, #0x8
               	str	x0, [x21]
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	ldr	x25, [x21]
               	add	x22, x25, #0x8
               	str	x22, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldr	x21, [x25]
               	cmp	x21, #0x2
               	b.le	0x403190 <.text+0x2d30>
               	b	0x403184 <.text+0x2d24>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	ldr	x22, [x0]
               	cmp	x22, #0x9
               	b.ne	0x403138 <.text+0x2cd8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	mov	x21, #0xd               // =13
               	str	x21, [x0]
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	mov	x23, #0x9               // =9
               	str	x23, [x21]
               	b	0x403134 <.text+0x2cd4>
               	b	0x40308c <.text+0x2c2c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3bb
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x23, [x22]
               	mov	x0, x25
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x403134 <.text+0x2cd4>
               	mov	x21, #0x8               // =8
               	stur	x21, [x29, #-0x68]
               	b	0x40319c <.text+0x2d3c>
               	mov	x21, #0x1               // =1
               	stur	x21, [x29, #-0x68]
               	b	0x40319c <.text+0x2d3c>
               	ldur	x21, [x29, #-0x68]
               	str	x21, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x21, [x25]
               	add	x22, x21, #0x8
               	str	x22, [x25]
               	ldur	x21, [x29, #-0x8]
               	cmp	x21, #0xa2
               	b.ne	0x4031d4 <.text+0x2d74>
               	mov	x21, #0x19              // =25
               	stur	x21, [x29, #-0x70]
               	b	0x4031e0 <.text+0x2d80>
               	mov	x21, #0x1a              // =26
               	stur	x21, [x29, #-0x70]
               	b	0x4031e0 <.text+0x2d80>
               	ldur	x21, [x29, #-0x70]
               	str	x21, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x21, [x25]
               	add	x22, x21, #0x8
               	str	x22, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldr	x25, [x21]
               	cmp	x25, #0x0
               	b.ne	0x403224 <.text+0x2dc4>
               	mov	x25, #0xc               // =12
               	stur	x25, [x29, #-0x78]
               	b	0x403230 <.text+0x2dd0>
               	mov	x25, #0xb               // =11
               	stur	x25, [x29, #-0x78]
               	b	0x403230 <.text+0x2dd0>
               	ldur	x25, [x29, #-0x78]
               	str	x25, [x22]
               	b	0x40300c <.text+0x2bac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, x20
               	b.lt	0x403284 <.text+0x2e24>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x22, [x0]
               	stur	x22, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x8e
               	b.ne	0x4032e8 <.text+0x2e88>
               	b	0x4032b8 <.text+0x2e58>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
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
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	ldr	x0, [x25]
               	cmp	x0, #0xa
               	cset	x25, eq
               	stur	x25, [x29, #-0x80]
               	cbnz	x25, 0x403328 <.text+0x2ec8>
               	b	0x403304 <.text+0x2ea4>
               	b	0x40323c <.text+0x2ddc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x8f
               	b.ne	0x403460 <.text+0x3000>
               	b	0x403400 <.text+0x2fa0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	ldr	x0, [x25]
               	cmp	x0, #0x9
               	cset	x25, eq
               	stur	x25, [x29, #-0x80]
               	b	0x403328 <.text+0x2ec8>
               	ldur	x25, [x29, #-0x80]
               	cbz	x25, 0x403390 <.text+0x2f30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x25]
               	b	0x40334c <.text+0x2eec>
               	mov	x26, #0x8e              // =142
               	mov	x0, x26
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x22, x26, #0x8
               	str	x22, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x26]
               	cmp	x0, #0x0
               	b.ne	0x4033e8 <.text+0x2f88>
               	b	0x4033dc <.text+0x2f7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3f0
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x26, [x23]
               	mov	x0, x22
               	mov	x1, x26
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x40334c <.text+0x2eec>
               	mov	x0, #0xc                // =12
               	stur	x0, [x29, #-0x88]
               	b	0x4033f4 <.text+0x2f94>
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x88]
               	b	0x4033f4 <.text+0x2f94>
               	ldur	x0, [x29, #-0x88]
               	str	x0, [x22]
               	b	0x4032e4 <.text+0x2e84>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x22, x23, #0x8
               	str	x22, [x0]
               	mov	x23, #0x4               // =4
               	str	x23, [x22]
               	ldr	x26, [x0]
               	add	x23, x26, #0x8
               	str	x23, [x0]
               	stur	x23, [x29, #-0x10]
               	mov	x21, #0x8e              // =142
               	mov	x0, x21
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x3a
               	b.ne	0x4034e4 <.text+0x3084>
               	b	0x40347c <.text+0x301c>
               	b	0x4032e4 <.text+0x2e84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x25, [x26]
               	cmp	x25, #0x90
               	b.ne	0x40359c <.text+0x313c>
               	b	0x403530 <.text+0x30d0>
               	bl	0x4005a8 <.text+0x148>
               	b	0x403484 <.text+0x3024>
               	ldur	x23, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x22, x21, #0x18
               	str	x22, [x23]
               	ldr	x21, [x26]
               	add	x22, x21, #0x8
               	str	x22, [x26]
               	mov	x21, #0x2               // =2
               	str	x21, [x22]
               	ldr	x23, [x26]
               	add	x21, x23, #0x8
               	str	x21, [x26]
               	stur	x21, [x29, #-0x10]
               	mov	x25, #0x8f              // =143
               	mov	x0, x25
               	bl	0x4020a4 <.text+0x1c44>
               	ldur	x0, [x29, #-0x10]
               	ldr	x25, [x26]
               	add	x26, x25, #0x8
               	str	x26, [x0]
               	b	0x40345c <.text+0x2ffc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x40e
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x26, [x0]
               	mov	x0, x21
               	mov	x1, x26
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x403484 <.text+0x3024>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x25, x21, #0x8
               	str	x25, [x26]
               	mov	x21, #0x5               // =5
               	str	x21, [x25]
               	ldr	x22, [x26]
               	add	x21, x22, #0x8
               	str	x21, [x26]
               	stur	x21, [x29, #-0x10]
               	mov	x23, #0x91              // =145
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	ldur	x0, [x29, #-0x10]
               	ldr	x23, [x26]
               	add	x26, x23, #0x8
               	str	x26, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x23]
               	b	0x403598 <.text+0x3138>
               	b	0x40345c <.text+0x2ffc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x91
               	b.ne	0x403620 <.text+0x31c0>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x23, x21, #0x8
               	str	x23, [x26]
               	mov	x21, #0x4               // =4
               	str	x21, [x23]
               	ldr	x25, [x26]
               	add	x21, x25, #0x8
               	str	x21, [x26]
               	stur	x21, [x29, #-0x10]
               	mov	x22, #0x92              // =146
               	mov	x0, x22
               	bl	0x4020a4 <.text+0x1c44>
               	ldur	x0, [x29, #-0x10]
               	ldr	x22, [x26]
               	add	x26, x22, #0x8
               	str	x26, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x22]
               	b	0x40361c <.text+0x31bc>
               	b	0x403598 <.text+0x3138>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x92
               	b.ne	0x403698 <.text+0x3238>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x22, x21, #0x8
               	str	x22, [x26]
               	mov	x21, #0xd               // =13
               	str	x21, [x22]
               	mov	x25, #0x93              // =147
               	mov	x0, x25
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x26]
               	add	x25, x0, #0x8
               	str	x25, [x26]
               	mov	x0, #0xe                // =14
               	str	x0, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x26]
               	b	0x403694 <.text+0x3234>
               	b	0x40361c <.text+0x31bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x93
               	b.ne	0x403710 <.text+0x32b0>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x21, [x25]
               	add	x26, x21, #0x8
               	str	x26, [x25]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	mov	x23, #0x94              // =148
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x25]
               	add	x23, x0, #0x8
               	str	x23, [x25]
               	mov	x0, #0xf                // =15
               	str	x0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x25]
               	b	0x40370c <.text+0x32ac>
               	b	0x403694 <.text+0x3234>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x94
               	b.ne	0x403788 <.text+0x3328>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x25, x21, #0x8
               	str	x25, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x25]
               	mov	x22, #0x95              // =149
               	mov	x0, x22
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x23]
               	add	x22, x0, #0x8
               	str	x22, [x23]
               	mov	x0, #0x10               // =16
               	str	x0, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	b	0x403784 <.text+0x3324>
               	b	0x40370c <.text+0x32ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x95
               	b.ne	0x403800 <.text+0x33a0>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x21, [x22]
               	add	x23, x21, #0x8
               	str	x23, [x22]
               	mov	x21, #0xd               // =13
               	str	x21, [x23]
               	mov	x26, #0x97              // =151
               	mov	x0, x26
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x22]
               	add	x26, x0, #0x8
               	str	x26, [x22]
               	mov	x0, #0x11               // =17
               	str	x0, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	b	0x4037fc <.text+0x339c>
               	b	0x403784 <.text+0x3324>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0x96
               	b.ne	0x403878 <.text+0x3418>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x22, x21, #0x8
               	str	x22, [x26]
               	mov	x21, #0xd               // =13
               	str	x21, [x22]
               	mov	x25, #0x97              // =151
               	mov	x0, x25
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x26]
               	add	x25, x0, #0x8
               	str	x25, [x26]
               	mov	x0, #0x12               // =18
               	str	x0, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x26]
               	b	0x403874 <.text+0x3414>
               	b	0x4037fc <.text+0x339c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x97
               	b.ne	0x4038f0 <.text+0x3490>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x21, [x25]
               	add	x26, x21, #0x8
               	str	x26, [x25]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	mov	x23, #0x9b              // =155
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x25]
               	add	x23, x0, #0x8
               	str	x23, [x25]
               	mov	x0, #0x13               // =19
               	str	x0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x25]
               	b	0x4038ec <.text+0x348c>
               	b	0x403874 <.text+0x3414>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x98
               	b.ne	0x403968 <.text+0x3508>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x25, x21, #0x8
               	str	x25, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x25]
               	mov	x22, #0x9b              // =155
               	mov	x0, x22
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x23]
               	add	x22, x0, #0x8
               	str	x22, [x23]
               	mov	x0, #0x14               // =20
               	str	x0, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	b	0x403964 <.text+0x3504>
               	b	0x4038ec <.text+0x348c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x99
               	b.ne	0x4039e0 <.text+0x3580>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x21, [x22]
               	add	x23, x21, #0x8
               	str	x23, [x22]
               	mov	x21, #0xd               // =13
               	str	x21, [x23]
               	mov	x26, #0x9b              // =155
               	mov	x0, x26
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x22]
               	add	x26, x0, #0x8
               	str	x26, [x22]
               	mov	x0, #0x15               // =21
               	str	x0, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	b	0x4039dc <.text+0x357c>
               	b	0x403964 <.text+0x3504>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0x9a
               	b.ne	0x403a58 <.text+0x35f8>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x22, x21, #0x8
               	str	x22, [x26]
               	mov	x21, #0xd               // =13
               	str	x21, [x22]
               	mov	x25, #0x9b              // =155
               	mov	x0, x25
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x26]
               	add	x25, x0, #0x8
               	str	x25, [x26]
               	mov	x0, #0x16               // =22
               	str	x0, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x26]
               	b	0x403a54 <.text+0x35f4>
               	b	0x4039dc <.text+0x357c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x9b
               	b.ne	0x403ad0 <.text+0x3670>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x21, [x25]
               	add	x26, x21, #0x8
               	str	x26, [x25]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	mov	x23, #0x9d              // =157
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x25]
               	add	x23, x0, #0x8
               	str	x23, [x25]
               	mov	x0, #0x17               // =23
               	str	x0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x25]
               	b	0x403acc <.text+0x366c>
               	b	0x403a54 <.text+0x35f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x9c
               	b.ne	0x403b48 <.text+0x36e8>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x25, x21, #0x8
               	str	x25, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x25]
               	mov	x22, #0x9d              // =157
               	mov	x0, x22
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x23]
               	add	x22, x0, #0x8
               	str	x22, [x23]
               	mov	x0, #0x18               // =24
               	str	x0, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	b	0x403b44 <.text+0x36e4>
               	b	0x403acc <.text+0x366c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x9d
               	b.ne	0x403bb4 <.text+0x3754>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x23, x21, #0x8
               	str	x23, [x0]
               	mov	x21, #0xd               // =13
               	str	x21, [x23]
               	mov	x22, #0x9f              // =159
               	mov	x0, x22
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x0]
               	cmp	x22, #0x2
               	b.le	0x403c30 <.text+0x37d0>
               	b	0x403bd0 <.text+0x3770>
               	b	0x403b44 <.text+0x36e4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x23, [x22]
               	cmp	x23, #0x9e
               	b.ne	0x403ca0 <.text+0x3840>
               	b	0x403c54 <.text+0x37f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x0, x23, #0x8
               	str	x0, [x22]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	ldr	x25, [x22]
               	add	x23, x25, #0x8
               	str	x23, [x22]
               	mov	x25, #0x1               // =1
               	str	x25, [x23]
               	ldr	x0, [x22]
               	add	x25, x0, #0x8
               	str	x25, [x22]
               	mov	x0, #0x8                // =8
               	str	x0, [x25]
               	ldr	x23, [x22]
               	add	x0, x23, #0x8
               	str	x0, [x22]
               	mov	x23, #0x1b              // =27
               	str	x23, [x0]
               	b	0x403c30 <.text+0x37d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x0, x22, #0x8
               	str	x0, [x23]
               	mov	x22, #0x19              // =25
               	str	x22, [x0]
               	b	0x403bb0 <.text+0x3750>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x23, x21, #0x8
               	str	x23, [x0]
               	mov	x21, #0xd               // =13
               	str	x21, [x23]
               	mov	x22, #0x9f              // =159
               	mov	x0, x22
               	bl	0x4020a4 <.text+0x1c44>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2
               	cset	x22, gt
               	stur	x22, [x29, #-0x90]
               	cbz	x22, 0x403ce0 <.text+0x3880>
               	b	0x403cbc <.text+0x385c>
               	b	0x403bb0 <.text+0x3750>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x9f
               	b.ne	0x403e88 <.text+0x3a28>
               	b	0x403e28 <.text+0x39c8>
               	ldur	x0, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x23, [x22]
               	cmp	x0, x23
               	cset	x22, eq
               	stur	x22, [x29, #-0x90]
               	b	0x403ce0 <.text+0x3880>
               	ldur	x22, [x29, #-0x90]
               	cbz	x22, 0x403d70 <.text+0x3910>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x0, x22, #0x8
               	str	x0, [x23]
               	mov	x22, #0x1a              // =26
               	str	x22, [x0]
               	ldr	x25, [x23]
               	add	x22, x25, #0x8
               	str	x22, [x23]
               	mov	x25, #0xd               // =13
               	str	x25, [x22]
               	ldr	x0, [x23]
               	add	x25, x0, #0x8
               	str	x25, [x23]
               	mov	x0, #0x1                // =1
               	str	x0, [x25]
               	ldr	x22, [x23]
               	add	x25, x22, #0x8
               	str	x25, [x23]
               	mov	x22, #0x8               // =8
               	str	x22, [x25]
               	ldr	x24, [x23]
               	add	x22, x24, #0x8
               	str	x22, [x23]
               	mov	x24, #0x1c              // =28
               	str	x24, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	str	x0, [x23]
               	b	0x403d6c <.text+0x390c>
               	b	0x403c9c <.text+0x383c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldur	x24, [x29, #-0x8]
               	str	x24, [x23]
               	cmp	x24, #0x2
               	b.le	0x403e04 <.text+0x39a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x23, x0, #0x8
               	str	x23, [x24]
               	mov	x0, #0xd                // =13
               	str	x0, [x23]
               	ldr	x22, [x24]
               	add	x0, x22, #0x8
               	str	x0, [x24]
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	ldr	x23, [x24]
               	add	x22, x23, #0x8
               	str	x22, [x24]
               	mov	x23, #0x8               // =8
               	str	x23, [x22]
               	ldr	x0, [x24]
               	add	x23, x0, #0x8
               	str	x23, [x24]
               	mov	x0, #0x1b               // =27
               	str	x0, [x23]
               	ldr	x22, [x24]
               	add	x0, x22, #0x8
               	str	x0, [x24]
               	mov	x22, #0x1a              // =26
               	str	x22, [x0]
               	b	0x403e00 <.text+0x39a0>
               	b	0x403d6c <.text+0x390c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x0, x24, #0x8
               	str	x0, [x22]
               	mov	x24, #0x1a              // =26
               	str	x24, [x0]
               	b	0x403e00 <.text+0x39a0>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x21, [x24]
               	add	x22, x21, #0x8
               	str	x22, [x24]
               	mov	x21, #0xd               // =13
               	str	x21, [x22]
               	mov	x26, #0xa2              // =162
               	mov	x0, x26
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x24]
               	add	x26, x0, #0x8
               	str	x26, [x24]
               	mov	x0, #0x1b               // =27
               	str	x0, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x24]
               	b	0x403e84 <.text+0x3a24>
               	b	0x403c9c <.text+0x383c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0xa0
               	b.ne	0x403f00 <.text+0x3aa0>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x24, x21, #0x8
               	str	x24, [x26]
               	mov	x21, #0xd               // =13
               	str	x21, [x24]
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x26]
               	add	x23, x0, #0x8
               	str	x23, [x26]
               	mov	x0, #0x1c               // =28
               	str	x0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x26]
               	b	0x403efc <.text+0x3a9c>
               	b	0x403e84 <.text+0x3a24>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0xa1
               	b.ne	0x403f78 <.text+0x3b18>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x26, x21, #0x8
               	str	x26, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	mov	x22, #0xa2              // =162
               	mov	x0, x22
               	bl	0x4020a4 <.text+0x1c44>
               	ldr	x0, [x23]
               	add	x22, x0, #0x8
               	str	x22, [x23]
               	mov	x0, #0x1d               // =29
               	str	x0, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	b	0x403f74 <.text+0x3b14>
               	b	0x403efc <.text+0x3a9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0xa2
               	cset	x0, eq
               	stur	x0, [x29, #-0x98]
               	cbnz	x0, 0x403fb8 <.text+0x3b58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0xa3
               	cset	x22, eq
               	stur	x22, [x29, #-0x98]
               	b	0x403fb8 <.text+0x3b58>
               	ldur	x22, [x29, #-0x98]
               	cbz	x22, 0x403fe4 <.text+0x3b84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	ldr	x0, [x22]
               	cmp	x0, #0xa
               	b.ne	0x40408c <.text+0x3c2c>
               	b	0x404000 <.text+0x3ba0>
               	b	0x403f74 <.text+0x3b14>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0xa4
               	b.ne	0x404308 <.text+0x3ea8>
               	b	0x4042b8 <.text+0x3e58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x23, #0xd               // =13
               	str	x23, [x22]
               	ldr	x26, [x0]
               	add	x23, x26, #0x8
               	str	x23, [x0]
               	mov	x26, #0xa               // =10
               	str	x26, [x23]
               	b	0x404030 <.text+0x3bd0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x21, x0, #0x8
               	str	x21, [x23]
               	mov	x0, #0xd                // =13
               	str	x0, [x21]
               	ldr	x26, [x23]
               	add	x0, x26, #0x8
               	str	x0, [x23]
               	mov	x26, #0x1               // =1
               	str	x26, [x0]
               	ldr	x21, [x23]
               	add	x26, x21, #0x8
               	str	x26, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x2
               	b.le	0x404134 <.text+0x3cd4>
               	b	0x404128 <.text+0x3cc8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x0, [x26]
               	ldr	x26, [x0]
               	cmp	x26, #0x9
               	b.ne	0x4040dc <.text+0x3c7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x0, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	ldr	x22, [x26]
               	add	x23, x22, #0x8
               	str	x23, [x26]
               	mov	x22, #0x9               // =9
               	str	x22, [x23]
               	b	0x4040d8 <.text+0x3c78>
               	b	0x404030 <.text+0x3bd0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x42d
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x26, x19
               	ldr	x22, [x26]
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
               	b	0x4040d8 <.text+0x3c78>
               	mov	x23, #0x8               // =8
               	stur	x23, [x29, #-0xa0]
               	b	0x404140 <.text+0x3ce0>
               	mov	x23, #0x1               // =1
               	stur	x23, [x29, #-0xa0]
               	b	0x404140 <.text+0x3ce0>
               	ldur	x23, [x29, #-0xa0]
               	str	x23, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x23, [x21]
               	add	x26, x23, #0x8
               	str	x26, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x21, [x23]
               	cmp	x21, #0xa2
               	b.ne	0x404184 <.text+0x3d24>
               	mov	x21, #0x19              // =25
               	stur	x21, [x29, #-0xa8]
               	b	0x404190 <.text+0x3d30>
               	mov	x21, #0x1a              // =26
               	stur	x21, [x29, #-0xa8]
               	b	0x404190 <.text+0x3d30>
               	ldur	x21, [x29, #-0xa8]
               	str	x21, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x26, x21, #0x8
               	str	x26, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x0
               	b.ne	0x4041d4 <.text+0x3d74>
               	mov	x23, #0xc               // =12
               	stur	x23, [x29, #-0xb0]
               	b	0x4041e0 <.text+0x3d80>
               	mov	x23, #0xb               // =11
               	stur	x23, [x29, #-0xb0]
               	b	0x4041e0 <.text+0x3d80>
               	ldur	x23, [x29, #-0xb0]
               	str	x23, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x23, [x21]
               	add	x26, x23, #0x8
               	str	x26, [x21]
               	mov	x23, #0xd               // =13
               	str	x23, [x26]
               	ldr	x0, [x21]
               	add	x23, x0, #0x8
               	str	x23, [x21]
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	ldr	x26, [x21]
               	add	x0, x26, #0x8
               	str	x0, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x2
               	b.le	0x40424c <.text+0x3dec>
               	mov	x21, #0x8               // =8
               	stur	x21, [x29, #-0xb8]
               	b	0x404258 <.text+0x3df8>
               	mov	x21, #0x1               // =1
               	stur	x21, [x29, #-0xb8]
               	b	0x404258 <.text+0x3df8>
               	ldur	x21, [x29, #-0xb8]
               	str	x21, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x26, [x21]
               	cmp	x26, #0xa2
               	b.ne	0x40429c <.text+0x3e3c>
               	mov	x26, #0x1a              // =26
               	stur	x26, [x29, #-0xc0]
               	b	0x4042a8 <.text+0x3e48>
               	mov	x26, #0x19              // =25
               	stur	x26, [x29, #-0xc0]
               	b	0x4042a8 <.text+0x3e48>
               	ldur	x26, [x29, #-0xc0]
               	str	x26, [x0]
               	bl	0x4005a8 <.text+0x148>
               	b	0x403fe0 <.text+0x3b80>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x21, x22, #0x8
               	str	x21, [x0]
               	mov	x22, #0xd               // =13
               	str	x22, [x21]
               	mov	x26, #0x8e              // =142
               	mov	x0, x26
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0x5d
               	b.ne	0x404380 <.text+0x3f20>
               	b	0x404368 <.text+0x3f08>
               	b	0x403fe0 <.text+0x3b80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x486
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x22, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x26, [x21]
               	mov	x0, x24
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404304 <.text+0x3ea4>
               	bl	0x4005a8 <.text+0x148>
               	b	0x404370 <.text+0x3f10>
               	ldur	x21, [x29, #-0x8]
               	cmp	x21, #0x2
               	b.le	0x40447c <.text+0x401c>
               	b	0x4043cc <.text+0x3f6c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x44f
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x26
               	mov	x1, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404370 <.text+0x3f10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x26, x0, #0x8
               	str	x26, [x21]
               	mov	x0, #0xd                // =13
               	str	x0, [x26]
               	ldr	x23, [x21]
               	add	x0, x23, #0x8
               	str	x0, [x21]
               	mov	x23, #0x1               // =1
               	str	x23, [x0]
               	ldr	x26, [x21]
               	add	x23, x26, #0x8
               	str	x23, [x21]
               	mov	x26, #0x8               // =8
               	str	x26, [x23]
               	ldr	x0, [x21]
               	add	x26, x0, #0x8
               	str	x26, [x21]
               	mov	x0, #0x1b               // =27
               	str	x0, [x26]
               	b	0x40442c <.text+0x3fcc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x22, x0, #0x8
               	str	x22, [x21]
               	mov	x0, #0x19               // =25
               	str	x0, [x22]
               	ldr	x23, [x21]
               	add	x0, x23, #0x8
               	str	x0, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldur	x21, [x29, #-0x8]
               	sub	x22, x21, #0x2
               	str	x22, [x23]
               	cmp	x22, #0x0
               	b.ne	0x4044e4 <.text+0x4084>
               	b	0x4044d8 <.text+0x4078>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2
               	b.ge	0x4044d4 <.text+0x4074>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46b
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x24, [x21]
               	mov	x0, x22
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
               	b	0x4044d4 <.text+0x4074>
               	b	0x40442c <.text+0x3fcc>
               	mov	x22, #0xa               // =10
               	stur	x22, [x29, #-0xc8]
               	b	0x4044f0 <.text+0x4090>
               	mov	x22, #0x9               // =9
               	stur	x22, [x29, #-0xc8]
               	b	0x4044f0 <.text+0x4090>
               	ldur	x22, [x29, #-0xc8]
               	str	x22, [x0]
               	b	0x404304 <.text+0x3ea4>
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
               	b.ne	0x40457c <.text+0x411c>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x28
               	b.ne	0x4045c8 <.text+0x4168>
               	b	0x404598 <.text+0x4138>
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
               	mov	x0, x19
               	ldr	x12, [x0]
               	cmp	x12, #0x8d
               	b.ne	0x404760 <.text+0x4300>
               	b	0x404724 <.text+0x42c4>
               	bl	0x4005a8 <.text+0x148>
               	b	0x4045a0 <.text+0x4140>
               	mov	x21, #0x8e              // =142
               	mov	x0, x21
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x29
               	b.ne	0x40466c <.text+0x420c>
               	b	0x404614 <.text+0x41b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4a0
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x4045a0 <.text+0x4140>
               	bl	0x4005a8 <.text+0x148>
               	b	0x40461c <.text+0x41bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	mov	x0, #0x4                // =4
               	str	x0, [x21]
               	ldr	x12, [x20]
               	add	x0, x12, #0x8
               	str	x0, [x20]
               	stur	x0, [x29, #-0x10]
               	bl	0x4044fc <.text+0x409c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x12, [x0]
               	cmp	x12, #0x87
               	b.ne	0x404704 <.text+0x42a4>
               	b	0x4046b8 <.text+0x4258>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4b9
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x21
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
               	b	0x40461c <.text+0x41bc>
               	ldur	x12, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x20, [x0]
               	add	x21, x20, #0x18
               	str	x21, [x12]
               	ldr	x20, [x0]
               	add	x21, x20, #0x8
               	str	x21, [x0]
               	mov	x20, #0x2               // =2
               	str	x20, [x21]
               	ldr	x12, [x0]
               	add	x20, x12, #0x8
               	str	x20, [x0]
               	stur	x20, [x29, #-0x10]
               	bl	0x4005a8 <.text+0x148>
               	bl	0x4044fc <.text+0x409c>
               	b	0x404704 <.text+0x42a4>
               	ldur	x20, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x12, [x0]
               	add	x0, x12, #0x8
               	str	x0, [x20]
               	b	0x404554 <.text+0x40f4>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x0, x22, #0x8
               	stur	x0, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x28
               	b.ne	0x4047ac <.text+0x434c>
               	b	0x40477c <.text+0x431c>
               	b	0x404554 <.text+0x40f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x23, [x20]
               	cmp	x23, #0x8b
               	b.ne	0x4048e0 <.text+0x4480>
               	b	0x4048bc <.text+0x445c>
               	bl	0x4005a8 <.text+0x148>
               	b	0x404784 <.text+0x4324>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x29
               	b.ne	0x404870 <.text+0x4410>
               	b	0x4047f8 <.text+0x4398>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4d3
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404784 <.text+0x4324>
               	bl	0x4005a8 <.text+0x148>
               	b	0x404800 <.text+0x43a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x23, x0, #0x8
               	str	x23, [x20]
               	mov	x0, #0x4                // =4
               	str	x0, [x23]
               	ldr	x21, [x20]
               	add	x0, x21, #0x8
               	str	x0, [x20]
               	stur	x0, [x29, #-0x10]
               	bl	0x4044fc <.text+0x409c>
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	mov	x0, #0x2                // =2
               	str	x0, [x21]
               	ldr	x23, [x20]
               	add	x0, x23, #0x8
               	str	x0, [x20]
               	ldur	x23, [x29, #-0x8]
               	str	x23, [x0]
               	ldur	x21, [x29, #-0x10]
               	ldr	x23, [x20]
               	add	x20, x23, #0x8
               	str	x20, [x21]
               	b	0x40475c <.text+0x42fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4ec
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x23
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
               	b	0x404800 <.text+0x43a0>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x3b
               	b.eq	0x40490c <.text+0x44ac>
               	b	0x4048fc <.text+0x449c>
               	b	0x40475c <.text+0x42fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x0, [x21]
               	cmp	x0, #0x7b
               	b.ne	0x4049a8 <.text+0x4548>
               	b	0x40499c <.text+0x453c>
               	mov	x20, #0x8e              // =142
               	mov	x0, x20
               	bl	0x4020a4 <.text+0x1c44>
               	b	0x40490c <.text+0x44ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	mov	x0, #0x8                // =8
               	str	x0, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.ne	0x404950 <.text+0x44f0>
               	bl	0x4005a8 <.text+0x148>
               	b	0x40494c <.text+0x44ec>
               	b	0x4048dc <.text+0x447c>
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
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x40494c <.text+0x44ec>
               	bl	0x4005a8 <.text+0x148>
               	b	0x4049c4 <.text+0x4564>
               	b	0x4048dc <.text+0x447c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x3b
               	b.ne	0x4049fc <.text+0x459c>
               	b	0x4049f0 <.text+0x4590>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x7d
               	b.eq	0x4049e8 <.text+0x4588>
               	bl	0x4044fc <.text+0x409c>
               	mov	x22, x0
               	b	0x4049c4 <.text+0x4564>
               	bl	0x4005a8 <.text+0x148>
               	b	0x4049a4 <.text+0x4544>
               	bl	0x4005a8 <.text+0x148>
               	b	0x4049f8 <.text+0x4598>
               	b	0x4049a4 <.text+0x4544>
               	mov	x22, #0x8e              // =142
               	mov	x0, x22
               	bl	0x4020a4 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x3b
               	b.ne	0x404a2c <.text+0x45cc>
               	bl	0x4005a8 <.text+0x148>
               	b	0x404a28 <.text+0x45c8>
               	b	0x4049f8 <.text+0x4598>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x51e
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
               	bl	0x406d3c <exit>
               	sxtw	x0, w0
               	b	0x404a28 <.text+0x45c8>
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
               	add	x13, x14, x17
               	str	x13, [x15]
               	add	x14, x29, #0x20
               	ldr	x13, [x14]
               	add	x15, x13, #0x8
               	str	x15, [x14]
               	ldur	x13, [x29, #0x10]
               	cmp	x13, #0x0
               	cset	x15, gt
               	stur	x15, [x29, #-0xa0]
               	cbz	x15, 0x404b34 <.text+0x46d4>
               	ldur	x13, [x29, #0x20]
               	ldr	x15, [x13]
               	ldrb	w13, [x15]
               	mov	x17, #0x2d              // =45
               	eor	x15, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0xa0]
               	b	0x404b34 <.text+0x46d4>
               	ldur	x15, [x29, #-0xa0]
               	stur	x15, [x29, #-0x98]
               	cbz	x15, 0x404b74 <.text+0x4714>
               	ldur	x13, [x29, #0x20]
               	ldr	x15, [x13]
               	add	x13, x15, #0x1
               	ldrb	w15, [x13]
               	mov	x17, #0x73              // =115
               	eor	x13, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x13, x17
               	cmp	x15, #0x0
               	cset	x13, eq
               	stur	x13, [x29, #-0x98]
               	b	0x404b74 <.text+0x4714>
               	ldur	x13, [x29, #-0x98]
               	cbz	x13, 0x404bc4 <.text+0x4764>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e8
               	mov	x15, x19
               	mov	x13, #0x1               // =1
               	str	x13, [x15]
               	add	x14, x29, #0x10
               	ldr	x13, [x14]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x15, x13, x17
               	str	x15, [x14]
               	add	x13, x29, #0x20
               	ldr	x15, [x13]
               	add	x14, x15, #0x8
               	str	x14, [x13]
               	b	0x404bc4 <.text+0x4764>
               	ldur	x14, [x29, #0x10]
               	cmp	x14, #0x0
               	cset	x15, gt
               	stur	x15, [x29, #-0xb0]
               	cbz	x15, 0x404c08 <.text+0x47a8>
               	ldur	x14, [x29, #0x20]
               	ldr	x15, [x14]
               	ldrb	w14, [x15]
               	mov	x17, #0x2d              // =45
               	eor	x15, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	cmp	x14, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0xb0]
               	b	0x404c08 <.text+0x47a8>
               	ldur	x15, [x29, #-0xb0]
               	stur	x15, [x29, #-0xa8]
               	cbz	x15, 0x404c48 <.text+0x47e8>
               	ldur	x14, [x29, #0x20]
               	ldr	x15, [x14]
               	add	x14, x15, #0x1
               	ldrb	w15, [x14]
               	mov	x17, #0x64              // =100
               	eor	x14, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x14, x17
               	cmp	x15, #0x0
               	cset	x14, eq
               	stur	x14, [x29, #-0xa8]
               	b	0x404c48 <.text+0x47e8>
               	ldur	x14, [x29, #-0xa8]
               	cbz	x14, 0x404c98 <.text+0x4838>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f0
               	mov	x15, x19
               	mov	x14, #0x1               // =1
               	str	x14, [x15]
               	add	x13, x29, #0x10
               	ldr	x14, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x15, x14, x17
               	str	x15, [x13]
               	add	x14, x29, #0x20
               	ldr	x15, [x14]
               	add	x13, x15, #0x8
               	str	x13, [x14]
               	b	0x404c98 <.text+0x4838>
               	ldur	x13, [x29, #0x10]
               	cmp	x13, #0x1
               	b.ge	0x404d00 <.text+0x48a0>
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
               	b.ge	0x404d90 <.text+0x4930>
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
               	sxtw	x22, w21
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x21, x19
               	mov	x0, x22
               	bl	0x406d54 <malloc>
               	str	x0, [x21]
               	cmp	x0, #0x0
               	b.ne	0x404e18 <.text+0x49b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x568
               	mov	x23, x19
               	mov	x0, x23
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
               	add	x19, x19, #0x1a8
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	mov	x0, x22
               	bl	0x406d54 <malloc>
               	str	x0, [x23]
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	0x404ea8 <.text+0x4a48>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x58a
               	mov	x21, x19
               	mov	x0, x21
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
               	add	x19, x19, #0x198
               	mov	x25, x19
               	mov	x0, x22
               	bl	0x406d54 <malloc>
               	str	x0, [x25]
               	cmp	x0, #0x0
               	b.ne	0x404f28 <.text+0x4ac8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5aa
               	mov	x21, x19
               	mov	x0, x21
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
               	mov	x0, x22
               	bl	0x406d54 <malloc>
               	stur	x0, [x29, #-0x38]
               	cmp	x0, #0x0
               	b.ne	0x404f9c <.text+0x4b3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ca
               	mov	x24, x19
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
               	add	x19, x19, #0x1b8
               	mov	x24, x19
               	ldr	x21, [x24]
               	mov	x26, #0x0               // =0
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x406d60 <memset>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x25
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x406d60 <memset>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x406d60 <memset>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5eb
               	mov	x21, x19
               	str	x21, [x0]
               	mov	x26, #0x86              // =134
               	stur	x26, [x29, #-0x58]
               	b	0x405028 <.text+0x4bc8>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x8d
               	b.gt	0x405060 <.text+0x4c00>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x25, [x0]
               	sub	x0, x29, #0x58
               	ldr	x26, [x0]
               	add	x23, x26, #0x1
               	str	x23, [x0]
               	str	x26, [x25]
               	b	0x405028 <.text+0x4bc8>
               	mov	x26, #0x1e              // =30
               	stur	x26, [x29, #-0x58]
               	b	0x40506c <.text+0x4c0c>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x26
               	b.gt	0x4050c8 <.text+0x4c68>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x25, x21, #0x18
               	mov	x21, #0x82              // =130
               	str	x21, [x25]
               	ldr	x23, [x0]
               	add	x21, x23, #0x20
               	mov	x23, #0x1               // =1
               	str	x23, [x21]
               	ldr	x25, [x0]
               	add	x0, x25, #0x28
               	sub	x25, x29, #0x58
               	ldr	x23, [x25]
               	add	x21, x23, #0x1
               	str	x21, [x25]
               	str	x23, [x0]
               	b	0x40506c <.text+0x4c0c>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x24, [x26]
               	mov	x23, #0x86              // =134
               	str	x23, [x24]
               	bl	0x4005a8 <.text+0x148>
               	ldr	x21, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x190
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	mov	x0, x22
               	bl	0x406d54 <malloc>
               	str	x0, [x26]
               	str	x0, [x27]
               	cmp	x0, #0x0
               	b.ne	0x40517c <.text+0x4d1c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x655
               	mov	x24, x19
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
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	sub	x23, x22, #0x1
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x406d6c <read>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x58]
               	cmp	x0, #0x0
               	b.gt	0x405214 <.text+0x4db4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x677
               	mov	x27, x19
               	ldur	x24, [x29, #-0x58]
               	mov	x0, x27
               	mov	x1, x24
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
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldur	x24, [x29, #-0x58]
               	add	x27, x0, x24
               	mov	x24, #0x0               // =0
               	strb	w24, [x27]
               	mov	x0, x20
               	bl	0x406d78 <close>
               	sxtw	x0, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	mov	x20, #0x1               // =1
               	str	x20, [x0]
               	bl	0x4005a8 <.text+0x148>
               	b	0x40525c <.text+0x4dfc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cbz	x0, 0x405294 <.text+0x4e34>
               	mov	x20, #0x1               // =1
               	stur	x20, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x8a
               	b.ne	0x4052b8 <.text+0x4e58>
               	b	0x4052ac <.text+0x4e4c>
               	add	x23, x21, #0x28
               	ldr	x21, [x23]
               	stur	x21, [x29, #-0x30]
               	cmp	x21, #0x0
               	b.ne	0x405fa0 <.text+0x5b40>
               	b	0x405f44 <.text+0x5ae4>
               	bl	0x4005a8 <.text+0x148>
               	b	0x4052b4 <.text+0x4e54>
               	b	0x405554 <.text+0x50f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x86
               	b.ne	0x4052e4 <.text+0x4e84>
               	bl	0x4005a8 <.text+0x148>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	b	0x4052e0 <.text+0x4e80>
               	b	0x4052b4 <.text+0x4e54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x88
               	b.ne	0x40531c <.text+0x4ebc>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x7b
               	b.eq	0x405328 <.text+0x4ec8>
               	b	0x405320 <.text+0x4ec0>
               	b	0x4052e0 <.text+0x4e80>
               	bl	0x4005a8 <.text+0x148>
               	b	0x405328 <.text+0x4ec8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x7b
               	b.ne	0x405350 <.text+0x4ef0>
               	bl	0x4005a8 <.text+0x148>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x58]
               	b	0x405354 <.text+0x4ef4>
               	b	0x40531c <.text+0x4ebc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x7d
               	b.eq	0x405388 <.text+0x4f28>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x85
               	b.eq	0x405418 <.text+0x4fb8>
               	b	0x405390 <.text+0x4f30>
               	bl	0x4005a8 <.text+0x148>
               	b	0x405350 <.text+0x4ef0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x68b
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x23, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	mov	x0, x20
               	mov	x2, x24
               	mov	x1, x23
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
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x8e
               	b.ne	0x405454 <.text+0x4ff4>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x80
               	b.eq	0x405528 <.text+0x50c8>
               	b	0x4054b8 <.text+0x5058>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x25, x0, #0x18
               	mov	x0, #0x80               // =128
               	str	x0, [x25]
               	ldr	x20, [x24]
               	add	x0, x20, #0x20
               	mov	x20, #0x1               // =1
               	str	x20, [x0]
               	ldr	x25, [x24]
               	add	x24, x25, #0x28
               	sub	x25, x29, #0x58
               	ldr	x20, [x25]
               	add	x0, x20, #0x1
               	str	x0, [x25]
               	str	x20, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x20, [x26]
               	cmp	x20, #0x2c
               	b.ne	0x405550 <.text+0x50f0>
               	b	0x405544 <.text+0x50e4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6a7
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x0, x25
               	mov	x1, x24
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
               	mov	x24, x19
               	ldr	x0, [x24]
               	stur	x0, [x29, #-0x58]
               	bl	0x4005a8 <.text+0x148>
               	b	0x405454 <.text+0x4ff4>
               	bl	0x4005a8 <.text+0x148>
               	mov	x26, x0
               	b	0x405550 <.text+0x50f0>
               	b	0x405354 <.text+0x4ef4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x3b
               	cset	x26, ne
               	stur	x26, [x29, #-0xb8]
               	cbz	x26, 0x4055ac <.text+0x514c>
               	b	0x40558c <.text+0x512c>
               	ldur	x26, [x29, #-0x10]
               	stur	x26, [x29, #-0x18]
               	b	0x4055b8 <.text+0x5158>
               	bl	0x4005a8 <.text+0x148>
               	b	0x40525c <.text+0x4dfc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0x7d
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	b	0x4055ac <.text+0x514c>
               	ldur	x0, [x29, #-0xb8]
               	cbz	x0, 0x405584 <.text+0x5124>
               	b	0x405578 <.text+0x5118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x9f
               	b.ne	0x4055e4 <.text+0x5184>
               	bl	0x4005a8 <.text+0x148>
               	ldur	x0, [x29, #-0x18]
               	add	x20, x0, #0x2
               	stur	x20, [x29, #-0x18]
               	b	0x4055b8 <.text+0x5158>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x85
               	b.eq	0x40566c <.text+0x520c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6c1
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x27, [x20]
               	mov	x0, x26
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
               	add	x19, x19, #0x1b0
               	mov	x27, x19
               	ldr	x0, [x27]
               	add	x27, x0, #0x18
               	ldr	x0, [x27]
               	cbz	x0, 0x4056fc <.text+0x529c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6dd
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x27, [x0]
               	mov	x0, x20
               	mov	x1, x27
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x0, x26
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
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x0, x26, #0x20
               	ldur	x26, [x29, #-0x18]
               	str	x26, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x26, [x20]
               	cmp	x26, #0x28
               	b.ne	0x40579c <.text+0x533c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x20, [x26]
               	add	x0, x20, #0x18
               	mov	x20, #0x81              // =129
               	str	x20, [x0]
               	ldr	x23, [x26]
               	add	x26, x23, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x20, [x23]
               	add	x23, x20, #0x8
               	str	x23, [x26]
               	bl	0x4005a8 <.text+0x148>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x58]
               	b	0x4057e4 <.text+0x5384>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x20, [x23]
               	cmp	x20, #0x2c
               	b.ne	0x405f40 <.text+0x5ae0>
               	b	0x405f34 <.text+0x5ad4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x23, [x26]
               	add	x20, x23, #0x18
               	mov	x23, #0x83              // =131
               	str	x23, [x20]
               	ldr	x0, [x26]
               	add	x26, x0, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x0, x19
               	ldr	x23, [x0]
               	str	x23, [x26]
               	ldr	x20, [x0]
               	add	x23, x20, #0x8
               	str	x23, [x0]
               	b	0x405780 <.text+0x5320>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x29
               	b.eq	0x405820 <.text+0x53c0>
               	mov	x23, #0x1               // =1
               	stur	x23, [x29, #-0x18]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x8a
               	b.ne	0x40584c <.text+0x53ec>
               	b	0x405840 <.text+0x53e0>
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x7b
               	b.eq	0x405ae8 <.text+0x5688>
               	b	0x405a78 <.text+0x5618>
               	bl	0x4005a8 <.text+0x148>
               	b	0x405848 <.text+0x53e8>
               	b	0x405878 <.text+0x5418>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x0, [x27]
               	cmp	x0, #0x86
               	b.ne	0x405874 <.text+0x5414>
               	bl	0x4005a8 <.text+0x148>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	b	0x405874 <.text+0x5414>
               	b	0x405848 <.text+0x53e8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x9f
               	b.ne	0x4058a4 <.text+0x5444>
               	bl	0x4005a8 <.text+0x148>
               	ldur	x0, [x29, #-0x18]
               	add	x27, x0, #0x2
               	stur	x27, [x29, #-0x18]
               	b	0x405878 <.text+0x5418>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x0, [x27]
               	cmp	x0, #0x85
               	b.eq	0x40592c <.text+0x54cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6fe
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x27, x19
               	ldr	x24, [x27]
               	mov	x0, x23
               	mov	x1, x24
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
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x24, x0, #0x18
               	ldr	x0, [x24]
               	cmp	x0, #0x84
               	b.ne	0x4059bc <.text+0x555c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x71d
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x26, [x24]
               	mov	x0, x27
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
               	add	x27, x0, #0x30
               	ldr	x0, [x26]
               	add	x20, x0, #0x18
               	ldr	x0, [x20]
               	str	x0, [x27]
               	ldr	x20, [x26]
               	add	x0, x20, #0x18
               	mov	x20, #0x84              // =132
               	str	x20, [x0]
               	ldr	x27, [x26]
               	add	x20, x27, #0x38
               	ldr	x27, [x26]
               	add	x0, x27, #0x20
               	ldr	x27, [x0]
               	str	x27, [x20]
               	ldr	x0, [x26]
               	add	x27, x0, #0x20
               	ldur	x0, [x29, #-0x18]
               	str	x0, [x27]
               	ldr	x20, [x26]
               	add	x0, x20, #0x40
               	ldr	x20, [x26]
               	add	x27, x20, #0x28
               	ldr	x20, [x27]
               	str	x20, [x0]
               	ldr	x27, [x26]
               	add	x26, x27, #0x28
               	sub	x27, x29, #0x58
               	ldr	x20, [x27]
               	add	x0, x20, #0x1
               	str	x0, [x27]
               	str	x20, [x26]
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x2c
               	b.ne	0x405a74 <.text+0x5614>
               	bl	0x4005a8 <.text+0x148>
               	mov	x23, x0
               	b	0x405a74 <.text+0x5614>
               	b	0x4057e4 <.text+0x5384>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x741
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x24
               	mov	x1, x23
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
               	mov	x23, x19
               	sub	x0, x29, #0x58
               	ldr	x24, [x0]
               	add	x25, x24, #0x1
               	str	x25, [x0]
               	str	x25, [x23]
               	bl	0x4005a8 <.text+0x148>
               	b	0x405b10 <.text+0x56b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x8a
               	cset	x25, eq
               	stur	x25, [x29, #-0xc0]
               	cbnz	x25, 0x405bbc <.text+0x575c>
               	b	0x405b9c <.text+0x573c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x8a
               	b.ne	0x405bd4 <.text+0x5774>
               	b	0x405bc8 <.text+0x5768>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x23, x0, #0x8
               	str	x23, [x25]
               	mov	x0, #0x6                // =6
               	str	x0, [x23]
               	ldr	x26, [x25]
               	add	x0, x26, #0x8
               	str	x0, [x25]
               	ldur	x26, [x29, #-0x58]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x25, x19
               	ldr	x23, [x25]
               	sub	x25, x26, x23
               	str	x25, [x0]
               	b	0x405e1c <.text+0x59bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x86
               	cset	x0, eq
               	stur	x0, [x29, #-0xc0]
               	b	0x405bbc <.text+0x575c>
               	ldur	x0, [x29, #-0xc0]
               	cbz	x0, 0x405b50 <.text+0x56f0>
               	b	0x405b34 <.text+0x56d4>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xc8]
               	b	0x405be0 <.text+0x5780>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0xc8]
               	b	0x405be0 <.text+0x5780>
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0x10]
               	bl	0x4005a8 <.text+0x148>
               	b	0x405bf0 <.text+0x5790>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x3b
               	b.eq	0x405c14 <.text+0x57b4>
               	ldur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x18]
               	b	0x405c1c <.text+0x57bc>
               	bl	0x4005a8 <.text+0x148>
               	b	0x405b10 <.text+0x56b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x9f
               	b.ne	0x405c48 <.text+0x57e8>
               	bl	0x4005a8 <.text+0x148>
               	ldur	x0, [x29, #-0x18]
               	add	x26, x0, #0x2
               	stur	x26, [x29, #-0x18]
               	b	0x405c1c <.text+0x57bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x85
               	b.eq	0x405cd0 <.text+0x5870>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x75e
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x26, x19
               	ldr	x20, [x26]
               	mov	x0, x25
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
               	add	x20, x0, #0x18
               	ldr	x0, [x20]
               	cmp	x0, #0x84
               	b.ne	0x405d60 <.text+0x5900>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x779
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x23, [x20]
               	mov	x0, x26
               	mov	x1, x23
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
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x26, x0, #0x30
               	ldr	x0, [x23]
               	add	x24, x0, #0x18
               	ldr	x0, [x24]
               	str	x0, [x26]
               	ldr	x24, [x23]
               	add	x0, x24, #0x18
               	mov	x24, #0x84              // =132
               	str	x24, [x0]
               	ldr	x26, [x23]
               	add	x24, x26, #0x38
               	ldr	x26, [x23]
               	add	x0, x26, #0x20
               	ldr	x26, [x0]
               	str	x26, [x24]
               	ldr	x0, [x23]
               	add	x26, x0, #0x20
               	ldur	x0, [x29, #-0x18]
               	str	x0, [x26]
               	ldr	x24, [x23]
               	add	x0, x24, #0x40
               	ldr	x24, [x23]
               	add	x26, x24, #0x28
               	ldr	x24, [x26]
               	str	x24, [x0]
               	ldr	x26, [x23]
               	add	x23, x26, #0x28
               	sub	x26, x29, #0x58
               	ldr	x24, [x26]
               	add	x0, x24, #0x1
               	str	x0, [x26]
               	str	x0, [x23]
               	bl	0x4005a8 <.text+0x148>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x2c
               	b.ne	0x405e18 <.text+0x59b8>
               	bl	0x4005a8 <.text+0x148>
               	mov	x25, x0
               	b	0x405e18 <.text+0x59b8>
               	b	0x405bf0 <.text+0x5790>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x23, [x25]
               	cmp	x23, #0x7d
               	b.eq	0x405e3c <.text+0x59dc>
               	bl	0x4044fc <.text+0x409c>
               	b	0x405e1c <.text+0x59bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x23, x0, #0x8
               	str	x23, [x20]
               	mov	x0, #0x8                // =8
               	str	x0, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x0, x19
               	ldr	x23, [x0]
               	str	x23, [x20]
               	b	0x405e80 <.text+0x5a20>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x0, [x23]
               	ldr	x23, [x0]
               	cbz	x23, 0x405ebc <.text+0x5a5c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x0, x23, #0x18
               	ldr	x23, [x0]
               	cmp	x23, #0x84
               	b.ne	0x405f18 <.text+0x5ab8>
               	b	0x405ec0 <.text+0x5a60>
               	b	0x405780 <.text+0x5320>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x20, x0, #0x18
               	ldr	x0, [x23]
               	add	x26, x0, #0x30
               	ldr	x0, [x26]
               	str	x0, [x20]
               	ldr	x26, [x23]
               	add	x0, x26, #0x20
               	ldr	x26, [x23]
               	add	x20, x26, #0x38
               	ldr	x26, [x20]
               	str	x26, [x0]
               	ldr	x20, [x23]
               	add	x26, x20, #0x28
               	ldr	x20, [x23]
               	add	x23, x20, #0x40
               	ldr	x20, [x23]
               	str	x20, [x26]
               	b	0x405f18 <.text+0x5ab8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x23, [x20]
               	add	x26, x23, #0x48
               	str	x26, [x20]
               	b	0x405e80 <.text+0x5a20>
               	bl	0x4005a8 <.text+0x148>
               	mov	x23, x0
               	b	0x405f40 <.text+0x5ae0>
               	b	0x405554 <.text+0x50f4>
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
               	cbz	x0, 0x405ff0 <.text+0x5b90>
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
               	add	x20, x0, x22
               	stur	x20, [x29, #-0x38]
               	stur	x20, [x29, #-0x40]
               	sub	x0, x29, #0x38
               	ldr	x20, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x20, x17
               	str	x22, [x0]
               	mov	x20, #0x26              // =38
               	str	x20, [x22]
               	sub	x0, x29, #0x38
               	ldr	x20, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x20, x17
               	str	x22, [x0]
               	mov	x20, #0xd               // =13
               	str	x20, [x22]
               	ldur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x60]
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x0, x17
               	str	x22, [x20]
               	ldur	x0, [x29, #0x10]
               	str	x0, [x22]
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x0, x17
               	str	x22, [x20]
               	ldur	x0, [x29, #0x20]
               	str	x0, [x22]
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x0, x17
               	str	x22, [x20]
               	ldur	x0, [x29, #-0x60]
               	str	x0, [x22]
               	mov	x20, #0x0               // =0
               	stur	x20, [x29, #-0x50]
               	b	0x4060dc <.text+0x5c7c>
               	mov	x20, #0x1               // =1
               	cbz	x20, 0x406124 <.text+0x5cc4>
               	sub	x0, x29, #0x30
               	ldr	x20, [x0]
               	add	x22, x20, #0x8
               	str	x22, [x0]
               	ldr	x23, [x20]
               	stur	x23, [x29, #-0x58]
               	sub	x20, x29, #0x50
               	ldr	x23, [x20]
               	add	x22, x23, #0x1
               	str	x22, [x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cbz	x22, 0x4061b0 <.text+0x5d50>
               	b	0x406160 <.text+0x5d00>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
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
               	mov	x21, x19
               	ldur	x23, [x29, #-0x50]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x7b6
               	mov	x20, x19
               	ldur	x0, [x29, #-0x58]
               	mov	x17, #0x5               // =5
               	mul	x25, x0, x17
               	add	x22, x20, x25
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x7
               	b.gt	0x4061ec <.text+0x5d8c>
               	b	0x4061c0 <.text+0x5d60>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x0
               	b.ne	0x406234 <.text+0x5dd4>
               	b	0x406208 <.text+0x5da8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x87a
               	mov	x25, x19
               	ldur	x22, [x29, #-0x30]
               	ldr	x24, [x22]
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	b	0x4061e8 <.text+0x5d88>
               	b	0x4061b0 <.text+0x5d50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x87f
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	b	0x4061e8 <.text+0x5d88>
               	ldur	x22, [x29, #-0x40]
               	sub	x0, x29, #0x30
               	ldr	x25, [x0]
               	add	x21, x25, #0x8
               	str	x21, [x0]
               	ldr	x20, [x25]
               	lsl	x25, x20, #3
               	add	x20, x22, x25
               	stur	x20, [x29, #-0x48]
               	b	0x406230 <.text+0x5dd0>
               	b	0x4060dc <.text+0x5c7c>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x1
               	b.ne	0x406260 <.text+0x5e00>
               	sub	x20, x29, #0x30
               	ldr	x25, [x20]
               	add	x22, x25, #0x8
               	str	x22, [x20]
               	ldr	x21, [x25]
               	stur	x21, [x29, #-0x48]
               	b	0x40625c <.text+0x5dfc>
               	b	0x406230 <.text+0x5dd0>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x2
               	b.ne	0x406280 <.text+0x5e20>
               	ldur	x21, [x29, #-0x30]
               	ldr	x25, [x21]
               	stur	x25, [x29, #-0x30]
               	b	0x40627c <.text+0x5e1c>
               	b	0x40625c <.text+0x5dfc>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x3
               	b.ne	0x4062cc <.text+0x5e6c>
               	sub	x25, x29, #0x38
               	ldr	x21, [x25]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x21, x17
               	str	x22, [x25]
               	ldur	x21, [x29, #-0x30]
               	add	x25, x21, #0x8
               	str	x25, [x22]
               	ldur	x21, [x29, #-0x30]
               	ldr	x25, [x21]
               	stur	x25, [x29, #-0x30]
               	b	0x4062c8 <.text+0x5e68>
               	b	0x40627c <.text+0x5e1c>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x4
               	b.ne	0x4062e8 <.text+0x5e88>
               	ldur	x25, [x29, #-0x48]
               	cbz	x25, 0x406308 <.text+0x5ea8>
               	b	0x4062f8 <.text+0x5e98>
               	b	0x4062c8 <.text+0x5e68>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x5
               	b.ne	0x406334 <.text+0x5ed4>
               	b	0x406324 <.text+0x5ec4>
               	ldur	x21, [x29, #-0x30]
               	add	x25, x21, #0x8
               	stur	x25, [x29, #-0xd0]
               	b	0x406318 <.text+0x5eb8>
               	ldur	x25, [x29, #-0x30]
               	ldr	x21, [x25]
               	stur	x21, [x29, #-0xd0]
               	b	0x406318 <.text+0x5eb8>
               	ldur	x21, [x29, #-0xd0]
               	stur	x21, [x29, #-0x30]
               	b	0x4062e4 <.text+0x5e84>
               	ldur	x21, [x29, #-0x48]
               	cbz	x21, 0x406354 <.text+0x5ef4>
               	b	0x406344 <.text+0x5ee4>
               	b	0x4062e4 <.text+0x5e84>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x6
               	b.ne	0x4063c8 <.text+0x5f68>
               	b	0x406370 <.text+0x5f10>
               	ldur	x25, [x29, #-0x30]
               	ldr	x21, [x25]
               	stur	x21, [x29, #-0xd8]
               	b	0x406364 <.text+0x5f04>
               	ldur	x21, [x29, #-0x30]
               	add	x25, x21, #0x8
               	stur	x25, [x29, #-0xd8]
               	b	0x406364 <.text+0x5f04>
               	ldur	x25, [x29, #-0xd8]
               	stur	x25, [x29, #-0x30]
               	b	0x406330 <.text+0x5ed0>
               	sub	x25, x29, #0x38
               	ldr	x21, [x25]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x21, x17
               	str	x22, [x25]
               	ldur	x21, [x29, #-0x40]
               	str	x21, [x22]
               	ldur	x25, [x29, #-0x38]
               	stur	x25, [x29, #-0x40]
               	sub	x21, x29, #0x30
               	ldr	x22, [x21]
               	add	x20, x22, #0x8
               	str	x20, [x21]
               	ldr	x0, [x22]
               	lsl	x22, x0, #3
               	sub	x0, x25, x22
               	stur	x0, [x29, #-0x38]
               	b	0x4063c4 <.text+0x5f64>
               	b	0x406330 <.text+0x5ed0>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x7
               	b.ne	0x406400 <.text+0x5fa0>
               	ldur	x0, [x29, #-0x38]
               	sub	x22, x29, #0x30
               	ldr	x25, [x22]
               	add	x20, x25, #0x8
               	str	x20, [x22]
               	ldr	x21, [x25]
               	lsl	x25, x21, #3
               	add	x21, x0, x25
               	stur	x21, [x29, #-0x38]
               	b	0x4063fc <.text+0x5f9c>
               	b	0x4063c4 <.text+0x5f64>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x8
               	b.ne	0x40644c <.text+0x5fec>
               	ldur	x21, [x29, #-0x40]
               	stur	x21, [x29, #-0x38]
               	sub	x25, x29, #0x38
               	ldr	x21, [x25]
               	add	x0, x21, #0x8
               	str	x0, [x25]
               	ldr	x20, [x21]
               	stur	x20, [x29, #-0x40]
               	sub	x21, x29, #0x38
               	ldr	x20, [x21]
               	add	x0, x20, #0x8
               	str	x0, [x21]
               	ldr	x25, [x20]
               	stur	x25, [x29, #-0x30]
               	b	0x406448 <.text+0x5fe8>
               	b	0x4063fc <.text+0x5f9c>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x9
               	b.ne	0x40646c <.text+0x600c>
               	ldur	x25, [x29, #-0x48]
               	ldr	x20, [x25]
               	stur	x20, [x29, #-0x48]
               	b	0x406468 <.text+0x6008>
               	b	0x406448 <.text+0x5fe8>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0xa
               	b.ne	0x40648c <.text+0x602c>
               	ldur	x20, [x29, #-0x48]
               	ldrb	w25, [x20]
               	stur	x25, [x29, #-0x48]
               	b	0x406488 <.text+0x6028>
               	b	0x406468 <.text+0x6008>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0xb
               	b.ne	0x4064bc <.text+0x605c>
               	sub	x25, x29, #0x38
               	ldr	x20, [x25]
               	add	x0, x20, #0x8
               	str	x0, [x25]
               	ldr	x21, [x20]
               	ldur	x20, [x29, #-0x48]
               	str	x20, [x21]
               	b	0x4064b8 <.text+0x6058>
               	b	0x406488 <.text+0x6028>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0xc
               	b.ne	0x4064f0 <.text+0x6090>
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	ldr	x25, [x0]
               	ldur	x0, [x29, #-0x48]
               	strb	w0, [x25]
               	stur	x0, [x29, #-0x48]
               	b	0x4064ec <.text+0x608c>
               	b	0x4064b8 <.text+0x6058>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0xd
               	b.ne	0x40652c <.text+0x60cc>
               	sub	x0, x29, #0x38
               	ldr	x21, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x25, x21, x17
               	str	x25, [x0]
               	ldur	x21, [x29, #-0x48]
               	str	x21, [x25]
               	b	0x406528 <.text+0x60c8>
               	b	0x4064ec <.text+0x608c>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xe
               	b.ne	0x406560 <.text+0x6100>
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	add	x25, x0, #0x8
               	str	x25, [x21]
               	ldr	x20, [x0]
               	ldur	x0, [x29, #-0x48]
               	orr	x25, x20, x0
               	stur	x25, [x29, #-0x48]
               	b	0x40655c <.text+0x60fc>
               	b	0x406528 <.text+0x60c8>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0xf
               	b.ne	0x406594 <.text+0x6134>
               	sub	x25, x29, #0x38
               	ldr	x0, [x25]
               	add	x20, x0, #0x8
               	str	x20, [x25]
               	ldr	x21, [x0]
               	ldur	x0, [x29, #-0x48]
               	eor	x20, x21, x0
               	stur	x20, [x29, #-0x48]
               	b	0x406590 <.text+0x6130>
               	b	0x40655c <.text+0x60fc>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x10
               	b.ne	0x4065c8 <.text+0x6168>
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	ldr	x25, [x0]
               	ldur	x0, [x29, #-0x48]
               	and	x21, x25, x0
               	stur	x21, [x29, #-0x48]
               	b	0x4065c4 <.text+0x6164>
               	b	0x406590 <.text+0x6130>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x11
               	b.ne	0x406600 <.text+0x61a0>
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	add	x25, x0, #0x8
               	str	x25, [x21]
               	ldr	x20, [x0]
               	ldur	x0, [x29, #-0x48]
               	cmp	x20, x0
               	cset	x25, eq
               	stur	x25, [x29, #-0x48]
               	b	0x4065fc <.text+0x619c>
               	b	0x4065c4 <.text+0x6164>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x12
               	b.ne	0x406638 <.text+0x61d8>
               	sub	x25, x29, #0x38
               	ldr	x0, [x25]
               	add	x20, x0, #0x8
               	str	x20, [x25]
               	ldr	x21, [x0]
               	ldur	x0, [x29, #-0x48]
               	cmp	x21, x0
               	cset	x20, ne
               	stur	x20, [x29, #-0x48]
               	b	0x406634 <.text+0x61d4>
               	b	0x4065fc <.text+0x619c>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x13
               	b.ne	0x406670 <.text+0x6210>
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	ldr	x25, [x0]
               	ldur	x0, [x29, #-0x48]
               	cmp	x25, x0
               	cset	x21, lt
               	stur	x21, [x29, #-0x48]
               	b	0x40666c <.text+0x620c>
               	b	0x406634 <.text+0x61d4>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x14
               	b.ne	0x4066a8 <.text+0x6248>
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	add	x25, x0, #0x8
               	str	x25, [x21]
               	ldr	x20, [x0]
               	ldur	x0, [x29, #-0x48]
               	cmp	x20, x0
               	cset	x25, gt
               	stur	x25, [x29, #-0x48]
               	b	0x4066a4 <.text+0x6244>
               	b	0x40666c <.text+0x620c>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x15
               	b.ne	0x4066e0 <.text+0x6280>
               	sub	x25, x29, #0x38
               	ldr	x0, [x25]
               	add	x20, x0, #0x8
               	str	x20, [x25]
               	ldr	x21, [x0]
               	ldur	x0, [x29, #-0x48]
               	cmp	x21, x0
               	cset	x20, le
               	stur	x20, [x29, #-0x48]
               	b	0x4066dc <.text+0x627c>
               	b	0x4066a4 <.text+0x6244>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x16
               	b.ne	0x406718 <.text+0x62b8>
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	ldr	x25, [x0]
               	ldur	x0, [x29, #-0x48]
               	cmp	x25, x0
               	cset	x21, ge
               	stur	x21, [x29, #-0x48]
               	b	0x406714 <.text+0x62b4>
               	b	0x4066dc <.text+0x627c>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x17
               	b.ne	0x40674c <.text+0x62ec>
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	add	x25, x0, #0x8
               	str	x25, [x21]
               	ldr	x20, [x0]
               	ldur	x0, [x29, #-0x48]
               	lsl	x25, x20, x0
               	stur	x25, [x29, #-0x48]
               	b	0x406748 <.text+0x62e8>
               	b	0x406714 <.text+0x62b4>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x18
               	b.ne	0x406780 <.text+0x6320>
               	sub	x25, x29, #0x38
               	ldr	x0, [x25]
               	add	x20, x0, #0x8
               	str	x20, [x25]
               	ldr	x21, [x0]
               	ldur	x0, [x29, #-0x48]
               	asr	x20, x21, x0
               	stur	x20, [x29, #-0x48]
               	b	0x40677c <.text+0x631c>
               	b	0x406748 <.text+0x62e8>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x19
               	b.ne	0x4067b4 <.text+0x6354>
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	ldr	x25, [x0]
               	ldur	x0, [x29, #-0x48]
               	add	x21, x25, x0
               	stur	x21, [x29, #-0x48]
               	b	0x4067b0 <.text+0x6350>
               	b	0x40677c <.text+0x631c>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1a
               	b.ne	0x4067e8 <.text+0x6388>
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	add	x25, x0, #0x8
               	str	x25, [x21]
               	ldr	x20, [x0]
               	ldur	x0, [x29, #-0x48]
               	sub	x25, x20, x0
               	stur	x25, [x29, #-0x48]
               	b	0x4067e4 <.text+0x6384>
               	b	0x4067b0 <.text+0x6350>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x1b
               	b.ne	0x40681c <.text+0x63bc>
               	sub	x25, x29, #0x38
               	ldr	x0, [x25]
               	add	x20, x0, #0x8
               	str	x20, [x25]
               	ldr	x21, [x0]
               	ldur	x0, [x29, #-0x48]
               	mul	x20, x21, x0
               	stur	x20, [x29, #-0x48]
               	b	0x406818 <.text+0x63b8>
               	b	0x4067e4 <.text+0x6384>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x1c
               	b.ne	0x406850 <.text+0x63f0>
               	sub	x20, x29, #0x38
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	ldr	x25, [x0]
               	ldur	x0, [x29, #-0x48]
               	sdiv	x21, x25, x0
               	stur	x21, [x29, #-0x48]
               	b	0x40684c <.text+0x63ec>
               	b	0x406818 <.text+0x63b8>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1d
               	b.ne	0x406888 <.text+0x6428>
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	add	x25, x0, #0x8
               	str	x25, [x21]
               	ldr	x20, [x0]
               	ldur	x0, [x29, #-0x48]
               	sdiv	x17, x20, x0
               	msub	x25, x17, x0, x20
               	stur	x25, [x29, #-0x48]
               	b	0x406884 <.text+0x6424>
               	b	0x40684c <.text+0x63ec>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x1e
               	b.ne	0x4068c0 <.text+0x6460>
               	ldur	x25, [x29, #-0x38]
               	add	x0, x25, #0x8
               	ldr	x24, [x0]
               	ldr	x20, [x25]
               	mov	x0, x24
               	mov	x1, x20
               	bl	0x406d48 <open>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x4068bc <.text+0x645c>
               	b	0x406884 <.text+0x6424>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x1f
               	b.ne	0x406904 <.text+0x64a4>
               	ldur	x0, [x29, #-0x38]
               	add	x20, x0, #0x10
               	ldr	x25, [x20]
               	add	x20, x0, #0x8
               	ldr	x24, [x20]
               	ldr	x21, [x0]
               	mov	x0, x25
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x406d6c <read>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x406900 <.text+0x64a0>
               	b	0x4068bc <.text+0x645c>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x20
               	b.ne	0x406930 <.text+0x64d0>
               	ldur	x0, [x29, #-0x38]
               	ldr	x20, [x0]
               	mov	x0, x20
               	bl	0x406d78 <close>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x40692c <.text+0x64cc>
               	b	0x406900 <.text+0x64a0>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x21
               	b.ne	0x406a18 <.text+0x65b8>
               	ldur	x0, [x29, #-0x38]
               	ldur	x20, [x29, #-0x30]
               	add	x24, x20, #0x8
               	ldr	x20, [x24]
               	lsl	x24, x20, #3
               	add	x20, x0, x24
               	stur	x20, [x29, #-0x60]
               	ldur	x24, [x29, #-0x60]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x24, x17
               	ldr	x21, [x20]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x24, x17
               	ldr	x23, [x20]
               	mov	x17, #0xffe8            // =65512
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x24, x17
               	ldr	x25, [x20]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x24, x17
               	ldr	x22, [x20]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x24, x17
               	ldr	x26, [x20]
               	mov	x17, #0xffd0            // =65488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x24, x17
               	ldr	x27, [x20]
               	mov	x0, x21
               	mov	x5, x27
               	mov	x4, x26
               	mov	x3, x22
               	mov	x2, x25
               	mov	x1, x23
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x406a14 <.text+0x65b4>
               	b	0x40692c <.text+0x64cc>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x22
               	b.ne	0x406a40 <.text+0x65e0>
               	ldur	x0, [x29, #-0x38]
               	ldr	x20, [x0]
               	mov	x0, x20
               	bl	0x406d54 <malloc>
               	stur	x0, [x29, #-0x48]
               	b	0x406a3c <.text+0x65dc>
               	b	0x406a14 <.text+0x65b4>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x23
               	b.ne	0x406a68 <.text+0x6608>
               	ldur	x0, [x29, #-0x38]
               	ldr	x27, [x0]
               	mov	x0, x27
               	bl	0x406d84 <free>
               	sxtw	x0, w0
               	b	0x406a64 <.text+0x6604>
               	b	0x406a3c <.text+0x65dc>
               	ldur	x27, [x29, #-0x58]
               	cmp	x27, #0x24
               	b.ne	0x406aa8 <.text+0x6648>
               	ldur	x27, [x29, #-0x38]
               	add	x0, x27, #0x10
               	ldr	x20, [x0]
               	add	x0, x27, #0x8
               	ldr	x26, [x0]
               	ldr	x22, [x27]
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x406d60 <memset>
               	stur	x0, [x29, #-0x48]
               	b	0x406aa4 <.text+0x6644>
               	b	0x406a64 <.text+0x6604>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x25
               	b.ne	0x406aec <.text+0x668c>
               	ldur	x0, [x29, #-0x38]
               	add	x22, x0, #0x10
               	ldr	x27, [x22]
               	add	x22, x0, #0x8
               	ldr	x26, [x22]
               	ldr	x20, [x0]
               	mov	x0, x27
               	mov	x2, x20
               	mov	x1, x26
               	bl	0x406d30 <memcmp>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	0x406ae8 <.text+0x6688>
               	b	0x406aa4 <.text+0x6644>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x26
               	b.ne	0x406b68 <.text+0x6708>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x881
               	mov	x22, x19
               	ldur	x20, [x29, #-0x38]
               	ldr	x24, [x20]
               	ldur	x26, [x29, #-0x50]
               	mov	x0, x22
               	mov	x2, x26
               	mov	x1, x24
               	bl	0x406d24 <printf>
               	sxtw	x0, w0
               	ldur	x0, [x29, #-0x38]
               	ldr	x26, [x0]
               	mov	x0, x26
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
               	b	0x406ae8 <.text+0x6688>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x896
               	mov	x27, x19
               	ldur	x20, [x29, #-0x58]
               	ldur	x26, [x29, #-0x50]
               	mov	x0, x27
               	mov	x2, x26
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
