
c4.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x404c94 <.text+0x4834>
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
               	bl	0x407088 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400578 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x138
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400578 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x138
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
               	sub	sp, sp, #0x190
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
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
               	add	x15, x14, #0x1
               	str	x15, [x13]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x14, x19
               	ldr	x15, [x14]
               	cmp	x15, #0xa
               	b.ne	0x40068c <.text+0x22c>
               	b	0x400670 <.text+0x210>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e8
               	mov	x15, x19
               	ldr	x14, [x15]
               	cbz	x14, 0x400714 <.text+0x2b4>
               	b	0x4006a8 <.text+0x248>
               	b	0x4005e0 <.text+0x180>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x26, [x25]
               	cmp	x26, #0x23
               	b.ne	0x400830 <.text+0x3d0>
               	b	0x400828 <.text+0x3c8>
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
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x12, x0
               	ldr	x12, [x22]
               	str	x12, [x23]
               	b	0x400730 <.text+0x2d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x25, x26, #0x1
               	str	x25, [x22]
               	b	0x400688 <.text+0x228>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x12, x19
               	ldr	x22, [x12]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	ldr	x23, [x12]
               	cmp	x22, x23
               	b.ge	0x4007c0 <.text+0x360>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x201
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x207
               	mov	x12, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x24, x25, #0x8
               	str	x24, [x23]
               	ldr	x25, [x24]
               	mov	x17, #0x5               // =5
               	mul	x24, x25, x17
               	add	x22, x12, x24
               	mov	x0, x26
               	mov	x1, x22
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	ldr	x24, [x23]
               	ldr	x23, [x24]
               	cmp	x23, #0x7
               	b.gt	0x400808 <.text+0x3a8>
               	b	0x4007c4 <.text+0x364>
               	b	0x400714 <.text+0x2b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2cb
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x24, x19
               	ldr	x22, [x24]
               	add	x26, x22, #0x8
               	str	x26, [x24]
               	ldr	x23, [x26]
               	mov	x0, x25
               	mov	x1, x23
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x400804 <.text+0x3a4>
               	b	0x400730 <.text+0x2d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d0
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x400804 <.text+0x3a4>
               	b	0x400854 <.text+0x3f4>
               	b	0x400688 <.text+0x228>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x26, [x22]
               	cmp	x26, #0x61
               	cset	x22, ge
               	stur	x22, [x29, #-0x48]
               	cbz	x22, 0x40090c <.text+0x4ac>
               	b	0x4008ec <.text+0x48c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x25, [x26]
               	ldrb	w26, [x25]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x26, x17
               	cmp	x25, #0x0
               	cset	x26, ne
               	stur	x26, [x29, #-0x30]
               	cbz	x26, 0x4008e0 <.text+0x480>
               	b	0x4008a8 <.text+0x448>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x26, [x25]
               	add	x22, x26, #0x1
               	str	x22, [x25]
               	b	0x400854 <.text+0x3f4>
               	b	0x40082c <.text+0x3cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x26, [x25]
               	ldrb	w25, [x26]
               	mov	x17, #0xa               // =10
               	eor	x26, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x26, x17
               	cmp	x25, #0x0
               	cset	x26, ne
               	stur	x26, [x29, #-0x30]
               	b	0x4008e0 <.text+0x480>
               	ldur	x26, [x29, #-0x30]
               	cbz	x26, 0x4008a4 <.text+0x444>
               	b	0x400888 <.text+0x428>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x22, [x26]
               	cmp	x22, #0x7a
               	cset	x26, le
               	stur	x26, [x29, #-0x48]
               	b	0x40090c <.text+0x4ac>
               	ldur	x26, [x29, #-0x48]
               	stur	x26, [x29, #-0x40]
               	cbnz	x26, 0x40093c <.text+0x4dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x26, [x22]
               	cmp	x26, #0x41
               	cset	x22, ge
               	stur	x22, [x29, #-0x50]
               	cbz	x22, 0x40096c <.text+0x50c>
               	b	0x40094c <.text+0x4ec>
               	ldur	x26, [x29, #-0x40]
               	stur	x26, [x29, #-0x38]
               	cbnz	x26, 0x400998 <.text+0x538>
               	b	0x400978 <.text+0x518>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x22, [x26]
               	cmp	x22, #0x5a
               	cset	x26, le
               	stur	x26, [x29, #-0x50]
               	b	0x40096c <.text+0x50c>
               	ldur	x26, [x29, #-0x50]
               	stur	x26, [x29, #-0x40]
               	b	0x40093c <.text+0x4dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x26, [x22]
               	cmp	x26, #0x5f
               	cset	x22, eq
               	stur	x22, [x29, #-0x38]
               	b	0x400998 <.text+0x538>
               	ldur	x22, [x29, #-0x38]
               	cbz	x22, 0x4009bc <.text+0x55c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x22, [x26]
               	sub	x23, x22, #0x1
               	b	0x4009e0 <.text+0x580>
               	b	0x40082c <.text+0x3cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x22, [x26]
               	cmp	x22, #0x30
               	cset	x26, ge
               	stur	x26, [x29, #-0x90]
               	cbz	x26, 0x400d9c <.text+0x93c>
               	b	0x400d7c <.text+0x91c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x61
               	cset	x25, ge
               	stur	x25, [x29, #-0x70]
               	cbz	x25, 0x400ac0 <.text+0x660>
               	b	0x400a9c <.text+0x63c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x25, [x22]
               	mov	x17, #0x93              // =147
               	mul	x24, x25, x17
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x12, [x25]
               	add	x21, x12, #0x1
               	str	x21, [x25]
               	ldrb	w20, [x12]
               	add	x12, x24, x20
               	str	x12, [x22]
               	b	0x4009e0 <.text+0x580>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x12, x19
               	ldr	x20, [x12]
               	lsl	x22, x20, #6
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x24, [x20]
               	sub	x20, x24, x23
               	add	x24, x22, x20
               	str	x24, [x12]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x24, x19
               	ldr	x12, [x24]
               	str	x12, [x20]
               	b	0x400be0 <.text+0x780>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x7a
               	cset	x25, le
               	stur	x25, [x29, #-0x70]
               	b	0x400ac0 <.text+0x660>
               	ldur	x25, [x29, #-0x70]
               	stur	x25, [x29, #-0x68]
               	cbnz	x25, 0x400af4 <.text+0x694>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x41
               	cset	x25, ge
               	stur	x25, [x29, #-0x78]
               	cbz	x25, 0x400b28 <.text+0x6c8>
               	b	0x400b04 <.text+0x6a4>
               	ldur	x25, [x29, #-0x68]
               	stur	x25, [x29, #-0x60]
               	cbnz	x25, 0x400b5c <.text+0x6fc>
               	b	0x400b34 <.text+0x6d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x5a
               	cset	x25, le
               	stur	x25, [x29, #-0x78]
               	b	0x400b28 <.text+0x6c8>
               	ldur	x25, [x29, #-0x78]
               	stur	x25, [x29, #-0x68]
               	b	0x400af4 <.text+0x694>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x30
               	cset	x25, ge
               	stur	x25, [x29, #-0x80]
               	cbz	x25, 0x400b90 <.text+0x730>
               	b	0x400b6c <.text+0x70c>
               	ldur	x25, [x29, #-0x60]
               	stur	x25, [x29, #-0x58]
               	cbnz	x25, 0x400bd4 <.text+0x774>
               	b	0x400b9c <.text+0x73c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x25, [x22]
               	ldrb	w22, [x25]
               	cmp	x22, #0x39
               	cset	x25, le
               	stur	x25, [x29, #-0x80]
               	b	0x400b90 <.text+0x730>
               	ldur	x25, [x29, #-0x80]
               	stur	x25, [x29, #-0x60]
               	b	0x400b5c <.text+0x6fc>
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
               	b	0x400bd4 <.text+0x774>
               	ldur	x25, [x29, #-0x58]
               	cbz	x25, 0x400a48 <.text+0x5e8>
               	b	0x400a08 <.text+0x5a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x12, x19
               	ldr	x24, [x12]
               	ldr	x12, [x24]
               	cbz	x12, 0x400c34 <.text+0x7d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x12, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x20, [x24]
               	add	x24, x20, #0x8
               	ldr	x20, [x24]
               	cmp	x12, x20
               	cset	x24, eq
               	stur	x24, [x29, #-0x88]
               	cbz	x24, 0x400d00 <.text+0x8a0>
               	b	0x400cac <.text+0x84c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x26, x24, #0x10
               	str	x23, [x26]
               	ldr	x24, [x22]
               	add	x26, x24, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x23, [x24]
               	str	x23, [x26]
               	ldr	x12, [x22]
               	mov	x22, #0x0               // =0
               	mov	x23, #0x85              // =133
               	str	x23, [x12]
               	str	x23, [x24]
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x24, [x20]
               	add	x20, x24, #0x10
               	ldr	x26, [x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x12, [x20]
               	sub	x24, x12, x23
               	mov	x0, x26
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x4070a0 <memcmp>
               	sxtw	x0, w0
               	mov	x12, x0
               	cmp	x12, #0x0
               	cset	x24, eq
               	stur	x24, [x29, #-0x88]
               	b	0x400d00 <.text+0x8a0>
               	ldur	x24, [x29, #-0x88]
               	cbz	x24, 0x400d60 <.text+0x900>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x12, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x26, [x24]
               	mov	x24, #0x0               // =0
               	ldr	x22, [x26]
               	str	x22, [x12]
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x24, [x26]
               	add	x22, x24, #0x48
               	str	x22, [x26]
               	b	0x400be0 <.text+0x780>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x26, [x22]
               	cmp	x26, #0x39
               	cset	x22, le
               	stur	x22, [x29, #-0x90]
               	b	0x400d9c <.text+0x93c>
               	ldur	x22, [x29, #-0x90]
               	cbz	x22, 0x400dd4 <.text+0x974>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x23, [x22]
               	sub	x22, x23, #0x30
               	str	x22, [x26]
               	cbz	x22, 0x400e3c <.text+0x9dc>
               	b	0x400df0 <.text+0x990>
               	b	0x4009b8 <.text+0x558>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x23, [x24]
               	cmp	x23, #0x2f
               	b.ne	0x4011f4 <.text+0xd94>
               	b	0x4011bc <.text+0xd5c>
               	b	0x400e78 <.text+0xa18>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x24, #0x80              // =128
               	str	x24, [x22]
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x78              // =120
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	cset	x24, eq
               	stur	x24, [x29, #-0xa0]
               	cbnz	x24, 0x400f50 <.text+0xaf0>
               	b	0x400f18 <.text+0xab8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldrb	w23, [x22]
               	cmp	x23, #0x30
               	cset	x22, ge
               	stur	x22, [x29, #-0x98]
               	cbz	x22, 0x400f0c <.text+0xaac>
               	b	0x400ee8 <.text+0xa88>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x22, [x23]
               	mov	x17, #0xa               // =10
               	mul	x26, x22, x17
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x12, x24, #0x1
               	str	x12, [x22]
               	ldrb	w21, [x24]
               	add	x24, x26, x21
               	sub	x21, x24, #0x30
               	str	x21, [x23]
               	b	0x400e78 <.text+0xa18>
               	b	0x400df4 <.text+0x994>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldrb	w23, [x22]
               	cmp	x23, #0x39
               	cset	x22, le
               	stur	x22, [x29, #-0x98]
               	b	0x400f0c <.text+0xaac>
               	ldur	x22, [x29, #-0x98]
               	cbz	x22, 0x400ee4 <.text+0xa84>
               	b	0x400ea0 <.text+0xa40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x58              // =88
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	cset	x24, eq
               	stur	x24, [x29, #-0xa0]
               	b	0x400f50 <.text+0xaf0>
               	ldur	x24, [x29, #-0xa0]
               	cbz	x24, 0x400f60 <.text+0xb00>
               	b	0x400f64 <.text+0xb04>
               	b	0x400df4 <.text+0x994>
               	b	0x401120 <.text+0xcc0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x26, x23, #0x1
               	str	x26, [x24]
               	ldrb	w23, [x26]
               	str	x23, [x21]
               	stur	x23, [x29, #-0xa8]
               	cbz	x23, 0x401004 <.text+0xba4>
               	b	0x400fe0 <.text+0xb80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x26, x19
               	ldr	x23, [x26]
               	lsl	x21, x23, #4
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	mov	x17, #0xf               // =15
               	and	x12, x24, x17
               	add	x24, x21, x12
               	ldr	x12, [x23]
               	cmp	x12, #0x41
               	b.lt	0x401104 <.text+0xca4>
               	b	0x4010f8 <.text+0xc98>
               	b	0x400f5c <.text+0xafc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x23, [x26]
               	cmp	x23, #0x30
               	cset	x26, ge
               	stur	x26, [x29, #-0xc0]
               	cbz	x26, 0x401030 <.text+0xbd0>
               	b	0x401010 <.text+0xbb0>
               	ldur	x23, [x29, #-0xa8]
               	cbz	x23, 0x400fdc <.text+0xb7c>
               	b	0x400f9c <.text+0xb3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	cmp	x26, #0x39
               	cset	x23, le
               	stur	x23, [x29, #-0xc0]
               	b	0x401030 <.text+0xbd0>
               	ldur	x23, [x29, #-0xc0]
               	stur	x23, [x29, #-0xb8]
               	cbnz	x23, 0x401060 <.text+0xc00>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x23, [x26]
               	cmp	x23, #0x61
               	cset	x26, ge
               	stur	x26, [x29, #-0xc8]
               	cbz	x26, 0x401090 <.text+0xc30>
               	b	0x401070 <.text+0xc10>
               	ldur	x23, [x29, #-0xb8]
               	stur	x23, [x29, #-0xb0]
               	cbnz	x23, 0x4010c0 <.text+0xc60>
               	b	0x40109c <.text+0xc3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	cmp	x26, #0x66
               	cset	x23, le
               	stur	x23, [x29, #-0xc8]
               	b	0x401090 <.text+0xc30>
               	ldur	x23, [x29, #-0xc8]
               	stur	x23, [x29, #-0xb8]
               	b	0x401060 <.text+0xc00>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x23, [x26]
               	cmp	x23, #0x41
               	cset	x26, ge
               	stur	x26, [x29, #-0xd0]
               	cbz	x26, 0x4010ec <.text+0xc8c>
               	b	0x4010cc <.text+0xc6c>
               	ldur	x23, [x29, #-0xb0]
               	stur	x23, [x29, #-0xa8]
               	b	0x401004 <.text+0xba4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	cmp	x26, #0x46
               	cset	x23, le
               	stur	x23, [x29, #-0xd0]
               	b	0x4010ec <.text+0xc8c>
               	ldur	x23, [x29, #-0xd0]
               	stur	x23, [x29, #-0xb0]
               	b	0x4010c0 <.text+0xc60>
               	mov	x12, #0x9               // =9
               	stur	x12, [x29, #-0xd8]
               	b	0x401110 <.text+0xcb0>
               	mov	x12, #0x0               // =0
               	stur	x12, [x29, #-0xd8]
               	b	0x401110 <.text+0xcb0>
               	ldur	x12, [x29, #-0xd8]
               	add	x23, x24, x12
               	str	x23, [x26]
               	b	0x400f64 <.text+0xb04>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x12, [x23]
               	ldrb	w23, [x12]
               	cmp	x23, #0x30
               	cset	x12, ge
               	stur	x12, [x29, #-0xe0]
               	cbz	x12, 0x4011b0 <.text+0xd50>
               	b	0x40118c <.text+0xd2c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x12, [x23]
               	lsl	x26, x12, #3
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x12, x19
               	ldr	x24, [x12]
               	add	x21, x24, #0x1
               	str	x21, [x12]
               	ldrb	w22, [x24]
               	add	x24, x26, x22
               	sub	x22, x24, #0x30
               	str	x22, [x23]
               	b	0x401120 <.text+0xcc0>
               	b	0x400f5c <.text+0xafc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x12, [x23]
               	ldrb	w23, [x12]
               	cmp	x23, #0x37
               	cset	x12, le
               	stur	x12, [x29, #-0xe0]
               	b	0x4011b0 <.text+0xd50>
               	ldur	x12, [x29, #-0xe0]
               	cbz	x12, 0x401188 <.text+0xd28>
               	b	0x401148 <.text+0xce8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x24, [x23]
               	ldrb	w23, [x24]
               	mov	x17, #0x2f              // =47
               	eor	x24, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x24, x17
               	cmp	x23, #0x0
               	b.ne	0x401238 <.text+0xdd8>
               	b	0x401218 <.text+0xdb8>
               	b	0x400dd0 <.text+0x970>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x27
               	cset	x22, eq
               	stur	x22, [x29, #-0xf0]
               	cbnz	x22, 0x401338 <.text+0xed8>
               	b	0x401318 <.text+0xeb8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x24, [x23]
               	add	x22, x24, #0x1
               	str	x22, [x23]
               	b	0x401280 <.text+0xe20>
               	b	0x4011f0 <.text+0xd90>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	mov	x22, #0xa0              // =160
               	str	x22, [x23]
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x24, [x22]
               	ldrb	w22, [x24]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x22, x17
               	cmp	x24, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xe8]
               	cbz	x22, 0x40130c <.text+0xeac>
               	b	0x4012d4 <.text+0xe74>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x22, [x24]
               	add	x23, x22, #0x1
               	str	x23, [x24]
               	b	0x401280 <.text+0xe20>
               	b	0x401234 <.text+0xdd4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x22, [x24]
               	ldrb	w24, [x22]
               	mov	x17, #0xa               // =10
               	eor	x22, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x22, x17
               	cmp	x24, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xe8]
               	b	0x40130c <.text+0xeac>
               	ldur	x22, [x29, #-0xe8]
               	cbz	x22, 0x4012d0 <.text+0xe70>
               	b	0x4012b4 <.text+0xe54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x22
               	cset	x24, eq
               	stur	x24, [x29, #-0xf0]
               	b	0x401338 <.text+0xed8>
               	ldur	x24, [x29, #-0xf0]
               	cbz	x24, 0x401358 <.text+0xef8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x24, [x22]
               	b	0x401374 <.text+0xf14>
               	b	0x4011f0 <.text+0xd90>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
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
               	cbz	x22, 0x401448 <.text+0xfe8>
               	b	0x401414 <.text+0xfb4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x21, x23, #0x1
               	str	x21, [x22]
               	ldrb	w12, [x23]
               	str	x12, [x26]
               	cmp	x12, #0x5c
               	b.ne	0x40148c <.text+0x102c>
               	b	0x401454 <.text+0xff4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x21, [x22]
               	add	x26, x21, #0x1
               	str	x26, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x26, [x21]
               	cmp	x26, #0x22
               	b.ne	0x401540 <.text+0x10e0>
               	b	0x4014f8 <.text+0x1098>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldrb	w23, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x26, [x22]
               	cmp	x23, x26
               	cset	x22, ne
               	stur	x22, [x29, #-0xf8]
               	b	0x401448 <.text+0xfe8>
               	ldur	x22, [x29, #-0xf8]
               	cbz	x22, 0x4013e0 <.text+0xf80>
               	b	0x4013a8 <.text+0xf48>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x12, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x26, [x23]
               	add	x21, x26, #0x1
               	str	x21, [x23]
               	ldrb	w22, [x26]
               	str	x22, [x12]
               	cmp	x22, #0x6e
               	b.ne	0x4014c0 <.text+0x1060>
               	b	0x4014a8 <.text+0x1048>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x12, [x26]
               	cmp	x12, #0x22
               	b.ne	0x4014f4 <.text+0x1094>
               	b	0x4014c4 <.text+0x1064>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x22, x19
               	mov	x26, #0xa               // =10
               	str	x26, [x22]
               	b	0x4014c0 <.text+0x1060>
               	b	0x40148c <.text+0x102c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x12, x19
               	ldr	x26, [x12]
               	add	x22, x26, #0x1
               	str	x22, [x12]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	ldr	x22, [x21]
               	strb	w22, [x26]
               	b	0x4014f4 <.text+0x1094>
               	b	0x401374 <.text+0xf14>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x26, x19
               	str	x24, [x26]
               	b	0x40150c <.text+0x10ac>
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x80              // =128
               	str	x21, [x26]
               	b	0x40150c <.text+0x10ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x3d              // =61
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	b.ne	0x401610 <.text+0x11b0>
               	b	0x4015ac <.text+0x114c>
               	b	0x401354 <.text+0xef4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x2b
               	b.ne	0x401660 <.text+0x1200>
               	b	0x401628 <.text+0x11c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	add	x26, x24, #0x1
               	str	x26, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x26, #0x95              // =149
               	str	x26, [x24]
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x8e              // =142
               	str	x21, [x26]
               	b	0x4015dc <.text+0x117c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x2b              // =43
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	b.ne	0x4016e0 <.text+0x1280>
               	b	0x40167c <.text+0x121c>
               	b	0x40158c <.text+0x112c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x2d
               	b.ne	0x401730 <.text+0x12d0>
               	b	0x4016f8 <.text+0x1298>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	add	x26, x24, #0x1
               	str	x26, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x26, #0xa2              // =162
               	str	x26, [x24]
               	b	0x4016ac <.text+0x124c>
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x9d              // =157
               	str	x21, [x26]
               	b	0x4016ac <.text+0x124c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x2d              // =45
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	b.ne	0x4017b0 <.text+0x1350>
               	b	0x40174c <.text+0x12ec>
               	b	0x40165c <.text+0x11fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x21
               	b.ne	0x401800 <.text+0x13a0>
               	b	0x4017c8 <.text+0x1368>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	add	x26, x24, #0x1
               	str	x26, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x26, #0xa3              // =163
               	str	x26, [x24]
               	b	0x40177c <.text+0x131c>
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x9e              // =158
               	str	x21, [x26]
               	b	0x40177c <.text+0x131c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x3d              // =61
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	b.ne	0x40184c <.text+0x13ec>
               	b	0x40181c <.text+0x13bc>
               	b	0x40172c <.text+0x12cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x26, [x21]
               	cmp	x26, #0x3c
               	b.ne	0x4018b8 <.text+0x1458>
               	b	0x401880 <.text+0x1420>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	add	x26, x24, #0x1
               	str	x26, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x26, #0x96              // =150
               	str	x26, [x24]
               	b	0x40184c <.text+0x13ec>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x21, [x26]
               	ldrb	w26, [x21]
               	mov	x17, #0x3d              // =61
               	eor	x21, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x21, x17
               	cmp	x26, #0x0
               	b.ne	0x401938 <.text+0x14d8>
               	b	0x4018d4 <.text+0x1474>
               	b	0x4017fc <.text+0x139c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0x3e
               	b.ne	0x4019ec <.text+0x158c>
               	b	0x4019b4 <.text+0x1554>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x24, x21, #0x1
               	str	x24, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x24, #0x99              // =153
               	str	x24, [x21]
               	b	0x401904 <.text+0x14a4>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x26, [x24]
               	ldrb	w24, [x26]
               	mov	x17, #0x3c              // =60
               	eor	x26, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x26, x17
               	cmp	x24, #0x0
               	b.ne	0x40199c <.text+0x153c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x26, [x24]
               	add	x21, x26, #0x1
               	str	x21, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x9b              // =155
               	str	x21, [x26]
               	b	0x401998 <.text+0x1538>
               	b	0x401904 <.text+0x14a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x24, #0x97              // =151
               	str	x24, [x21]
               	b	0x401998 <.text+0x1538>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x26, [x24]
               	ldrb	w24, [x26]
               	mov	x17, #0x3d              // =61
               	eor	x26, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x26, x17
               	cmp	x24, #0x0
               	b.ne	0x401a6c <.text+0x160c>
               	b	0x401a08 <.text+0x15a8>
               	b	0x4018b4 <.text+0x1454>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x7c
               	b.ne	0x401b20 <.text+0x16c0>
               	b	0x401ae8 <.text+0x1688>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x26, [x24]
               	add	x21, x26, #0x1
               	str	x21, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x9a              // =154
               	str	x21, [x26]
               	b	0x401a38 <.text+0x15d8>
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x3e              // =62
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	b.ne	0x401ad0 <.text+0x1670>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	add	x26, x24, #0x1
               	str	x26, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x26, #0x9c              // =156
               	str	x26, [x24]
               	b	0x401acc <.text+0x166c>
               	b	0x401a38 <.text+0x15d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x98              // =152
               	str	x21, [x26]
               	b	0x401acc <.text+0x166c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x7c              // =124
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	b.ne	0x401ba0 <.text+0x1740>
               	b	0x401b3c <.text+0x16dc>
               	b	0x4019e8 <.text+0x1588>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x26
               	b.ne	0x401bf0 <.text+0x1790>
               	b	0x401bb8 <.text+0x1758>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	add	x26, x24, #0x1
               	str	x26, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x26, #0x90              // =144
               	str	x26, [x24]
               	b	0x401b6c <.text+0x170c>
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x92              // =146
               	str	x21, [x26]
               	b	0x401b6c <.text+0x170c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	ldrb	w21, [x24]
               	mov	x17, #0x26              // =38
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	b.ne	0x401c70 <.text+0x1810>
               	b	0x401c0c <.text+0x17ac>
               	b	0x401b1c <.text+0x16bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x5e
               	b.ne	0x401cd4 <.text+0x1874>
               	b	0x401c88 <.text+0x1828>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x24, [x21]
               	add	x26, x24, #0x1
               	str	x26, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x26, #0x91              // =145
               	str	x26, [x24]
               	b	0x401c3c <.text+0x17dc>
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x21, #0x94              // =148
               	str	x21, [x26]
               	b	0x401c3c <.text+0x17dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x24, #0x93              // =147
               	str	x24, [x21]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401bec <.text+0x178c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x26, [x24]
               	cmp	x26, #0x25
               	b.ne	0x401d38 <.text+0x18d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x24, #0xa1              // =161
               	str	x24, [x26]
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401cd0 <.text+0x1870>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x2a
               	b.ne	0x401d9c <.text+0x193c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x24, #0x9f              // =159
               	str	x24, [x21]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401d34 <.text+0x18d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x26, [x24]
               	cmp	x26, #0x5b
               	b.ne	0x401e00 <.text+0x19a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x24, #0xa4              // =164
               	str	x24, [x26]
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401d98 <.text+0x1938>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x3f
               	b.ne	0x401e64 <.text+0x1a04>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x24, #0x8f              // =143
               	str	x24, [x21]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401dfc <.text+0x199c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x26, [x24]
               	cmp	x26, #0x7e
               	cset	x24, eq
               	sub	x17, x29, #0x138
               	str	x24, [x17]
               	cbnz	x24, 0x401eac <.text+0x1a4c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0x3b
               	cset	x26, eq
               	sub	x17, x29, #0x138
               	str	x26, [x17]
               	b	0x401eac <.text+0x1a4c>
               	sub	x16, x29, #0x138
               	ldr	x26, [x16]
               	sub	x17, x29, #0x130
               	str	x26, [x17]
               	cbnz	x26, 0x401ee4 <.text+0x1a84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x26, [x24]
               	cmp	x26, #0x7b
               	cset	x24, eq
               	sub	x17, x29, #0x130
               	str	x24, [x17]
               	b	0x401ee4 <.text+0x1a84>
               	sub	x16, x29, #0x130
               	ldr	x24, [x16]
               	sub	x17, x29, #0x128
               	str	x24, [x17]
               	cbnz	x24, 0x401f1c <.text+0x1abc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0x7d
               	cset	x26, eq
               	sub	x17, x29, #0x128
               	str	x26, [x17]
               	b	0x401f1c <.text+0x1abc>
               	sub	x16, x29, #0x128
               	ldr	x26, [x16]
               	sub	x17, x29, #0x120
               	str	x26, [x17]
               	cbnz	x26, 0x401f54 <.text+0x1af4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x26, [x24]
               	cmp	x26, #0x28
               	cset	x24, eq
               	sub	x17, x29, #0x120
               	str	x24, [x17]
               	b	0x401f54 <.text+0x1af4>
               	sub	x16, x29, #0x120
               	ldr	x24, [x16]
               	sub	x17, x29, #0x118
               	str	x24, [x17]
               	cbnz	x24, 0x401f8c <.text+0x1b2c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0x29
               	cset	x26, eq
               	sub	x17, x29, #0x118
               	str	x26, [x17]
               	b	0x401f8c <.text+0x1b2c>
               	sub	x16, x29, #0x118
               	ldr	x26, [x16]
               	sub	x17, x29, #0x110
               	str	x26, [x17]
               	cbnz	x26, 0x401fc4 <.text+0x1b64>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x26, [x24]
               	cmp	x26, #0x5d
               	cset	x24, eq
               	sub	x17, x29, #0x110
               	str	x24, [x17]
               	b	0x401fc4 <.text+0x1b64>
               	sub	x16, x29, #0x110
               	ldr	x24, [x16]
               	sub	x17, x29, #0x108
               	str	x24, [x17]
               	cbnz	x24, 0x401ffc <.text+0x1b9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0x2c
               	cset	x26, eq
               	sub	x17, x29, #0x108
               	str	x26, [x17]
               	b	0x401ffc <.text+0x1b9c>
               	sub	x16, x29, #0x108
               	ldr	x26, [x16]
               	stur	x26, [x29, #-0x100]
               	cbnz	x26, 0x40202c <.text+0x1bcc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x26, [x24]
               	cmp	x26, #0x3a
               	cset	x24, eq
               	stur	x24, [x29, #-0x100]
               	b	0x40202c <.text+0x1bcc>
               	ldur	x24, [x29, #-0x100]
               	cbz	x24, 0x402068 <.text+0x1c08>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401e60 <.text+0x1a00>
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
               	b.ne	0x40210c <.text+0x1cac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d2
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x14, x19
               	ldr	x22, [x14]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x402108 <.text+0x1ca8>
               	b	0x4032e8 <.text+0x2e88>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0x80
               	b.ne	0x402184 <.text+0x1d24>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	mov	x24, #0x1               // =1
               	str	x24, [x21]
               	ldr	x11, [x22]
               	add	x21, x11, #0x8
               	str	x21, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x11, x19
               	ldr	x22, [x11]
               	str	x22, [x21]
               	bl	0x4005b0 <.text+0x150>
               	mov	x11, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x11, x19
               	str	x24, [x11]
               	b	0x402180 <.text+0x1d20>
               	b	0x402108 <.text+0x1ca8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x11, x19
               	ldr	x22, [x11]
               	cmp	x22, #0x22
               	b.ne	0x4021ec <.text+0x1d8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x11, [x22]
               	add	x24, x11, #0x8
               	str	x24, [x22]
               	mov	x11, #0x1               // =1
               	str	x11, [x24]
               	ldr	x21, [x22]
               	add	x11, x21, #0x8
               	str	x11, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	ldr	x22, [x21]
               	str	x22, [x11]
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	b	0x402208 <.text+0x1da8>
               	b	0x402180 <.text+0x1d20>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x8c
               	b.ne	0x402298 <.text+0x1e38>
               	b	0x402270 <.text+0x1e10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x21, [x22]
               	cmp	x21, #0x22
               	b.ne	0x40222c <.text+0x1dcc>
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	b	0x402208 <.text+0x1da8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x11, x21, #0x8
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x21, x11, x17
               	str	x21, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x11, x19
               	mov	x21, #0x2               // =2
               	str	x21, [x11]
               	b	0x4021e8 <.text+0x1d88>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0x28
               	b.ne	0x4022f0 <.text+0x1e90>
               	b	0x4022b4 <.text+0x1e54>
               	b	0x4021e8 <.text+0x1d88>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x23, [x25]
               	cmp	x23, #0x85
               	b.ne	0x402500 <.text+0x20a0>
               	b	0x4024c4 <.text+0x2064>
               	bl	0x4005b0 <.text+0x150>
               	mov	x22, x0
               	b	0x4022c0 <.text+0x1e60>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x21, [x23]
               	cmp	x21, #0x8a
               	b.ne	0x402354 <.text+0x1ef4>
               	b	0x402344 <.text+0x1ee4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f4
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x21, [x22]
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x4022c0 <.text+0x1e60>
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	b	0x402350 <.text+0x1ef0>
               	b	0x402390 <.text+0x1f30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x21, [x22]
               	cmp	x21, #0x86
               	b.ne	0x40238c <.text+0x1f2c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x23, #0x0               // =0
               	str	x23, [x21]
               	b	0x40238c <.text+0x1f2c>
               	b	0x402350 <.text+0x1ef0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x25, [x23]
               	cmp	x25, #0x9f
               	b.ne	0x4023cc <.text+0x1f6c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldr	x22, [x25]
               	add	x21, x22, #0x2
               	str	x21, [x25]
               	b	0x402390 <.text+0x1f30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x22, [x21]
               	cmp	x22, #0x29
               	b.ne	0x402438 <.text+0x1fd8>
               	bl	0x4005b0 <.text+0x150>
               	mov	x22, x0
               	b	0x4023f0 <.text+0x1f90>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x21, x23, #0x8
               	str	x21, [x25]
               	mov	x23, #0x1               // =1
               	str	x23, [x21]
               	ldr	x24, [x25]
               	add	x23, x24, #0x8
               	str	x23, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x0
               	b.ne	0x402498 <.text+0x2038>
               	b	0x40248c <.text+0x202c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x317
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x23, [x22]
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x4023f0 <.text+0x1f90>
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0x30]
               	b	0x4024a4 <.text+0x2044>
               	mov	x25, #0x8               // =8
               	stur	x25, [x29, #-0x30]
               	b	0x4024a4 <.text+0x2044>
               	ldur	x25, [x29, #-0x30]
               	str	x25, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x24]
               	b	0x402294 <.text+0x1e34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x25, [x23]
               	stur	x25, [x29, #-0x10]
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x25, [x23]
               	cmp	x25, #0x28
               	b.ne	0x402534 <.text+0x20d4>
               	b	0x40251c <.text+0x20bc>
               	b	0x402294 <.text+0x1e34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x28
               	b.ne	0x402928 <.text+0x24c8>
               	b	0x4028f8 <.text+0x2498>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	mov	x25, #0x0               // =0
               	stur	x25, [x29, #-0x8]
               	b	0x40254c <.text+0x20ec>
               	b	0x4024fc <.text+0x209c>
               	ldur	x21, [x29, #-0x10]
               	add	x22, x21, #0x18
               	ldr	x21, [x22]
               	cmp	x21, #0x80
               	b.ne	0x402780 <.text+0x2320>
               	b	0x40272c <.text+0x22cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x22, [x25]
               	cmp	x22, #0x29
               	b.eq	0x4025c0 <.text+0x2160>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x40206c <.text+0x1c0c>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x24, x23, #0x8
               	str	x24, [x25]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	sub	x25, x29, #0x8
               	ldr	x23, [x25]
               	add	x24, x23, #0x1
               	str	x24, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, #0x2c
               	b.ne	0x4025ec <.text+0x218c>
               	b	0x4025e0 <.text+0x2180>
               	bl	0x4005b0 <.text+0x150>
               	mov	x22, x0
               	ldur	x22, [x29, #-0x10]
               	add	x23, x22, #0x18
               	ldr	x22, [x23]
               	cmp	x22, #0x82
               	b.ne	0x402628 <.text+0x21c8>
               	b	0x4025f0 <.text+0x2190>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	b	0x4025ec <.text+0x218c>
               	b	0x40254c <.text+0x20ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x25, x23, #0x8
               	str	x25, [x22]
               	ldur	x23, [x29, #-0x10]
               	add	x22, x23, #0x28
               	ldr	x23, [x22]
               	str	x23, [x25]
               	b	0x40261c <.text+0x21bc>
               	ldur	x22, [x29, #-0x8]
               	cbz	x22, 0x40270c <.text+0x22ac>
               	b	0x4026d4 <.text+0x2274>
               	ldur	x23, [x29, #-0x10]
               	add	x22, x23, #0x18
               	ldr	x23, [x22]
               	cmp	x23, #0x81
               	b.ne	0x402680 <.text+0x2220>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x25, x22, #0x8
               	str	x25, [x23]
               	mov	x22, #0x3               // =3
               	str	x22, [x25]
               	ldr	x21, [x23]
               	add	x22, x21, #0x8
               	str	x22, [x23]
               	ldur	x21, [x29, #-0x10]
               	add	x23, x21, #0x28
               	ldr	x21, [x23]
               	str	x21, [x22]
               	b	0x40267c <.text+0x221c>
               	b	0x40261c <.text+0x21bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x33b
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x21, [x23]
               	mov	x0, x24
               	mov	x1, x21
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x40267c <.text+0x221c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x22, [x21]
               	add	x24, x22, #0x8
               	str	x24, [x21]
               	mov	x22, #0x7               // =7
               	str	x22, [x24]
               	ldr	x25, [x21]
               	add	x22, x25, #0x8
               	str	x22, [x21]
               	ldur	x25, [x29, #-0x8]
               	str	x25, [x22]
               	b	0x40270c <.text+0x22ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldur	x21, [x29, #-0x10]
               	add	x22, x21, #0x20
               	ldr	x21, [x22]
               	str	x21, [x25]
               	b	0x402530 <.text+0x20d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x22, [x21]
               	add	x25, x22, #0x8
               	str	x25, [x21]
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	ldr	x24, [x21]
               	add	x25, x24, #0x8
               	str	x25, [x21]
               	ldur	x24, [x29, #-0x10]
               	add	x21, x24, #0x28
               	ldr	x24, [x21]
               	str	x24, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	str	x22, [x21]
               	b	0x40277c <.text+0x231c>
               	b	0x402530 <.text+0x20d0>
               	ldur	x21, [x29, #-0x10]
               	add	x24, x21, #0x18
               	ldr	x21, [x24]
               	cmp	x21, #0x84
               	b.ne	0x402828 <.text+0x23c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x24, [x21]
               	add	x22, x24, #0x8
               	str	x22, [x21]
               	mov	x24, #0x0               // =0
               	str	x24, [x22]
               	ldr	x25, [x21]
               	add	x24, x25, #0x8
               	str	x24, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x25, x19
               	ldr	x21, [x25]
               	ldur	x25, [x29, #-0x10]
               	add	x22, x25, #0x28
               	ldr	x25, [x22]
               	sub	x22, x21, x25
               	str	x22, [x24]
               	b	0x4027e8 <.text+0x2388>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x21, [x25]
               	add	x23, x21, #0x8
               	str	x23, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldur	x25, [x29, #-0x10]
               	add	x24, x25, #0x20
               	ldr	x25, [x24]
               	str	x25, [x21]
               	cmp	x25, #0x0
               	b.ne	0x4028e0 <.text+0x2480>
               	b	0x4028d4 <.text+0x2474>
               	ldur	x22, [x29, #-0x10]
               	add	x25, x22, #0x18
               	ldr	x22, [x25]
               	cmp	x22, #0x83
               	b.ne	0x402880 <.text+0x2420>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x24, x25, #0x8
               	str	x24, [x22]
               	mov	x25, #0x1               // =1
               	str	x25, [x24]
               	ldr	x21, [x22]
               	add	x25, x21, #0x8
               	str	x25, [x22]
               	ldur	x21, [x29, #-0x10]
               	add	x22, x21, #0x28
               	ldr	x21, [x22]
               	str	x21, [x25]
               	b	0x40287c <.text+0x241c>
               	b	0x4027e8 <.text+0x2388>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x352
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x21, [x22]
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x40287c <.text+0x241c>
               	mov	x25, #0xa               // =10
               	stur	x25, [x29, #-0x38]
               	b	0x4028ec <.text+0x248c>
               	mov	x25, #0x9               // =9
               	stur	x25, [x29, #-0x38]
               	b	0x4028ec <.text+0x248c>
               	ldur	x25, [x29, #-0x38]
               	str	x25, [x23]
               	b	0x40277c <.text+0x231c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x8a
               	cset	x24, eq
               	stur	x24, [x29, #-0x40]
               	cbnz	x24, 0x402964 <.text+0x2504>
               	b	0x402944 <.text+0x24e4>
               	b	0x4024fc <.text+0x209c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x9f
               	b.ne	0x402b50 <.text+0x26f0>
               	b	0x402b18 <.text+0x26b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x86
               	cset	x22, eq
               	stur	x22, [x29, #-0x40]
               	b	0x402964 <.text+0x2504>
               	ldur	x22, [x29, #-0x40]
               	cbz	x22, 0x40298c <.text+0x252c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x8a
               	b.ne	0x4029c4 <.text+0x2564>
               	b	0x4029b8 <.text+0x2558>
               	b	0x402924 <.text+0x24c4>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x40206c <.text+0x1c0c>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x23, [x25]
               	cmp	x23, #0x29
               	b.ne	0x402ac4 <.text+0x2664>
               	b	0x402ab4 <.text+0x2654>
               	mov	x22, #0x1               // =1
               	stur	x22, [x29, #-0x48]
               	b	0x4029d0 <.text+0x2570>
               	mov	x22, #0x0               // =0
               	stur	x22, [x29, #-0x48]
               	b	0x4029d0 <.text+0x2570>
               	ldur	x22, [x29, #-0x48]
               	stur	x22, [x29, #-0x8]
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	b	0x4029e4 <.text+0x2584>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x9f
               	b.ne	0x402a14 <.text+0x25b4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	ldur	x24, [x29, #-0x8]
               	add	x25, x24, #0x2
               	stur	x25, [x29, #-0x8]
               	b	0x4029e4 <.text+0x2584>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x29
               	b.ne	0x402a60 <.text+0x2600>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	b	0x402a38 <.text+0x25d8>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldur	x24, [x29, #-0x8]
               	str	x24, [x22]
               	b	0x402988 <.text+0x2528>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x36a
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x22, [x24]
               	mov	x0, x25
               	mov	x1, x22
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x402a38 <.text+0x25d8>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	b	0x402ac0 <.text+0x2660>
               	b	0x402988 <.text+0x2528>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x378
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x24, [x23]
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x402ac0 <.text+0x2660>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	mov	x22, #0xa2              // =162
               	mov	x0, x22
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0x1
               	b.le	0x402bbc <.text+0x275c>
               	b	0x402b6c <.text+0x270c>
               	b	0x402924 <.text+0x24c4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x25, [x22]
               	cmp	x25, #0x94
               	b.ne	0x402c78 <.text+0x2818>
               	b	0x402c34 <.text+0x27d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x23, [x22]
               	sub	x25, x23, #0x2
               	str	x25, [x22]
               	b	0x402b88 <.text+0x2728>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x24, x25, #0x8
               	str	x24, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldr	x22, [x25]
               	cmp	x22, #0x0
               	b.ne	0x402c1c <.text+0x27bc>
               	b	0x402c10 <.text+0x27b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x392
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x0, x24
               	mov	x1, x25
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x402b88 <.text+0x2728>
               	mov	x22, #0xa               // =10
               	stur	x22, [x29, #-0x50]
               	b	0x402c28 <.text+0x27c8>
               	mov	x22, #0x9               // =9
               	stur	x22, [x29, #-0x50]
               	b	0x402c28 <.text+0x27c8>
               	ldur	x22, [x29, #-0x50]
               	str	x22, [x24]
               	b	0x402b4c <.text+0x26ec>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	mov	x22, #0xa2              // =162
               	mov	x0, x22
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldr	x23, [x22]
               	cmp	x23, #0xa
               	cset	x22, eq
               	stur	x22, [x29, #-0x58]
               	cbnz	x22, 0x402cb8 <.text+0x2858>
               	b	0x402c94 <.text+0x2834>
               	b	0x402b4c <.text+0x26ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x21
               	b.ne	0x402de8 <.text+0x2988>
               	b	0x402d5c <.text+0x28fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldr	x23, [x22]
               	cmp	x23, #0x9
               	cset	x22, eq
               	stur	x22, [x29, #-0x58]
               	b	0x402cb8 <.text+0x2858>
               	ldur	x22, [x29, #-0x58]
               	cbz	x22, 0x402d08 <.text+0x28a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x22, x17
               	str	x24, [x23]
               	b	0x402cec <.text+0x288c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x24, [x23]
               	add	x25, x24, #0x2
               	str	x25, [x23]
               	b	0x402c74 <.text+0x2814>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3a7
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x24, [x22]
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x402cec <.text+0x288c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	mov	x25, #0xa2              // =162
               	mov	x0, x25
               	bl	0x40206c <.text+0x1c0c>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x23, x25, #0x8
               	str	x23, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x23]
               	ldr	x21, [x22]
               	add	x25, x21, #0x8
               	str	x25, [x22]
               	mov	x21, #0x1               // =1
               	str	x21, [x25]
               	ldr	x23, [x22]
               	add	x25, x23, #0x8
               	str	x25, [x22]
               	mov	x23, #0x0               // =0
               	str	x23, [x25]
               	ldr	x10, [x22]
               	add	x23, x10, #0x8
               	str	x23, [x22]
               	mov	x10, #0x11              // =17
               	str	x10, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	str	x21, [x22]
               	b	0x402de4 <.text+0x2984>
               	b	0x402c74 <.text+0x2814>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x10, [x22]
               	cmp	x10, #0x7e
               	b.ne	0x402e98 <.text+0x2a38>
               	bl	0x4005b0 <.text+0x150>
               	mov	x10, x0
               	mov	x22, #0xa2              // =162
               	mov	x0, x22
               	bl	0x40206c <.text+0x1c0c>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x22, [x24]
               	add	x21, x22, #0x8
               	str	x21, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x21]
               	ldr	x23, [x24]
               	add	x22, x23, #0x8
               	str	x22, [x24]
               	mov	x23, #0x1               // =1
               	str	x23, [x22]
               	ldr	x21, [x24]
               	add	x22, x21, #0x8
               	str	x22, [x24]
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	str	x21, [x22]
               	ldr	x25, [x24]
               	add	x21, x25, #0x8
               	str	x21, [x24]
               	mov	x25, #0xf               // =15
               	str	x25, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	str	x23, [x24]
               	b	0x402e94 <.text+0x2a34>
               	b	0x402de4 <.text+0x2984>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x9d
               	b.ne	0x402ee4 <.text+0x2a84>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x26]
               	b	0x402ee0 <.text+0x2a80>
               	b	0x402e94 <.text+0x2a34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x23, [x24]
               	cmp	x23, #0x9e
               	b.ne	0x402f44 <.text+0x2ae4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x26, x25, #0x8
               	str	x26, [x23]
               	mov	x25, #0x1               // =1
               	str	x25, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x25, [x23]
               	cmp	x25, #0x80
               	b.ne	0x402fcc <.text+0x2b6c>
               	b	0x402f68 <.text+0x2b08>
               	b	0x402ee0 <.text+0x2a80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x23, [x24]
               	cmp	x23, #0xa2
               	cset	x24, eq
               	stur	x24, [x29, #-0x60]
               	cbnz	x24, 0x403054 <.text+0x2bf4>
               	b	0x403034 <.text+0x2bd4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x26, x23, #0x8
               	str	x26, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x23, x25, x17
               	str	x23, [x26]
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	b	0x402fb4 <.text+0x2b54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x21]
               	b	0x402f40 <.text+0x2ae0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x26, x25, #0x8
               	str	x26, [x24]
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	str	x25, [x26]
               	ldr	x21, [x24]
               	add	x25, x21, #0x8
               	str	x25, [x24]
               	mov	x21, #0xd               // =13
               	str	x21, [x25]
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	0x40206c <.text+0x1c0c>
               	mov	x21, x0
               	ldr	x21, [x24]
               	add	x23, x21, #0x8
               	str	x23, [x24]
               	mov	x21, #0x1b              // =27
               	str	x21, [x23]
               	b	0x402fb4 <.text+0x2b54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, #0xa3
               	cset	x23, eq
               	stur	x23, [x29, #-0x60]
               	b	0x403054 <.text+0x2bf4>
               	ldur	x23, [x29, #-0x60]
               	cbz	x23, 0x4030ac <.text+0x2c4c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x23, [x24]
               	stur	x23, [x29, #-0x8]
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	mov	x26, #0xa2              // =162
               	mov	x0, x26
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x26, [x23]
               	ldr	x23, [x26]
               	cmp	x23, #0xa
               	b.ne	0x40318c <.text+0x2d2c>
               	b	0x403100 <.text+0x2ca0>
               	b	0x402f40 <.text+0x2ae0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3dc
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x24, [x21]
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x4030a8 <.text+0x2c48>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x26, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	ldr	x25, [x23]
               	add	x21, x25, #0x8
               	str	x21, [x23]
               	mov	x25, #0xa               // =10
               	str	x25, [x21]
               	b	0x403130 <.text+0x2cd0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x24, x26, #0x8
               	str	x24, [x21]
               	mov	x26, #0xd               // =13
               	str	x26, [x24]
               	ldr	x23, [x21]
               	add	x26, x23, #0x8
               	str	x26, [x21]
               	mov	x23, #0x1               // =1
               	str	x23, [x26]
               	ldr	x24, [x21]
               	add	x23, x24, #0x8
               	str	x23, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x21, #0x2
               	b.le	0x40323c <.text+0x2ddc>
               	b	0x403230 <.text+0x2dd0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	ldr	x25, [x23]
               	cmp	x25, #0x9
               	b.ne	0x4031dc <.text+0x2d7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	mov	x21, #0xd               // =13
               	str	x21, [x23]
               	ldr	x26, [x25]
               	add	x21, x26, #0x8
               	str	x21, [x25]
               	mov	x26, #0x9               // =9
               	str	x26, [x21]
               	b	0x4031d8 <.text+0x2d78>
               	b	0x403130 <.text+0x2cd0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3bb
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x26, [x25]
               	mov	x0, x24
               	mov	x1, x26
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x4031d8 <.text+0x2d78>
               	mov	x21, #0x8               // =8
               	stur	x21, [x29, #-0x68]
               	b	0x403248 <.text+0x2de8>
               	mov	x21, #0x1               // =1
               	stur	x21, [x29, #-0x68]
               	b	0x403248 <.text+0x2de8>
               	ldur	x21, [x29, #-0x68]
               	str	x21, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x21, [x24]
               	add	x23, x21, #0x8
               	str	x23, [x24]
               	ldur	x21, [x29, #-0x8]
               	cmp	x21, #0xa2
               	b.ne	0x403280 <.text+0x2e20>
               	mov	x21, #0x19              // =25
               	stur	x21, [x29, #-0x70]
               	b	0x40328c <.text+0x2e2c>
               	mov	x21, #0x1a              // =26
               	stur	x21, [x29, #-0x70]
               	b	0x40328c <.text+0x2e2c>
               	ldur	x21, [x29, #-0x70]
               	str	x21, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x21, [x24]
               	add	x23, x21, #0x8
               	str	x23, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldr	x24, [x21]
               	cmp	x24, #0x0
               	b.ne	0x4032d0 <.text+0x2e70>
               	mov	x24, #0xc               // =12
               	stur	x24, [x29, #-0x78]
               	b	0x4032dc <.text+0x2e7c>
               	mov	x24, #0xb               // =11
               	stur	x24, [x29, #-0x78]
               	b	0x4032dc <.text+0x2e7c>
               	ldur	x24, [x29, #-0x78]
               	str	x24, [x23]
               	b	0x4030a8 <.text+0x2c48>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, x20
               	b.lt	0x403330 <.text+0x2ed0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x23, [x24]
               	stur	x23, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x23, [x24]
               	cmp	x23, #0x8e
               	b.ne	0x403398 <.text+0x2f38>
               	b	0x403364 <.text+0x2f04>
               	mov	x23, #0x0               // =0
               	mov	x0, x23
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
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	ldr	x23, [x21]
               	cmp	x23, #0xa
               	cset	x21, eq
               	stur	x21, [x29, #-0x80]
               	cbnz	x21, 0x4033d8 <.text+0x2f78>
               	b	0x4033b4 <.text+0x2f54>
               	b	0x4032e8 <.text+0x2e88>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	cmp	x26, #0x8f
               	b.ne	0x403524 <.text+0x30c4>
               	b	0x4034bc <.text+0x305c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	ldr	x23, [x21]
               	cmp	x23, #0x9
               	cset	x21, eq
               	stur	x21, [x29, #-0x80]
               	b	0x4033d8 <.text+0x2f78>
               	ldur	x21, [x29, #-0x80]
               	cbz	x21, 0x403444 <.text+0x2fe4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	mov	x23, #0xd               // =13
               	str	x23, [x21]
               	b	0x4033fc <.text+0x2f9c>
               	mov	x25, #0x8e              // =142
               	mov	x0, x25
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x24, x25, #0x8
               	str	x24, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldur	x23, [x29, #-0x8]
               	str	x23, [x25]
               	cmp	x23, #0x0
               	b.ne	0x4034a4 <.text+0x3044>
               	b	0x403498 <.text+0x3038>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3f0
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x23, [x25]
               	mov	x0, x24
               	mov	x1, x23
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x4033fc <.text+0x2f9c>
               	mov	x23, #0xc               // =12
               	stur	x23, [x29, #-0x88]
               	b	0x4034b0 <.text+0x3050>
               	mov	x23, #0xb               // =11
               	stur	x23, [x29, #-0x88]
               	b	0x4034b0 <.text+0x3050>
               	ldur	x23, [x29, #-0x88]
               	str	x23, [x24]
               	b	0x403394 <.text+0x2f34>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x24, x21, #0x8
               	str	x24, [x26]
               	mov	x21, #0x4               // =4
               	str	x21, [x24]
               	ldr	x25, [x26]
               	add	x21, x25, #0x8
               	str	x21, [x26]
               	stur	x21, [x29, #-0x10]
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x40206c <.text+0x1c0c>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x3a
               	b.ne	0x4035b0 <.text+0x3150>
               	b	0x403540 <.text+0x30e0>
               	b	0x403394 <.text+0x2f34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x25, [x23]
               	cmp	x25, #0x90
               	b.ne	0x403678 <.text+0x3218>
               	b	0x403604 <.text+0x31a4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	b	0x40354c <.text+0x30ec>
               	ldur	x26, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x24, x21, #0x18
               	str	x24, [x26]
               	ldr	x21, [x23]
               	add	x24, x21, #0x8
               	str	x24, [x23]
               	mov	x21, #0x2               // =2
               	str	x21, [x24]
               	ldr	x26, [x23]
               	add	x21, x26, #0x8
               	str	x21, [x23]
               	stur	x21, [x29, #-0x10]
               	mov	x25, #0x8f              // =143
               	mov	x0, x25
               	bl	0x40206c <.text+0x1c0c>
               	mov	x21, x0
               	ldur	x21, [x29, #-0x10]
               	ldr	x25, [x23]
               	add	x23, x25, #0x8
               	str	x23, [x21]
               	b	0x403520 <.text+0x30c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x40e
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x0, x21
               	mov	x1, x25
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x0, x26
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x40354c <.text+0x30ec>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x26, [x23]
               	add	x21, x26, #0x8
               	str	x21, [x23]
               	mov	x26, #0x5               // =5
               	str	x26, [x21]
               	ldr	x24, [x23]
               	add	x26, x24, #0x8
               	str	x26, [x23]
               	stur	x26, [x29, #-0x10]
               	mov	x25, #0x91              // =145
               	mov	x0, x25
               	bl	0x40206c <.text+0x1c0c>
               	mov	x26, x0
               	ldur	x26, [x29, #-0x10]
               	ldr	x25, [x23]
               	add	x23, x25, #0x8
               	str	x23, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x25]
               	b	0x403674 <.text+0x3214>
               	b	0x403520 <.text+0x30c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	cmp	x26, #0x91
               	b.ne	0x403704 <.text+0x32a4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x24, [x23]
               	add	x25, x24, #0x8
               	str	x25, [x23]
               	mov	x24, #0x4               // =4
               	str	x24, [x25]
               	ldr	x21, [x23]
               	add	x24, x21, #0x8
               	str	x24, [x23]
               	stur	x24, [x29, #-0x10]
               	mov	x26, #0x92              // =146
               	mov	x0, x26
               	bl	0x40206c <.text+0x1c0c>
               	mov	x24, x0
               	ldur	x24, [x29, #-0x10]
               	ldr	x26, [x23]
               	add	x23, x26, #0x8
               	str	x23, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x26]
               	b	0x403700 <.text+0x32a0>
               	b	0x403674 <.text+0x3214>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, #0x92
               	b.ne	0x403784 <.text+0x3324>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x26, x21, #0x8
               	str	x26, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	mov	x24, #0x93              // =147
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x21, x0
               	ldr	x21, [x23]
               	add	x24, x21, #0x8
               	str	x24, [x23]
               	mov	x21, #0xe               // =14
               	str	x21, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x23]
               	b	0x403780 <.text+0x3320>
               	b	0x403700 <.text+0x32a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x24, [x21]
               	cmp	x24, #0x93
               	b.ne	0x403804 <.text+0x33a4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x25, [x21]
               	add	x23, x25, #0x8
               	str	x23, [x21]
               	mov	x25, #0xd               // =13
               	str	x25, [x23]
               	mov	x24, #0x94              // =148
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x25, x0
               	ldr	x25, [x21]
               	add	x24, x25, #0x8
               	str	x24, [x21]
               	mov	x25, #0xf               // =15
               	str	x25, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	b	0x403800 <.text+0x33a0>
               	b	0x403780 <.text+0x3320>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x94
               	b.ne	0x403884 <.text+0x3424>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x26, [x25]
               	add	x21, x26, #0x8
               	str	x21, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x21]
               	mov	x24, #0x95              // =149
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x26, x0
               	ldr	x26, [x25]
               	add	x24, x26, #0x8
               	str	x24, [x25]
               	mov	x26, #0x10              // =16
               	str	x26, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x25]
               	b	0x403880 <.text+0x3420>
               	b	0x403800 <.text+0x33a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0x95
               	b.ne	0x403904 <.text+0x34a4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x23, [x26]
               	add	x25, x23, #0x8
               	str	x25, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x25]
               	mov	x24, #0x97              // =151
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	ldr	x23, [x26]
               	add	x24, x23, #0x8
               	str	x24, [x26]
               	mov	x23, #0x11              // =17
               	str	x23, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x26]
               	b	0x403900 <.text+0x34a0>
               	b	0x403880 <.text+0x3420>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, #0x96
               	b.ne	0x403984 <.text+0x3524>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x26, x21, #0x8
               	str	x26, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	mov	x24, #0x97              // =151
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x21, x0
               	ldr	x21, [x23]
               	add	x24, x21, #0x8
               	str	x24, [x23]
               	mov	x21, #0x12              // =18
               	str	x21, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x23]
               	b	0x403980 <.text+0x3520>
               	b	0x403900 <.text+0x34a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x24, [x21]
               	cmp	x24, #0x97
               	b.ne	0x403a04 <.text+0x35a4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x25, [x21]
               	add	x23, x25, #0x8
               	str	x23, [x21]
               	mov	x25, #0xd               // =13
               	str	x25, [x23]
               	mov	x24, #0x9b              // =155
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x25, x0
               	ldr	x25, [x21]
               	add	x24, x25, #0x8
               	str	x24, [x21]
               	mov	x25, #0x13              // =19
               	str	x25, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	b	0x403a00 <.text+0x35a0>
               	b	0x403980 <.text+0x3520>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x98
               	b.ne	0x403a84 <.text+0x3624>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x26, [x25]
               	add	x21, x26, #0x8
               	str	x21, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x21]
               	mov	x24, #0x9b              // =155
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x26, x0
               	ldr	x26, [x25]
               	add	x24, x26, #0x8
               	str	x24, [x25]
               	mov	x26, #0x14              // =20
               	str	x26, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x25]
               	b	0x403a80 <.text+0x3620>
               	b	0x403a00 <.text+0x35a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0x99
               	b.ne	0x403b04 <.text+0x36a4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x23, [x26]
               	add	x25, x23, #0x8
               	str	x25, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x25]
               	mov	x24, #0x9b              // =155
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	ldr	x23, [x26]
               	add	x24, x23, #0x8
               	str	x24, [x26]
               	mov	x23, #0x15              // =21
               	str	x23, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x26]
               	b	0x403b00 <.text+0x36a0>
               	b	0x403a80 <.text+0x3620>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, #0x9a
               	b.ne	0x403b84 <.text+0x3724>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x26, x21, #0x8
               	str	x26, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	mov	x24, #0x9b              // =155
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x21, x0
               	ldr	x21, [x23]
               	add	x24, x21, #0x8
               	str	x24, [x23]
               	mov	x21, #0x16              // =22
               	str	x21, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x23]
               	b	0x403b80 <.text+0x3720>
               	b	0x403b00 <.text+0x36a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x24, [x21]
               	cmp	x24, #0x9b
               	b.ne	0x403c04 <.text+0x37a4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x25, [x21]
               	add	x23, x25, #0x8
               	str	x23, [x21]
               	mov	x25, #0xd               // =13
               	str	x25, [x23]
               	mov	x24, #0x9d              // =157
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x25, x0
               	ldr	x25, [x21]
               	add	x24, x25, #0x8
               	str	x24, [x21]
               	mov	x25, #0x17              // =23
               	str	x25, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	b	0x403c00 <.text+0x37a0>
               	b	0x403b80 <.text+0x3720>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x9c
               	b.ne	0x403c84 <.text+0x3824>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x26, [x25]
               	add	x21, x26, #0x8
               	str	x21, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x21]
               	mov	x24, #0x9d              // =157
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x26, x0
               	ldr	x26, [x25]
               	add	x24, x26, #0x8
               	str	x24, [x25]
               	mov	x26, #0x18              // =24
               	str	x26, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x25]
               	b	0x403c80 <.text+0x3820>
               	b	0x403c00 <.text+0x37a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0x9d
               	b.ne	0x403cf8 <.text+0x3898>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x25, x23, #0x8
               	str	x25, [x24]
               	mov	x23, #0xd               // =13
               	str	x23, [x25]
               	mov	x26, #0x9f              // =159
               	mov	x0, x26
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldur	x26, [x29, #-0x8]
               	str	x26, [x23]
               	cmp	x26, #0x2
               	b.le	0x403d74 <.text+0x3914>
               	b	0x403d14 <.text+0x38b4>
               	b	0x403c80 <.text+0x3820>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x25, [x26]
               	cmp	x25, #0x9e
               	b.ne	0x403dec <.text+0x398c>
               	b	0x403d98 <.text+0x3938>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x25, [x26]
               	add	x23, x25, #0x8
               	str	x23, [x26]
               	mov	x25, #0xd               // =13
               	str	x25, [x23]
               	ldr	x21, [x26]
               	add	x25, x21, #0x8
               	str	x25, [x26]
               	mov	x21, #0x1               // =1
               	str	x21, [x25]
               	ldr	x23, [x26]
               	add	x21, x23, #0x8
               	str	x21, [x26]
               	mov	x23, #0x8               // =8
               	str	x23, [x21]
               	ldr	x25, [x26]
               	add	x23, x25, #0x8
               	str	x23, [x26]
               	mov	x25, #0x1b              // =27
               	str	x25, [x23]
               	b	0x403d74 <.text+0x3914>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x26, [x25]
               	add	x23, x26, #0x8
               	str	x23, [x25]
               	mov	x26, #0x19              // =25
               	str	x26, [x23]
               	b	0x403cf4 <.text+0x3894>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x23, x24, #0x8
               	str	x23, [x25]
               	mov	x24, #0xd               // =13
               	str	x24, [x23]
               	mov	x26, #0x9f              // =159
               	mov	x0, x26
               	bl	0x40206c <.text+0x1c0c>
               	mov	x24, x0
               	ldur	x24, [x29, #-0x8]
               	cmp	x24, #0x2
               	cset	x26, gt
               	stur	x26, [x29, #-0x90]
               	cbz	x26, 0x403e2c <.text+0x39cc>
               	b	0x403e08 <.text+0x39a8>
               	b	0x403cf4 <.text+0x3894>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x26, [x22]
               	cmp	x26, #0x9f
               	b.ne	0x403fdc <.text+0x3b7c>
               	b	0x403f74 <.text+0x3b14>
               	ldur	x24, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	ldr	x23, [x26]
               	cmp	x24, x23
               	cset	x26, eq
               	stur	x26, [x29, #-0x90]
               	b	0x403e2c <.text+0x39cc>
               	ldur	x26, [x29, #-0x90]
               	cbz	x26, 0x403ebc <.text+0x3a5c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x26, [x23]
               	add	x24, x26, #0x8
               	str	x24, [x23]
               	mov	x26, #0x1a              // =26
               	str	x26, [x24]
               	ldr	x21, [x23]
               	add	x26, x21, #0x8
               	str	x26, [x23]
               	mov	x21, #0xd               // =13
               	str	x21, [x26]
               	ldr	x24, [x23]
               	add	x21, x24, #0x8
               	str	x21, [x23]
               	mov	x24, #0x1               // =1
               	str	x24, [x21]
               	ldr	x26, [x23]
               	add	x21, x26, #0x8
               	str	x21, [x23]
               	mov	x26, #0x8               // =8
               	str	x26, [x21]
               	ldr	x22, [x23]
               	add	x26, x22, #0x8
               	str	x26, [x23]
               	mov	x22, #0x1c              // =28
               	str	x22, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	str	x24, [x23]
               	b	0x403eb8 <.text+0x3a58>
               	b	0x403de8 <.text+0x3988>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x23]
               	cmp	x22, #0x2
               	b.le	0x403f50 <.text+0x3af0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x23, x24, #0x8
               	str	x23, [x22]
               	mov	x24, #0xd               // =13
               	str	x24, [x23]
               	ldr	x26, [x22]
               	add	x24, x26, #0x8
               	str	x24, [x22]
               	mov	x26, #0x1               // =1
               	str	x26, [x24]
               	ldr	x23, [x22]
               	add	x26, x23, #0x8
               	str	x26, [x22]
               	mov	x23, #0x8               // =8
               	str	x23, [x26]
               	ldr	x24, [x22]
               	add	x23, x24, #0x8
               	str	x23, [x22]
               	mov	x24, #0x1b              // =27
               	str	x24, [x23]
               	ldr	x26, [x22]
               	add	x24, x26, #0x8
               	str	x24, [x22]
               	mov	x26, #0x1a              // =26
               	str	x26, [x24]
               	b	0x403f4c <.text+0x3aec>
               	b	0x403eb8 <.text+0x3a58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x22, [x26]
               	add	x24, x22, #0x8
               	str	x24, [x26]
               	mov	x22, #0x1a              // =26
               	str	x22, [x24]
               	b	0x403f4c <.text+0x3aec>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x24, x25, #0x8
               	str	x24, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x24]
               	mov	x26, #0xa2              // =162
               	mov	x0, x26
               	bl	0x40206c <.text+0x1c0c>
               	mov	x25, x0
               	ldr	x25, [x22]
               	add	x26, x25, #0x8
               	str	x26, [x22]
               	mov	x25, #0x1b              // =27
               	str	x25, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x22]
               	b	0x403fd8 <.text+0x3b78>
               	b	0x403de8 <.text+0x3988>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x26, [x25]
               	cmp	x26, #0xa0
               	b.ne	0x40405c <.text+0x3bfc>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x22, x23, #0x8
               	str	x22, [x25]
               	mov	x23, #0xd               // =13
               	str	x23, [x22]
               	mov	x26, #0xa2              // =162
               	mov	x0, x26
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	ldr	x23, [x25]
               	add	x26, x23, #0x8
               	str	x26, [x25]
               	mov	x23, #0x1c              // =28
               	str	x23, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x25]
               	b	0x404058 <.text+0x3bf8>
               	b	0x403fd8 <.text+0x3b78>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	cmp	x26, #0xa1
               	b.ne	0x4040dc <.text+0x3c7c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x24, [x23]
               	add	x25, x24, #0x8
               	str	x25, [x23]
               	mov	x24, #0xd               // =13
               	str	x24, [x25]
               	mov	x26, #0xa2              // =162
               	mov	x0, x26
               	bl	0x40206c <.text+0x1c0c>
               	mov	x24, x0
               	ldr	x24, [x23]
               	add	x26, x24, #0x8
               	str	x26, [x23]
               	mov	x24, #0x1d              // =29
               	str	x24, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x23]
               	b	0x4040d8 <.text+0x3c78>
               	b	0x404058 <.text+0x3bf8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x26, [x24]
               	cmp	x26, #0xa2
               	cset	x24, eq
               	stur	x24, [x29, #-0x98]
               	cbnz	x24, 0x40411c <.text+0x3cbc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x24, [x26]
               	cmp	x24, #0xa3
               	cset	x26, eq
               	stur	x26, [x29, #-0x98]
               	b	0x40411c <.text+0x3cbc>
               	ldur	x26, [x29, #-0x98]
               	cbz	x26, 0x404148 <.text+0x3ce8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x26, [x24]
               	ldr	x24, [x26]
               	cmp	x24, #0xa
               	b.ne	0x4041f0 <.text+0x3d90>
               	b	0x404164 <.text+0x3d04>
               	b	0x4040d8 <.text+0x3c78>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0xa4
               	b.ne	0x404480 <.text+0x4020>
               	b	0x404428 <.text+0x3fc8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x26, [x24]
               	mov	x23, #0xd               // =13
               	str	x23, [x26]
               	ldr	x25, [x24]
               	add	x23, x25, #0x8
               	str	x23, [x24]
               	mov	x25, #0xa               // =10
               	str	x25, [x23]
               	b	0x404194 <.text+0x3d34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x26, [x23]
               	add	x22, x26, #0x8
               	str	x22, [x23]
               	mov	x26, #0xd               // =13
               	str	x26, [x22]
               	ldr	x24, [x23]
               	add	x26, x24, #0x8
               	str	x26, [x23]
               	mov	x24, #0x1               // =1
               	str	x24, [x26]
               	ldr	x22, [x23]
               	add	x24, x22, #0x8
               	str	x24, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x23, [x22]
               	cmp	x23, #0x2
               	b.le	0x4042a0 <.text+0x3e40>
               	b	0x404294 <.text+0x3e34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x24, [x25]
               	ldr	x25, [x24]
               	cmp	x25, #0x9
               	b.ne	0x404240 <.text+0x3de0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x24, [x25]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	ldr	x26, [x25]
               	add	x23, x26, #0x8
               	str	x23, [x25]
               	mov	x26, #0x9               // =9
               	str	x26, [x23]
               	b	0x40423c <.text+0x3ddc>
               	b	0x404194 <.text+0x3d34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x42d
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x26, [x25]
               	mov	x0, x22
               	mov	x1, x26
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x40423c <.text+0x3ddc>
               	mov	x23, #0x8               // =8
               	stur	x23, [x29, #-0xa0]
               	b	0x4042ac <.text+0x3e4c>
               	mov	x23, #0x1               // =1
               	stur	x23, [x29, #-0xa0]
               	b	0x4042ac <.text+0x3e4c>
               	ldur	x23, [x29, #-0xa0]
               	str	x23, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x24, x23, #0x8
               	str	x24, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0xa2
               	b.ne	0x4042f0 <.text+0x3e90>
               	mov	x22, #0x19              // =25
               	stur	x22, [x29, #-0xa8]
               	b	0x4042fc <.text+0x3e9c>
               	mov	x22, #0x1a              // =26
               	stur	x22, [x29, #-0xa8]
               	b	0x4042fc <.text+0x3e9c>
               	ldur	x22, [x29, #-0xa8]
               	str	x22, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x24, x22, #0x8
               	str	x24, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x23, [x22]
               	cmp	x23, #0x0
               	b.ne	0x404340 <.text+0x3ee0>
               	mov	x23, #0xc               // =12
               	stur	x23, [x29, #-0xb0]
               	b	0x40434c <.text+0x3eec>
               	mov	x23, #0xb               // =11
               	stur	x23, [x29, #-0xb0]
               	b	0x40434c <.text+0x3eec>
               	ldur	x23, [x29, #-0xb0]
               	str	x23, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x24, x23, #0x8
               	str	x24, [x22]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	ldr	x26, [x22]
               	add	x23, x26, #0x8
               	str	x23, [x22]
               	mov	x26, #0x1               // =1
               	str	x26, [x23]
               	ldr	x24, [x22]
               	add	x26, x24, #0x8
               	str	x26, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x2
               	b.le	0x4043b8 <.text+0x3f58>
               	mov	x22, #0x8               // =8
               	stur	x22, [x29, #-0xb8]
               	b	0x4043c4 <.text+0x3f64>
               	mov	x22, #0x1               // =1
               	stur	x22, [x29, #-0xb8]
               	b	0x4043c4 <.text+0x3f64>
               	ldur	x22, [x29, #-0xb8]
               	str	x22, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x22, [x24]
               	add	x26, x22, #0x8
               	str	x26, [x24]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0xa2
               	b.ne	0x404408 <.text+0x3fa8>
               	mov	x24, #0x1a              // =26
               	stur	x24, [x29, #-0xc0]
               	b	0x404414 <.text+0x3fb4>
               	mov	x24, #0x19              // =25
               	stur	x24, [x29, #-0xc0]
               	b	0x404414 <.text+0x3fb4>
               	ldur	x24, [x29, #-0xc0]
               	str	x24, [x26]
               	bl	0x4005b0 <.text+0x150>
               	mov	x22, x0
               	b	0x404144 <.text+0x3ce4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x26, x25, #0x8
               	str	x26, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x24, #0x8e              // =142
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x5d
               	b.ne	0x404504 <.text+0x40a4>
               	b	0x4044e8 <.text+0x4088>
               	b	0x404144 <.text+0x3ce4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x486
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x24, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x22, [x25]
               	mov	x0, x26
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x40447c <.text+0x401c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	b	0x4044f4 <.text+0x4094>
               	ldur	x26, [x29, #-0x8]
               	cmp	x26, #0x2
               	b.le	0x404608 <.text+0x41a8>
               	b	0x404558 <.text+0x40f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x44f
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x22, [x24]
               	mov	x0, x25
               	mov	x1, x22
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x0, x26
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x4044f4 <.text+0x4094>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x22, [x26]
               	add	x25, x22, #0x8
               	str	x25, [x26]
               	mov	x22, #0xd               // =13
               	str	x22, [x25]
               	ldr	x23, [x26]
               	add	x22, x23, #0x8
               	str	x22, [x26]
               	mov	x23, #0x1               // =1
               	str	x23, [x22]
               	ldr	x25, [x26]
               	add	x23, x25, #0x8
               	str	x23, [x26]
               	mov	x25, #0x8               // =8
               	str	x25, [x23]
               	ldr	x22, [x26]
               	add	x25, x22, #0x8
               	str	x25, [x26]
               	mov	x22, #0x1b              // =27
               	str	x22, [x25]
               	b	0x4045b8 <.text+0x4158>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x22, [x25]
               	add	x24, x22, #0x8
               	str	x24, [x25]
               	mov	x22, #0x19              // =25
               	str	x22, [x24]
               	ldr	x23, [x25]
               	add	x22, x23, #0x8
               	str	x22, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldur	x25, [x29, #-0x8]
               	sub	x24, x25, #0x2
               	str	x24, [x23]
               	cmp	x24, #0x0
               	b.ne	0x404678 <.text+0x4218>
               	b	0x40466c <.text+0x420c>
               	ldur	x22, [x29, #-0x8]
               	cmp	x22, #0x2
               	b.ge	0x404668 <.text+0x4208>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46b
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x26, x19
               	ldr	x22, [x26]
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x404668 <.text+0x4208>
               	b	0x4045b8 <.text+0x4158>
               	mov	x24, #0xa               // =10
               	stur	x24, [x29, #-0xc8]
               	b	0x404684 <.text+0x4224>
               	mov	x24, #0x9               // =9
               	stur	x24, [x29, #-0xc8]
               	b	0x404684 <.text+0x4224>
               	ldur	x24, [x29, #-0xc8]
               	str	x24, [x22]
               	b	0x40447c <.text+0x401c>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x15, x19
               	ldr	x14, [x15]
               	cmp	x14, #0x89
               	b.ne	0x40471c <.text+0x42bc>
               	bl	0x4005b0 <.text+0x150>
               	mov	x14, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x14, x19
               	ldr	x20, [x14]
               	cmp	x20, #0x28
               	b.ne	0x404770 <.text+0x4310>
               	b	0x404738 <.text+0x42d8>
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x12, [x23]
               	cmp	x12, #0x8d
               	b.ne	0x40492c <.text+0x44cc>
               	b	0x4048ec <.text+0x448c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x20, x0
               	b	0x404744 <.text+0x42e4>
               	mov	x20, #0x8e              // =142
               	mov	x0, x20
               	bl	0x40206c <.text+0x1c0c>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x20, [x21]
               	cmp	x20, #0x29
               	b.ne	0x404824 <.text+0x43c4>
               	b	0x4047c4 <.text+0x4364>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4a0
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x21, [x20]
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x404744 <.text+0x42e4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x20, x0
               	b	0x4047d0 <.text+0x4370>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	mov	x23, #0x4               // =4
               	str	x23, [x21]
               	ldr	x12, [x22]
               	add	x23, x12, #0x8
               	str	x23, [x22]
               	stur	x23, [x29, #-0x10]
               	bl	0x404690 <.text+0x4230>
               	mov	x12, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x12, x19
               	ldr	x23, [x12]
               	cmp	x23, #0x87
               	b.ne	0x4048cc <.text+0x446c>
               	b	0x404878 <.text+0x4418>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4b9
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x23, [x20]
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x4047d0 <.text+0x4370>
               	ldur	x23, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	ldr	x22, [x12]
               	add	x21, x22, #0x18
               	str	x21, [x23]
               	ldr	x22, [x12]
               	add	x21, x22, #0x8
               	str	x21, [x12]
               	mov	x22, #0x2               // =2
               	str	x22, [x21]
               	ldr	x23, [x12]
               	add	x22, x23, #0x8
               	str	x22, [x12]
               	stur	x22, [x29, #-0x10]
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	bl	0x404690 <.text+0x4230>
               	mov	x23, x0
               	b	0x4048cc <.text+0x446c>
               	ldur	x22, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x12, [x23]
               	add	x23, x12, #0x8
               	str	x23, [x22]
               	b	0x4046f0 <.text+0x4290>
               	bl	0x4005b0 <.text+0x150>
               	mov	x12, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	ldr	x20, [x12]
               	add	x12, x20, #0x8
               	stur	x12, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x12, [x20]
               	cmp	x12, #0x28
               	b.ne	0x404980 <.text+0x4520>
               	b	0x404948 <.text+0x44e8>
               	b	0x4046f0 <.text+0x4290>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x23, [x24]
               	cmp	x23, #0x8b
               	b.ne	0x404ad0 <.text+0x4670>
               	b	0x404aa8 <.text+0x4648>
               	bl	0x4005b0 <.text+0x150>
               	mov	x12, x0
               	b	0x404954 <.text+0x44f4>
               	mov	x24, #0x8e              // =142
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, #0x29
               	b.ne	0x404a54 <.text+0x45f4>
               	b	0x4049d4 <.text+0x4574>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4d3
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x12, x19
               	ldr	x23, [x12]
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x404954 <.text+0x44f4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x24, x0
               	b	0x4049e0 <.text+0x4580>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x22, [x24]
               	add	x23, x22, #0x8
               	str	x23, [x24]
               	mov	x22, #0x4               // =4
               	str	x22, [x23]
               	ldr	x21, [x24]
               	add	x22, x21, #0x8
               	str	x22, [x24]
               	stur	x22, [x29, #-0x10]
               	bl	0x404690 <.text+0x4230>
               	mov	x21, x0
               	ldr	x21, [x24]
               	add	x22, x21, #0x8
               	str	x22, [x24]
               	mov	x21, #0x2               // =2
               	str	x21, [x22]
               	ldr	x23, [x24]
               	add	x21, x23, #0x8
               	str	x21, [x24]
               	ldur	x23, [x29, #-0x8]
               	str	x23, [x21]
               	ldur	x22, [x29, #-0x10]
               	ldr	x23, [x24]
               	add	x24, x23, #0x8
               	str	x24, [x22]
               	b	0x404928 <.text+0x44c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4ec
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x22, [x24]
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x4049e0 <.text+0x4580>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x20, [x23]
               	cmp	x20, #0x3b
               	b.eq	0x404b00 <.text+0x46a0>
               	b	0x404aec <.text+0x468c>
               	b	0x404928 <.text+0x44c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x20, [x22]
               	cmp	x20, #0x7b
               	b.ne	0x404bac <.text+0x474c>
               	b	0x404b9c <.text+0x473c>
               	mov	x24, #0x8e              // =142
               	mov	x0, x24
               	bl	0x40206c <.text+0x1c0c>
               	mov	x23, x0
               	b	0x404b00 <.text+0x46a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x22, x23, #0x8
               	str	x22, [x24]
               	mov	x23, #0x8               // =8
               	str	x23, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x23, [x24]
               	cmp	x23, #0x3b
               	b.ne	0x404b48 <.text+0x46e8>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	b	0x404b44 <.text+0x46e4>
               	b	0x404acc <.text+0x466c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x506
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x20, [x23]
               	mov	x0, x24
               	mov	x1, x20
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x404b44 <.text+0x46e4>
               	bl	0x4005b0 <.text+0x150>
               	mov	x20, x0
               	b	0x404bc8 <.text+0x4768>
               	b	0x404acc <.text+0x466c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0x3b
               	b.ne	0x404c08 <.text+0x47a8>
               	b	0x404bf8 <.text+0x4798>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x20, [x23]
               	cmp	x20, #0x7d
               	b.eq	0x404bec <.text+0x478c>
               	bl	0x404690 <.text+0x4230>
               	mov	x23, x0
               	b	0x404bc8 <.text+0x4768>
               	bl	0x4005b0 <.text+0x150>
               	mov	x22, x0
               	b	0x404ba8 <.text+0x4748>
               	bl	0x4005b0 <.text+0x150>
               	mov	x22, x0
               	b	0x404c04 <.text+0x47a4>
               	b	0x404ba8 <.text+0x4748>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	0x40206c <.text+0x1c0c>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x23, [x22]
               	cmp	x23, #0x3b
               	b.ne	0x404c40 <.text+0x47e0>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	b	0x404c3c <.text+0x47dc>
               	b	0x404c04 <.text+0x47a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x51e
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x20, [x23]
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	0x4070ac <exit>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x404c3c <.text+0x47dc>
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
               	cbz	x15, 0x404d50 <.text+0x48f0>
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
               	b	0x404d50 <.text+0x48f0>
               	ldur	x15, [x29, #-0xa0]
               	stur	x15, [x29, #-0x98]
               	cbz	x15, 0x404d90 <.text+0x4930>
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
               	b	0x404d90 <.text+0x4930>
               	ldur	x13, [x29, #-0x98]
               	cbz	x13, 0x404de0 <.text+0x4980>
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
               	b	0x404de0 <.text+0x4980>
               	ldur	x14, [x29, #0x10]
               	cmp	x14, #0x0
               	cset	x15, gt
               	stur	x15, [x29, #-0xb0]
               	cbz	x15, 0x404e24 <.text+0x49c4>
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
               	b	0x404e24 <.text+0x49c4>
               	ldur	x15, [x29, #-0xb0]
               	stur	x15, [x29, #-0xa8]
               	cbz	x15, 0x404e64 <.text+0x4a04>
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
               	b	0x404e64 <.text+0x4a04>
               	ldur	x14, [x29, #-0xa8]
               	cbz	x14, 0x404eb4 <.text+0x4a54>
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
               	b	0x404eb4 <.text+0x4a54>
               	ldur	x13, [x29, #0x10]
               	cmp	x13, #0x1
               	b.ge	0x404f24 <.text+0x4ac4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x536
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	mov	x0, x15
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
               	bl	0x4070b8 <open>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ge	0x404fbc <.text+0x4b5c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x554
               	mov	x23, x19
               	ldur	x22, [x29, #0x20]
               	ldr	x21, [x22]
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
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
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x21, #0x40000           // =262144
               	sxtw	x24, w21
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x21, x19
               	mov	x0, x24
               	bl	0x4070c4 <malloc>
               	mov	x23, x0
               	str	x23, [x21]
               	cmp	x23, #0x0
               	b.ne	0x405050 <.text+0x4bf0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x568
               	mov	x22, x19
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0xffff            // =65535
               	movk	x11, #0xffff, lsl #16
               	movk	x11, #0xffff, lsl #32
               	movk	x11, #0xffff, lsl #48
               	mov	x0, x11
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
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	mov	x0, x24
               	bl	0x4070c4 <malloc>
               	mov	x21, x0
               	str	x21, [x22]
               	str	x21, [x23]
               	cmp	x21, #0x0
               	b.ne	0x4050ec <.text+0x4c8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x58a
               	mov	x25, x19
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0xffff            // =65535
               	movk	x10, #0xffff, lsl #16
               	movk	x10, #0xffff, lsl #32
               	movk	x10, #0xffff, lsl #48
               	mov	x0, x10
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
               	mov	x21, x19
               	mov	x0, x24
               	bl	0x4070c4 <malloc>
               	mov	x10, x0
               	str	x10, [x21]
               	cmp	x10, #0x0
               	b.ne	0x405178 <.text+0x4d18>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5aa
               	mov	x25, x19
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
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
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x0, x24
               	bl	0x4070c4 <malloc>
               	mov	x25, x0
               	stur	x25, [x29, #-0x38]
               	cmp	x25, #0x0
               	b.ne	0x4051f8 <.text+0x4d98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ca
               	mov	x26, x19
               	mov	x0, x26
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
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
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x26, x19
               	ldr	x25, [x26]
               	mov	x23, #0x0               // =0
               	mov	x0, x25
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x4070d0 <memset>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x26, [x21]
               	mov	x0, x26
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x4070d0 <memset>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x21, x19
               	ldr	x25, [x21]
               	mov	x0, x25
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x4070d0 <memset>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5eb
               	mov	x25, x19
               	str	x25, [x21]
               	mov	x23, #0x86              // =134
               	stur	x23, [x29, #-0x58]
               	b	0x405290 <.text+0x4e30>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x8d
               	b.gt	0x4052cc <.text+0x4e6c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x26, [x23]
               	sub	x23, x29, #0x58
               	ldr	x21, [x23]
               	add	x22, x21, #0x1
               	str	x22, [x23]
               	str	x21, [x26]
               	b	0x405290 <.text+0x4e30>
               	mov	x21, #0x1e              // =30
               	stur	x21, [x29, #-0x58]
               	b	0x4052d8 <.text+0x4e78>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x26
               	b.gt	0x405338 <.text+0x4ed8>
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x21, x19
               	ldr	x25, [x21]
               	add	x26, x25, #0x18
               	mov	x25, #0x82              // =130
               	str	x25, [x26]
               	ldr	x22, [x21]
               	add	x25, x22, #0x20
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	ldr	x26, [x21]
               	add	x21, x26, #0x28
               	sub	x26, x29, #0x58
               	ldr	x22, [x26]
               	add	x25, x22, #0x1
               	str	x25, [x26]
               	str	x22, [x21]
               	b	0x4052d8 <.text+0x4e78>
               	bl	0x4005b0 <.text+0x150>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x27, [x23]
               	mov	x21, #0x86              // =134
               	str	x21, [x27]
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	ldr	x22, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x190
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x23, x19
               	mov	x0, x24
               	bl	0x4070c4 <malloc>
               	mov	x27, x0
               	str	x27, [x23]
               	str	x27, [x25]
               	cmp	x27, #0x0
               	b.ne	0x405400 <.text+0x4fa0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x655
               	mov	x21, x19
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x27, [x21]
               	sub	x26, x24, #0x1
               	mov	x0, x20
               	mov	x2, x26
               	mov	x1, x27
               	bl	0x4070dc <read>
               	sxtw	x0, w0
               	mov	x25, x0
               	stur	x25, [x29, #-0x58]
               	cmp	x25, #0x0
               	b.gt	0x4054a4 <.text+0x5044>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x677
               	mov	x21, x19
               	ldur	x25, [x29, #-0x58]
               	mov	x0, x21
               	mov	x1, x25
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x27, x0
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
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
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x27, [x25]
               	ldur	x25, [x29, #-0x58]
               	add	x21, x27, x25
               	mov	x25, #0x0               // =0
               	strb	w25, [x21]
               	mov	x0, x20
               	bl	0x4070e8 <close>
               	sxtw	x0, w0
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x27, x19
               	mov	x20, #0x1               // =1
               	str	x20, [x27]
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	b	0x4054f4 <.text+0x5094>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x25, [x20]
               	cbz	x25, 0x40552c <.text+0x50cc>
               	mov	x20, #0x1               // =1
               	stur	x20, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x20, [x25]
               	cmp	x20, #0x8a
               	b.ne	0x405554 <.text+0x50f4>
               	b	0x405544 <.text+0x50e4>
               	add	x21, x22, #0x28
               	ldr	x22, [x21]
               	stur	x22, [x29, #-0x30]
               	cmp	x22, #0x0
               	b.ne	0x4062e0 <.text+0x5e80>
               	b	0x40627c <.text+0x5e1c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x20, x0
               	b	0x405550 <.text+0x50f0>
               	b	0x40581c <.text+0x53bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x20, [x26]
               	cmp	x20, #0x86
               	b.ne	0x405584 <.text+0x5124>
               	bl	0x4005b0 <.text+0x150>
               	mov	x20, x0
               	mov	x20, #0x0               // =0
               	stur	x20, [x29, #-0x10]
               	b	0x405580 <.text+0x5120>
               	b	0x405550 <.text+0x50f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x25, [x20]
               	cmp	x25, #0x88
               	b.ne	0x4055c0 <.text+0x5160>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x26, [x25]
               	cmp	x26, #0x7b
               	b.eq	0x4055d0 <.text+0x5170>
               	b	0x4055c4 <.text+0x5164>
               	b	0x405580 <.text+0x5120>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	b	0x4055d0 <.text+0x5170>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x26, [x20]
               	cmp	x26, #0x7b
               	b.ne	0x4055fc <.text+0x519c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	mov	x26, #0x0               // =0
               	stur	x26, [x29, #-0x58]
               	b	0x405600 <.text+0x51a0>
               	b	0x4055c0 <.text+0x5160>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x25, [x26]
               	cmp	x25, #0x7d
               	b.eq	0x405634 <.text+0x51d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x26, [x25]
               	cmp	x26, #0x85
               	b.eq	0x4056cc <.text+0x526c>
               	b	0x405640 <.text+0x51e0>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	b	0x4055fc <.text+0x519c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x68b
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x26, [x25]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x27, [x25]
               	mov	x0, x20
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
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
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	bl	0x4005b0 <.text+0x150>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x21, [x27]
               	cmp	x21, #0x8e
               	b.ne	0x405710 <.text+0x52b0>
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x25, [x21]
               	cmp	x25, #0x80
               	b.eq	0x4057ec <.text+0x538c>
               	b	0x405774 <.text+0x5314>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x21, x19
               	ldr	x25, [x21]
               	add	x27, x25, #0x18
               	mov	x25, #0x80              // =128
               	str	x25, [x27]
               	ldr	x20, [x21]
               	add	x25, x20, #0x20
               	mov	x20, #0x1               // =1
               	str	x20, [x25]
               	ldr	x27, [x21]
               	add	x21, x27, #0x28
               	sub	x27, x29, #0x58
               	ldr	x20, [x27]
               	add	x25, x20, #0x1
               	str	x25, [x27]
               	str	x20, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x20, [x23]
               	cmp	x20, #0x2c
               	b.ne	0x405818 <.text+0x53b8>
               	b	0x40580c <.text+0x53ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6a7
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x25, [x21]
               	mov	x0, x27
               	mov	x1, x25
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
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
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c8
               	mov	x25, x19
               	ldr	x21, [x25]
               	stur	x21, [x29, #-0x58]
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	b	0x405710 <.text+0x52b0>
               	bl	0x4005b0 <.text+0x150>
               	mov	x23, x0
               	b	0x405818 <.text+0x53b8>
               	b	0x405600 <.text+0x51a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	cmp	x26, #0x3b
               	cset	x23, ne
               	stur	x23, [x29, #-0xb8]
               	cbz	x23, 0x405878 <.text+0x5418>
               	b	0x405858 <.text+0x53f8>
               	ldur	x23, [x29, #-0x10]
               	stur	x23, [x29, #-0x18]
               	b	0x405884 <.text+0x5424>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	b	0x4054f4 <.text+0x5094>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x23, [x26]
               	cmp	x23, #0x7d
               	cset	x26, ne
               	stur	x26, [x29, #-0xb8]
               	b	0x405878 <.text+0x5418>
               	ldur	x26, [x29, #-0xb8]
               	cbz	x26, 0x40584c <.text+0x53ec>
               	b	0x405840 <.text+0x53e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x26, [x23]
               	cmp	x26, #0x9f
               	b.ne	0x4058b4 <.text+0x5454>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	ldur	x26, [x29, #-0x18]
               	add	x20, x26, #0x2
               	stur	x20, [x29, #-0x18]
               	b	0x405884 <.text+0x5424>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x26, [x20]
               	cmp	x26, #0x85
               	b.eq	0x405944 <.text+0x54e4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6c1
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x26, [x20]
               	mov	x0, x23
               	mov	x1, x26
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x20, [x26]
               	add	x26, x20, #0x18
               	ldr	x20, [x26]
               	cbz	x20, 0x4059d8 <.text+0x5578>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6dd
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x26, [x20]
               	mov	x0, x21
               	mov	x1, x26
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
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
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x23, [x26]
               	add	x26, x23, #0x20
               	ldur	x23, [x29, #-0x18]
               	str	x23, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x28
               	b.ne	0x405a80 <.text+0x5620>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x26, x21, #0x18
               	mov	x21, #0x81              // =129
               	str	x21, [x26]
               	ldr	x25, [x23]
               	add	x23, x25, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x21, [x25]
               	add	x25, x21, #0x8
               	str	x25, [x23]
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	mov	x21, #0x0               // =0
               	stur	x21, [x29, #-0x58]
               	b	0x405ac8 <.text+0x5668>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x26, [x21]
               	cmp	x26, #0x2c
               	b.ne	0x406278 <.text+0x5e18>
               	b	0x40626c <.text+0x5e0c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x27, x19
               	ldr	x21, [x27]
               	add	x26, x21, #0x18
               	mov	x21, #0x83              // =131
               	str	x21, [x26]
               	ldr	x20, [x27]
               	add	x27, x20, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x20, x19
               	ldr	x21, [x20]
               	str	x21, [x27]
               	ldr	x26, [x20]
               	add	x21, x26, #0x8
               	str	x21, [x20]
               	b	0x405a64 <.text+0x5604>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x25, [x21]
               	cmp	x25, #0x29
               	b.eq	0x405b04 <.text+0x56a4>
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0x18]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x25, [x21]
               	cmp	x25, #0x8a
               	b.ne	0x405b38 <.text+0x56d8>
               	b	0x405b28 <.text+0x56c8>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x27, [x25]
               	cmp	x27, #0x7b
               	b.eq	0x405df8 <.text+0x5998>
               	b	0x405d80 <.text+0x5920>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	b	0x405b34 <.text+0x56d4>
               	b	0x405b68 <.text+0x5708>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x25, [x20]
               	cmp	x25, #0x86
               	b.ne	0x405b64 <.text+0x5704>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	mov	x25, #0x0               // =0
               	stur	x25, [x29, #-0x18]
               	b	0x405b64 <.text+0x5704>
               	b	0x405b34 <.text+0x56d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x21, [x25]
               	cmp	x21, #0x9f
               	b.ne	0x405b98 <.text+0x5738>
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	ldur	x21, [x29, #-0x18]
               	add	x20, x21, #0x2
               	stur	x20, [x29, #-0x18]
               	b	0x405b68 <.text+0x5708>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x21, [x20]
               	cmp	x21, #0x85
               	b.eq	0x405c28 <.text+0x57c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6fe
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x21, [x20]
               	mov	x0, x25
               	mov	x1, x21
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x21, x19
               	ldr	x20, [x21]
               	add	x21, x20, #0x18
               	ldr	x20, [x21]
               	cmp	x20, #0x84
               	b.ne	0x405cc0 <.text+0x5860>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x71d
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x20, [x21]
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
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
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x21, [x20]
               	add	x23, x21, #0x30
               	ldr	x21, [x20]
               	add	x26, x21, #0x18
               	ldr	x21, [x26]
               	str	x21, [x23]
               	ldr	x26, [x20]
               	add	x21, x26, #0x18
               	mov	x26, #0x84              // =132
               	str	x26, [x21]
               	ldr	x23, [x20]
               	add	x26, x23, #0x38
               	ldr	x23, [x20]
               	add	x21, x23, #0x20
               	ldr	x23, [x21]
               	str	x23, [x26]
               	ldr	x21, [x20]
               	add	x23, x21, #0x20
               	ldur	x21, [x29, #-0x18]
               	str	x21, [x23]
               	ldr	x26, [x20]
               	add	x21, x26, #0x40
               	ldr	x26, [x20]
               	add	x23, x26, #0x28
               	ldr	x26, [x23]
               	str	x26, [x21]
               	ldr	x23, [x20]
               	add	x20, x23, #0x28
               	sub	x23, x29, #0x58
               	ldr	x26, [x23]
               	add	x21, x26, #0x1
               	str	x21, [x23]
               	str	x26, [x20]
               	bl	0x4005b0 <.text+0x150>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x26, [x27]
               	cmp	x26, #0x2c
               	b.ne	0x405d7c <.text+0x591c>
               	bl	0x4005b0 <.text+0x150>
               	mov	x27, x0
               	b	0x405d7c <.text+0x591c>
               	b	0x405ac8 <.text+0x5668>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x741
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x27, [x25]
               	mov	x0, x26
               	mov	x1, x27
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x27, x19
               	sub	x25, x29, #0x58
               	ldr	x26, [x25]
               	add	x21, x26, #0x1
               	str	x21, [x25]
               	str	x21, [x27]
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	b	0x405e24 <.text+0x59c4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x26, [x21]
               	cmp	x26, #0x8a
               	cset	x21, eq
               	stur	x21, [x29, #-0xc0]
               	cbnz	x21, 0x405ed0 <.text+0x5a70>
               	b	0x405eb0 <.text+0x5a50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x26, [x21]
               	cmp	x26, #0x8a
               	b.ne	0x405ee8 <.text+0x5a88>
               	b	0x405edc <.text+0x5a7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x21, [x25]
               	add	x20, x21, #0x8
               	str	x20, [x25]
               	mov	x21, #0x6               // =6
               	str	x21, [x20]
               	ldr	x27, [x25]
               	add	x21, x27, #0x8
               	str	x21, [x25]
               	ldur	x27, [x29, #-0x58]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d8
               	mov	x25, x19
               	ldr	x20, [x25]
               	sub	x25, x27, x20
               	str	x25, [x21]
               	b	0x406150 <.text+0x5cf0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x86
               	cset	x26, eq
               	stur	x26, [x29, #-0xc0]
               	b	0x405ed0 <.text+0x5a70>
               	ldur	x26, [x29, #-0xc0]
               	cbz	x26, 0x405e64 <.text+0x5a04>
               	b	0x405e48 <.text+0x59e8>
               	mov	x26, #0x1               // =1
               	stur	x26, [x29, #-0xc8]
               	b	0x405ef4 <.text+0x5a94>
               	mov	x26, #0x0               // =0
               	stur	x26, [x29, #-0xc8]
               	b	0x405ef4 <.text+0x5a94>
               	ldur	x26, [x29, #-0xc8]
               	stur	x26, [x29, #-0x10]
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	b	0x405f08 <.text+0x5aa8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x21, [x26]
               	cmp	x21, #0x3b
               	b.eq	0x405f2c <.text+0x5acc>
               	ldur	x21, [x29, #-0x10]
               	stur	x21, [x29, #-0x18]
               	b	0x405f38 <.text+0x5ad8>
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	b	0x405e24 <.text+0x59c4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x26, [x21]
               	cmp	x26, #0x9f
               	b.ne	0x405f68 <.text+0x5b08>
               	bl	0x4005b0 <.text+0x150>
               	mov	x26, x0
               	ldur	x26, [x29, #-0x18]
               	add	x20, x26, #0x2
               	stur	x20, [x29, #-0x18]
               	b	0x405f38 <.text+0x5ad8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x26, [x20]
               	cmp	x26, #0x85
               	b.eq	0x405ff8 <.text+0x5b98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x75e
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x26, [x20]
               	mov	x0, x21
               	mov	x1, x26
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x20, [x26]
               	add	x26, x20, #0x18
               	ldr	x20, [x26]
               	cmp	x20, #0x84
               	b.ne	0x406090 <.text+0x5c30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x779
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e0
               	mov	x26, x19
               	ldr	x20, [x26]
               	mov	x0, x27
               	mov	x1, x20
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x26, [x20]
               	add	x27, x26, #0x30
               	ldr	x26, [x20]
               	add	x25, x26, #0x18
               	ldr	x26, [x25]
               	str	x26, [x27]
               	ldr	x25, [x20]
               	add	x26, x25, #0x18
               	mov	x25, #0x84              // =132
               	str	x25, [x26]
               	ldr	x27, [x20]
               	add	x25, x27, #0x38
               	ldr	x27, [x20]
               	add	x26, x27, #0x20
               	ldr	x27, [x26]
               	str	x27, [x25]
               	ldr	x26, [x20]
               	add	x27, x26, #0x20
               	ldur	x26, [x29, #-0x18]
               	str	x26, [x27]
               	ldr	x25, [x20]
               	add	x26, x25, #0x40
               	ldr	x25, [x20]
               	add	x27, x25, #0x28
               	ldr	x25, [x27]
               	str	x25, [x26]
               	ldr	x27, [x20]
               	add	x20, x27, #0x28
               	sub	x27, x29, #0x58
               	ldr	x25, [x27]
               	add	x26, x25, #0x1
               	str	x26, [x27]
               	str	x26, [x20]
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x26, [x25]
               	cmp	x26, #0x2c
               	b.ne	0x40614c <.text+0x5cec>
               	bl	0x4005b0 <.text+0x150>
               	mov	x25, x0
               	b	0x40614c <.text+0x5cec>
               	b	0x405f08 <.text+0x5aa8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x20, [x25]
               	cmp	x20, #0x7d
               	b.eq	0x406174 <.text+0x5d14>
               	bl	0x404690 <.text+0x4230>
               	mov	x20, x0
               	b	0x406150 <.text+0x5cf0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x20, [x26]
               	add	x21, x20, #0x8
               	str	x21, [x26]
               	mov	x20, #0x8               // =8
               	str	x20, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x20, x19
               	ldr	x21, [x20]
               	str	x21, [x26]
               	b	0x4061b8 <.text+0x5d58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x21, x19
               	ldr	x20, [x21]
               	ldr	x21, [x20]
               	cbz	x21, 0x4061f4 <.text+0x5d94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x21, [x20]
               	add	x20, x21, #0x18
               	ldr	x21, [x20]
               	cmp	x21, #0x84
               	b.ne	0x406250 <.text+0x5df0>
               	b	0x4061f8 <.text+0x5d98>
               	b	0x405a64 <.text+0x5604>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x21, x19
               	ldr	x20, [x21]
               	add	x26, x20, #0x18
               	ldr	x20, [x21]
               	add	x27, x20, #0x30
               	ldr	x20, [x27]
               	str	x20, [x26]
               	ldr	x27, [x21]
               	add	x20, x27, #0x20
               	ldr	x27, [x21]
               	add	x26, x27, #0x38
               	ldr	x27, [x26]
               	str	x27, [x20]
               	ldr	x26, [x21]
               	add	x27, x26, #0x28
               	ldr	x26, [x21]
               	add	x21, x26, #0x40
               	ldr	x26, [x21]
               	str	x26, [x27]
               	b	0x406250 <.text+0x5df0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x21, [x26]
               	add	x27, x21, #0x48
               	str	x27, [x26]
               	b	0x4061b8 <.text+0x5d58>
               	bl	0x4005b0 <.text+0x150>
               	mov	x21, x0
               	b	0x406278 <.text+0x5e18>
               	b	0x40581c <.text+0x53bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x799
               	mov	x26, x19
               	mov	x0, x26
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
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
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e8
               	mov	x26, x19
               	ldr	x21, [x26]
               	cbz	x21, 0x406330 <.text+0x5ed0>
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
               	ldur	x21, [x29, #-0x38]
               	add	x26, x21, x24
               	stur	x26, [x29, #-0x38]
               	stur	x26, [x29, #-0x40]
               	sub	x21, x29, #0x38
               	ldr	x26, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x26, x17
               	str	x24, [x21]
               	mov	x26, #0x26              // =38
               	str	x26, [x24]
               	sub	x21, x29, #0x38
               	ldr	x26, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x26, x17
               	str	x24, [x21]
               	mov	x26, #0xd               // =13
               	str	x26, [x24]
               	ldur	x21, [x29, #-0x38]
               	stur	x21, [x29, #-0x60]
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x21, x17
               	str	x24, [x26]
               	ldur	x21, [x29, #0x10]
               	str	x21, [x24]
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x21, x17
               	str	x24, [x26]
               	ldur	x21, [x29, #0x20]
               	str	x21, [x24]
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x21, x17
               	str	x24, [x26]
               	ldur	x21, [x29, #-0x60]
               	str	x21, [x24]
               	mov	x26, #0x0               // =0
               	stur	x26, [x29, #-0x50]
               	b	0x40641c <.text+0x5fbc>
               	mov	x26, #0x1               // =1
               	cbz	x26, 0x406464 <.text+0x6004>
               	sub	x21, x29, #0x30
               	ldr	x26, [x21]
               	add	x24, x26, #0x8
               	str	x24, [x21]
               	ldr	x25, [x26]
               	stur	x25, [x29, #-0x58]
               	sub	x26, x29, #0x50
               	ldr	x25, [x26]
               	add	x24, x25, #0x1
               	str	x24, [x26]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cbz	x24, 0x4064f4 <.text+0x6094>
               	b	0x4064a0 <.text+0x6040>
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
               	mov	x22, x19
               	ldur	x25, [x29, #-0x50]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x7b6
               	mov	x26, x19
               	ldur	x21, [x29, #-0x58]
               	mov	x17, #0x5               // =5
               	mul	x20, x21, x17
               	add	x24, x26, x20
               	mov	x0, x22
               	mov	x2, x24
               	mov	x1, x25
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x7
               	b.gt	0x406534 <.text+0x60d4>
               	b	0x406504 <.text+0x60a4>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x0
               	b.ne	0x406580 <.text+0x6120>
               	b	0x406554 <.text+0x60f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x87a
               	mov	x21, x19
               	ldur	x24, [x29, #-0x30]
               	ldr	x20, [x24]
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x406530 <.text+0x60d0>
               	b	0x4064f4 <.text+0x6094>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x87f
               	mov	x25, x19
               	mov	x0, x25
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x406530 <.text+0x60d0>
               	ldur	x25, [x29, #-0x40]
               	sub	x24, x29, #0x30
               	ldr	x21, [x24]
               	add	x22, x21, #0x8
               	str	x22, [x24]
               	ldr	x26, [x21]
               	lsl	x21, x26, #3
               	add	x26, x25, x21
               	stur	x26, [x29, #-0x48]
               	b	0x40657c <.text+0x611c>
               	b	0x40641c <.text+0x5fbc>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x1
               	b.ne	0x4065ac <.text+0x614c>
               	sub	x26, x29, #0x30
               	ldr	x21, [x26]
               	add	x25, x21, #0x8
               	str	x25, [x26]
               	ldr	x22, [x21]
               	stur	x22, [x29, #-0x48]
               	b	0x4065a8 <.text+0x6148>
               	b	0x40657c <.text+0x611c>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x2
               	b.ne	0x4065cc <.text+0x616c>
               	ldur	x22, [x29, #-0x30]
               	ldr	x21, [x22]
               	stur	x21, [x29, #-0x30]
               	b	0x4065c8 <.text+0x6168>
               	b	0x4065a8 <.text+0x6148>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x3
               	b.ne	0x406618 <.text+0x61b8>
               	sub	x21, x29, #0x38
               	ldr	x22, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x25, x22, x17
               	str	x25, [x21]
               	ldur	x22, [x29, #-0x30]
               	add	x21, x22, #0x8
               	str	x21, [x25]
               	ldur	x22, [x29, #-0x30]
               	ldr	x21, [x22]
               	stur	x21, [x29, #-0x30]
               	b	0x406614 <.text+0x61b4>
               	b	0x4065c8 <.text+0x6168>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x4
               	b.ne	0x406634 <.text+0x61d4>
               	ldur	x21, [x29, #-0x48]
               	cbz	x21, 0x406654 <.text+0x61f4>
               	b	0x406644 <.text+0x61e4>
               	b	0x406614 <.text+0x61b4>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x5
               	b.ne	0x406680 <.text+0x6220>
               	b	0x406670 <.text+0x6210>
               	ldur	x22, [x29, #-0x30]
               	add	x21, x22, #0x8
               	stur	x21, [x29, #-0xd0]
               	b	0x406664 <.text+0x6204>
               	ldur	x21, [x29, #-0x30]
               	ldr	x22, [x21]
               	stur	x22, [x29, #-0xd0]
               	b	0x406664 <.text+0x6204>
               	ldur	x22, [x29, #-0xd0]
               	stur	x22, [x29, #-0x30]
               	b	0x406630 <.text+0x61d0>
               	ldur	x22, [x29, #-0x48]
               	cbz	x22, 0x4066a0 <.text+0x6240>
               	b	0x406690 <.text+0x6230>
               	b	0x406630 <.text+0x61d0>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x6
               	b.ne	0x406714 <.text+0x62b4>
               	b	0x4066bc <.text+0x625c>
               	ldur	x21, [x29, #-0x30]
               	ldr	x22, [x21]
               	stur	x22, [x29, #-0xd8]
               	b	0x4066b0 <.text+0x6250>
               	ldur	x22, [x29, #-0x30]
               	add	x21, x22, #0x8
               	stur	x21, [x29, #-0xd8]
               	b	0x4066b0 <.text+0x6250>
               	ldur	x21, [x29, #-0xd8]
               	stur	x21, [x29, #-0x30]
               	b	0x40667c <.text+0x621c>
               	sub	x21, x29, #0x38
               	ldr	x22, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x25, x22, x17
               	str	x25, [x21]
               	ldur	x22, [x29, #-0x40]
               	str	x22, [x25]
               	ldur	x21, [x29, #-0x38]
               	stur	x21, [x29, #-0x40]
               	sub	x22, x29, #0x30
               	ldr	x25, [x22]
               	add	x26, x25, #0x8
               	str	x26, [x22]
               	ldr	x24, [x25]
               	lsl	x25, x24, #3
               	sub	x24, x21, x25
               	stur	x24, [x29, #-0x38]
               	b	0x406710 <.text+0x62b0>
               	b	0x40667c <.text+0x621c>
               	ldur	x24, [x29, #-0x58]
               	cmp	x24, #0x7
               	b.ne	0x40674c <.text+0x62ec>
               	ldur	x24, [x29, #-0x38]
               	sub	x25, x29, #0x30
               	ldr	x21, [x25]
               	add	x26, x21, #0x8
               	str	x26, [x25]
               	ldr	x22, [x21]
               	lsl	x21, x22, #3
               	add	x22, x24, x21
               	stur	x22, [x29, #-0x38]
               	b	0x406748 <.text+0x62e8>
               	b	0x406710 <.text+0x62b0>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x8
               	b.ne	0x406798 <.text+0x6338>
               	ldur	x22, [x29, #-0x40]
               	stur	x22, [x29, #-0x38]
               	sub	x21, x29, #0x38
               	ldr	x22, [x21]
               	add	x24, x22, #0x8
               	str	x24, [x21]
               	ldr	x26, [x22]
               	stur	x26, [x29, #-0x40]
               	sub	x22, x29, #0x38
               	ldr	x26, [x22]
               	add	x24, x26, #0x8
               	str	x24, [x22]
               	ldr	x21, [x26]
               	stur	x21, [x29, #-0x30]
               	b	0x406794 <.text+0x6334>
               	b	0x406748 <.text+0x62e8>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x9
               	b.ne	0x4067b8 <.text+0x6358>
               	ldur	x21, [x29, #-0x48]
               	ldr	x26, [x21]
               	stur	x26, [x29, #-0x48]
               	b	0x4067b4 <.text+0x6354>
               	b	0x406794 <.text+0x6334>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0xa
               	b.ne	0x4067d8 <.text+0x6378>
               	ldur	x26, [x29, #-0x48]
               	ldrb	w21, [x26]
               	stur	x21, [x29, #-0x48]
               	b	0x4067d4 <.text+0x6374>
               	b	0x4067b4 <.text+0x6354>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xb
               	b.ne	0x406808 <.text+0x63a8>
               	sub	x21, x29, #0x38
               	ldr	x26, [x21]
               	add	x24, x26, #0x8
               	str	x24, [x21]
               	ldr	x22, [x26]
               	ldur	x26, [x29, #-0x48]
               	str	x26, [x22]
               	b	0x406804 <.text+0x63a4>
               	b	0x4067d4 <.text+0x6374>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0xc
               	b.ne	0x40683c <.text+0x63dc>
               	sub	x26, x29, #0x38
               	ldr	x24, [x26]
               	add	x22, x24, #0x8
               	str	x22, [x26]
               	ldr	x21, [x24]
               	ldur	x24, [x29, #-0x48]
               	strb	w24, [x21]
               	stur	x24, [x29, #-0x48]
               	b	0x406838 <.text+0x63d8>
               	b	0x406804 <.text+0x63a4>
               	ldur	x24, [x29, #-0x58]
               	cmp	x24, #0xd
               	b.ne	0x406878 <.text+0x6418>
               	sub	x24, x29, #0x38
               	ldr	x22, [x24]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x22, x17
               	str	x21, [x24]
               	ldur	x22, [x29, #-0x48]
               	str	x22, [x21]
               	b	0x406874 <.text+0x6414>
               	b	0x406838 <.text+0x63d8>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0xe
               	b.ne	0x4068ac <.text+0x644c>
               	sub	x22, x29, #0x38
               	ldr	x24, [x22]
               	add	x21, x24, #0x8
               	str	x21, [x22]
               	ldr	x26, [x24]
               	ldur	x24, [x29, #-0x48]
               	orr	x21, x26, x24
               	stur	x21, [x29, #-0x48]
               	b	0x4068a8 <.text+0x6448>
               	b	0x406874 <.text+0x6414>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xf
               	b.ne	0x4068e0 <.text+0x6480>
               	sub	x21, x29, #0x38
               	ldr	x24, [x21]
               	add	x26, x24, #0x8
               	str	x26, [x21]
               	ldr	x22, [x24]
               	ldur	x24, [x29, #-0x48]
               	eor	x26, x22, x24
               	stur	x26, [x29, #-0x48]
               	b	0x4068dc <.text+0x647c>
               	b	0x4068a8 <.text+0x6448>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x10
               	b.ne	0x406914 <.text+0x64b4>
               	sub	x26, x29, #0x38
               	ldr	x24, [x26]
               	add	x22, x24, #0x8
               	str	x22, [x26]
               	ldr	x21, [x24]
               	ldur	x24, [x29, #-0x48]
               	and	x22, x21, x24
               	stur	x22, [x29, #-0x48]
               	b	0x406910 <.text+0x64b0>
               	b	0x4068dc <.text+0x647c>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x11
               	b.ne	0x40694c <.text+0x64ec>
               	sub	x22, x29, #0x38
               	ldr	x24, [x22]
               	add	x21, x24, #0x8
               	str	x21, [x22]
               	ldr	x26, [x24]
               	ldur	x24, [x29, #-0x48]
               	cmp	x26, x24
               	cset	x21, eq
               	stur	x21, [x29, #-0x48]
               	b	0x406948 <.text+0x64e8>
               	b	0x406910 <.text+0x64b0>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x12
               	b.ne	0x406984 <.text+0x6524>
               	sub	x21, x29, #0x38
               	ldr	x24, [x21]
               	add	x26, x24, #0x8
               	str	x26, [x21]
               	ldr	x22, [x24]
               	ldur	x24, [x29, #-0x48]
               	cmp	x22, x24
               	cset	x26, ne
               	stur	x26, [x29, #-0x48]
               	b	0x406980 <.text+0x6520>
               	b	0x406948 <.text+0x64e8>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x13
               	b.ne	0x4069bc <.text+0x655c>
               	sub	x26, x29, #0x38
               	ldr	x24, [x26]
               	add	x22, x24, #0x8
               	str	x22, [x26]
               	ldr	x21, [x24]
               	ldur	x24, [x29, #-0x48]
               	cmp	x21, x24
               	cset	x22, lt
               	stur	x22, [x29, #-0x48]
               	b	0x4069b8 <.text+0x6558>
               	b	0x406980 <.text+0x6520>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x14
               	b.ne	0x4069f4 <.text+0x6594>
               	sub	x22, x29, #0x38
               	ldr	x24, [x22]
               	add	x21, x24, #0x8
               	str	x21, [x22]
               	ldr	x26, [x24]
               	ldur	x24, [x29, #-0x48]
               	cmp	x26, x24
               	cset	x21, gt
               	stur	x21, [x29, #-0x48]
               	b	0x4069f0 <.text+0x6590>
               	b	0x4069b8 <.text+0x6558>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x15
               	b.ne	0x406a2c <.text+0x65cc>
               	sub	x21, x29, #0x38
               	ldr	x24, [x21]
               	add	x26, x24, #0x8
               	str	x26, [x21]
               	ldr	x22, [x24]
               	ldur	x24, [x29, #-0x48]
               	cmp	x22, x24
               	cset	x26, le
               	stur	x26, [x29, #-0x48]
               	b	0x406a28 <.text+0x65c8>
               	b	0x4069f0 <.text+0x6590>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x16
               	b.ne	0x406a64 <.text+0x6604>
               	sub	x26, x29, #0x38
               	ldr	x24, [x26]
               	add	x22, x24, #0x8
               	str	x22, [x26]
               	ldr	x21, [x24]
               	ldur	x24, [x29, #-0x48]
               	cmp	x21, x24
               	cset	x22, ge
               	stur	x22, [x29, #-0x48]
               	b	0x406a60 <.text+0x6600>
               	b	0x406a28 <.text+0x65c8>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x17
               	b.ne	0x406a98 <.text+0x6638>
               	sub	x22, x29, #0x38
               	ldr	x24, [x22]
               	add	x21, x24, #0x8
               	str	x21, [x22]
               	ldr	x26, [x24]
               	ldur	x24, [x29, #-0x48]
               	lsl	x21, x26, x24
               	stur	x21, [x29, #-0x48]
               	b	0x406a94 <.text+0x6634>
               	b	0x406a60 <.text+0x6600>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x18
               	b.ne	0x406acc <.text+0x666c>
               	sub	x21, x29, #0x38
               	ldr	x24, [x21]
               	add	x26, x24, #0x8
               	str	x26, [x21]
               	ldr	x22, [x24]
               	ldur	x24, [x29, #-0x48]
               	asr	x26, x22, x24
               	stur	x26, [x29, #-0x48]
               	b	0x406ac8 <.text+0x6668>
               	b	0x406a94 <.text+0x6634>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x19
               	b.ne	0x406b00 <.text+0x66a0>
               	sub	x26, x29, #0x38
               	ldr	x24, [x26]
               	add	x22, x24, #0x8
               	str	x22, [x26]
               	ldr	x21, [x24]
               	ldur	x24, [x29, #-0x48]
               	add	x22, x21, x24
               	stur	x22, [x29, #-0x48]
               	b	0x406afc <.text+0x669c>
               	b	0x406ac8 <.text+0x6668>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x1a
               	b.ne	0x406b34 <.text+0x66d4>
               	sub	x22, x29, #0x38
               	ldr	x24, [x22]
               	add	x21, x24, #0x8
               	str	x21, [x22]
               	ldr	x26, [x24]
               	ldur	x24, [x29, #-0x48]
               	sub	x21, x26, x24
               	stur	x21, [x29, #-0x48]
               	b	0x406b30 <.text+0x66d0>
               	b	0x406afc <.text+0x669c>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1b
               	b.ne	0x406b68 <.text+0x6708>
               	sub	x21, x29, #0x38
               	ldr	x24, [x21]
               	add	x26, x24, #0x8
               	str	x26, [x21]
               	ldr	x22, [x24]
               	ldur	x24, [x29, #-0x48]
               	mul	x26, x22, x24
               	stur	x26, [x29, #-0x48]
               	b	0x406b64 <.text+0x6704>
               	b	0x406b30 <.text+0x66d0>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x1c
               	b.ne	0x406b9c <.text+0x673c>
               	sub	x26, x29, #0x38
               	ldr	x24, [x26]
               	add	x22, x24, #0x8
               	str	x22, [x26]
               	ldr	x21, [x24]
               	ldur	x24, [x29, #-0x48]
               	sdiv	x22, x21, x24
               	stur	x22, [x29, #-0x48]
               	b	0x406b98 <.text+0x6738>
               	b	0x406b64 <.text+0x6704>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x1d
               	b.ne	0x406bd4 <.text+0x6774>
               	sub	x22, x29, #0x38
               	ldr	x24, [x22]
               	add	x21, x24, #0x8
               	str	x21, [x22]
               	ldr	x26, [x24]
               	ldur	x24, [x29, #-0x48]
               	sdiv	x17, x26, x24
               	msub	x21, x17, x24, x26
               	stur	x21, [x29, #-0x48]
               	b	0x406bd0 <.text+0x6770>
               	b	0x406b98 <.text+0x6738>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1e
               	b.ne	0x406c10 <.text+0x67b0>
               	ldur	x21, [x29, #-0x38]
               	add	x24, x21, #0x8
               	ldr	x20, [x24]
               	ldr	x26, [x21]
               	mov	x0, x20
               	mov	x1, x26
               	bl	0x4070b8 <open>
               	sxtw	x0, w0
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	0x406c0c <.text+0x67ac>
               	b	0x406bd0 <.text+0x6770>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1f
               	b.ne	0x406c58 <.text+0x67f8>
               	ldur	x21, [x29, #-0x38]
               	add	x26, x21, #0x10
               	ldr	x24, [x26]
               	add	x26, x21, #0x8
               	ldr	x20, [x26]
               	ldr	x22, [x21]
               	mov	x0, x24
               	mov	x2, x22
               	mov	x1, x20
               	bl	0x4070dc <read>
               	sxtw	x0, w0
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	0x406c54 <.text+0x67f4>
               	b	0x406c0c <.text+0x67ac>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x20
               	b.ne	0x406c88 <.text+0x6828>
               	ldur	x21, [x29, #-0x38]
               	ldr	x26, [x21]
               	mov	x0, x26
               	bl	0x4070e8 <close>
               	sxtw	x0, w0
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	0x406c84 <.text+0x6824>
               	b	0x406c54 <.text+0x67f4>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x21
               	b.ne	0x406d74 <.text+0x6914>
               	ldur	x21, [x29, #-0x38]
               	ldur	x26, [x29, #-0x30]
               	add	x20, x26, #0x8
               	ldr	x26, [x20]
               	lsl	x20, x26, #3
               	add	x26, x21, x20
               	stur	x26, [x29, #-0x60]
               	ldur	x20, [x29, #-0x60]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x20, x17
               	ldr	x22, [x26]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x20, x17
               	ldr	x21, [x26]
               	mov	x17, #0xffe8            // =65512
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x20, x17
               	ldr	x24, [x26]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x20, x17
               	ldr	x25, [x26]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x20, x17
               	ldr	x27, [x26]
               	mov	x17, #0xffd0            // =65488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x20, x17
               	ldr	x23, [x26]
               	mov	x0, x22
               	mov	x5, x23
               	mov	x4, x27
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	stur	x26, [x29, #-0x48]
               	b	0x406d70 <.text+0x6910>
               	b	0x406c84 <.text+0x6824>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x22
               	b.ne	0x406da0 <.text+0x6940>
               	ldur	x26, [x29, #-0x38]
               	ldr	x20, [x26]
               	mov	x0, x20
               	bl	0x4070c4 <malloc>
               	mov	x26, x0
               	stur	x26, [x29, #-0x48]
               	b	0x406d9c <.text+0x693c>
               	b	0x406d70 <.text+0x6910>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x23
               	b.ne	0x406dcc <.text+0x696c>
               	ldur	x26, [x29, #-0x38]
               	ldr	x23, [x26]
               	mov	x0, x23
               	bl	0x4070f4 <free>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x406dc8 <.text+0x6968>
               	b	0x406d9c <.text+0x693c>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x24
               	b.ne	0x406e10 <.text+0x69b0>
               	ldur	x23, [x29, #-0x38]
               	add	x26, x23, #0x10
               	ldr	x20, [x26]
               	add	x26, x23, #0x8
               	ldr	x27, [x26]
               	ldr	x25, [x23]
               	mov	x0, x20
               	mov	x2, x25
               	mov	x1, x27
               	bl	0x4070d0 <memset>
               	mov	x23, x0
               	stur	x23, [x29, #-0x48]
               	b	0x406e0c <.text+0x69ac>
               	b	0x406dc8 <.text+0x6968>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x25
               	b.ne	0x406e58 <.text+0x69f8>
               	ldur	x23, [x29, #-0x38]
               	add	x25, x23, #0x10
               	ldr	x26, [x25]
               	add	x25, x23, #0x8
               	ldr	x27, [x25]
               	ldr	x20, [x23]
               	mov	x0, x26
               	mov	x2, x20
               	mov	x1, x27
               	bl	0x4070a0 <memcmp>
               	sxtw	x0, w0
               	mov	x23, x0
               	stur	x23, [x29, #-0x48]
               	b	0x406e54 <.text+0x69f4>
               	b	0x406e0c <.text+0x69ac>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x26
               	b.ne	0x406ed8 <.text+0x6a78>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x881
               	mov	x25, x19
               	ldur	x20, [x29, #-0x38]
               	ldr	x23, [x20]
               	ldur	x27, [x29, #-0x50]
               	mov	x0, x25
               	mov	x2, x27
               	mov	x1, x23
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	ldur	x26, [x29, #-0x38]
               	ldr	x27, [x26]
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
               	b	0x406e54 <.text+0x69f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x896
               	mov	x20, x19
               	ldur	x26, [x29, #-0x58]
               	ldur	x27, [x29, #-0x50]
               	mov	x0, x20
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x407094 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
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
