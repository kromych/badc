
ssa_bail_fixup_rollback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4006a0 <.text+0x480>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	add	x14, x15, #0x3
               	ldrb	w13, [x14]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	lsl	x13, x13, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	add	x14, x15, #0x2
               	ldrb	w12, [x14]
               	orr	x13, x13, x12
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	lsl	x13, x13, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	add	x12, x15, #0x1
               	ldrb	w14, [x12]
               	orr	x13, x13, x14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	lsl	x13, x13, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	ldrb	w14, [x15]
               	orr	x0, x13, x14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	mov	x20, x0
               	mov	x21, x1
               	mov	x22, x2
               	mov	x23, x3
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x48]
               	b	0x400300 <.text+0xe0>
               	ldursw	x11, [x29, #-0x48]
               	cmp	x11, #0x4
               	b.ge	0x4003f0 <.text+0x1d0>
               	b	0x400324 <.text+0x104>
               	sub	x10, x29, #0x48
               	ldrsw	x11, [x10]
               	add	x11, x11, #0x1
               	str	w11, [x10]
               	b	0x400300 <.text+0xe0>
               	sub	x11, x29, #0x40
               	ldursw	x9, [x29, #-0x48]
               	mov	x17, #0x5               // =5
               	mul	x10, x9, x17
               	sxtw	x10, w10
               	lsl	x10, x10, #2
               	add	x24, x11, x10
               	lsl	x9, x9, #2
               	sxtw	x9, w9
               	add	x25, x23, x9
               	mov	x0, x25
               	bl	0x400238 <.text+0x18>
               	str	w0, [x24]
               	sub	x25, x29, #0x40
               	ldursw	x0, [x29, #-0x48]
               	add	x24, x0, #0x1
               	sxtw	x24, w24
               	lsl	x24, x24, #2
               	add	x25, x25, x24
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x26, x22, x0
               	mov	x0, x26
               	bl	0x400238 <.text+0x18>
               	str	w0, [x25]
               	sub	x26, x29, #0x40
               	ldursw	x0, [x29, #-0x48]
               	add	x25, x0, #0x6
               	sxtw	x25, w25
               	lsl	x25, x25, #2
               	add	x26, x26, x25
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x24, x21, x0
               	mov	x0, x24
               	bl	0x400238 <.text+0x18>
               	str	w0, [x26]
               	sub	x24, x29, #0x40
               	ldursw	x0, [x29, #-0x48]
               	add	x26, x0, #0xb
               	sxtw	x26, w26
               	lsl	x26, x26, #2
               	add	x24, x24, x26
               	add	x26, x22, #0x10
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x26, x26, x0
               	mov	x0, x26
               	bl	0x400238 <.text+0x18>
               	str	w0, [x24]
               	b	0x400310 <.text+0xf0>
               	mov	x0, #0x0                // =0
               	sub	x26, x29, #0x40
               	ldr	w23, [x26]
               	sub	x26, x29, #0x40
               	add	x26, x26, #0x14
               	ldr	w22, [x26]
               	eor	x23, x23, x22
               	sub	x22, x29, #0x40
               	add	x22, x22, #0x28
               	ldr	w26, [x22]
               	eor	x23, x23, x26
               	sub	x26, x29, #0x40
               	add	x26, x26, #0x3c
               	ldr	w22, [x26]
               	eor	x23, x23, x22
               	mov	x17, #0xff              // =255
               	and	x23, x23, x17
               	strb	w23, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	sp, sp, #0x20
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	stur	x0, [x29, #0x10]
               	stur	x1, [x29, #0x20]
               	stur	x2, [x29, #0x30]
               	mov	x20, x4
               	ldur	x13, [x29, #0x30]
               	cmp	x13, #0x0
               	b.ne	0x4004d8 <.text+0x2b8>
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x58]
               	b	0x4004e4 <.text+0x2c4>
               	ldur	w13, [x29, #-0x58]
               	cmp	x13, #0x10
               	b.hs	0x400520 <.text+0x300>
               	b	0x400508 <.text+0x2e8>
               	sub	x12, x29, #0x58
               	ldr	w13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	0x4004e4 <.text+0x2c4>
               	sub	x13, x29, #0x10
               	ldur	w11, [x29, #-0x58]
               	add	x13, x13, x11
               	mov	x11, #0x0               // =0
               	strb	w11, [x13]
               	b	0x4004f4 <.text+0x2d4>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x58]
               	b	0x40052c <.text+0x30c>
               	ldur	w11, [x29, #-0x58]
               	cmp	x11, #0x8
               	b.hs	0x40056c <.text+0x34c>
               	b	0x400550 <.text+0x330>
               	sub	x12, x29, #0x58
               	ldr	w11, [x12]
               	add	x11, x11, #0x1
               	str	w11, [x12]
               	b	0x40052c <.text+0x30c>
               	sub	x11, x29, #0x10
               	ldur	w13, [x29, #-0x58]
               	add	x11, x11, x13
               	add	x12, x3, x13
               	ldrb	w13, [x12]
               	strb	w13, [x11]
               	b	0x40053c <.text+0x31c>
               	b	0x400570 <.text+0x350>
               	ldur	x13, [x29, #0x30]
               	cmp	x13, #0x40
               	b.lo	0x4005b0 <.text+0x390>
               	sub	x21, x29, #0x50
               	sub	x22, x29, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x23, x19
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x22
               	bl	0x4002bc <.text+0x9c>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x58]
               	b	0x4005dc <.text+0x3bc>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	ldur	w0, [x29, #-0x58]
               	cmp	x0, #0x40
               	b.hs	0x400618 <.text+0x3f8>
               	b	0x400600 <.text+0x3e0>
               	sub	x23, x29, #0x58
               	ldr	w0, [x23]
               	add	x0, x0, #0x1
               	str	w0, [x23]
               	b	0x4005dc <.text+0x3bc>
               	ldur	x0, [x29, #0x10]
               	ldur	w22, [x29, #-0x58]
               	add	x0, x0, x22
               	ldur	x22, [x29, #0x20]
               	cbz	x22, 0x40065c <.text+0x43c>
               	b	0x400644 <.text+0x424>
               	add	x22, x29, #0x30
               	ldr	x21, [x22]
               	sub	x21, x21, #0x40
               	str	x21, [x22]
               	add	x0, x29, #0x10
               	ldr	x21, [x0]
               	add	x21, x21, #0x40
               	str	x21, [x0]
               	ldur	x22, [x29, #0x20]
               	cbz	x22, 0x40069c <.text+0x47c>
               	b	0x400688 <.text+0x468>
               	ldur	x23, [x29, #0x20]
               	ldur	w22, [x29, #-0x58]
               	add	x23, x23, x22
               	ldrb	w22, [x23]
               	stur	x22, [x29, #-0x80]
               	b	0x400668 <.text+0x448>
               	mov	x22, #0x0               // =0
               	stur	x22, [x29, #-0x80]
               	b	0x400668 <.text+0x448>
               	ldur	x22, [x29, #-0x80]
               	sub	x23, x29, #0x50
               	ldur	w21, [x29, #-0x58]
               	add	x23, x23, x21
               	ldrb	w21, [x23]
               	eor	x22, x22, x21
               	strb	w22, [x0]
               	b	0x4005ec <.text+0x3cc>
               	add	x21, x29, #0x20
               	ldr	x22, [x21]
               	add	x22, x22, #0x40
               	str	x22, [x21]
               	b	0x40069c <.text+0x47c>
               	b	0x400570 <.text+0x350>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	sub	x15, x29, #0x48
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x70]
               	b	0x4006f4 <.text+0x4d4>
               	ldursw	x13, [x29, #-0x70]
               	cmp	x13, #0x20
               	b.ge	0x400734 <.text+0x514>
               	b	0x400718 <.text+0x4f8>
               	sub	x14, x29, #0x70
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	b	0x4006f4 <.text+0x4d4>
               	sub	x13, x29, #0x68
               	ldursw	x15, [x29, #-0x70]
               	add	x13, x13, x15
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	strb	w15, [x13]
               	b	0x400704 <.text+0x4e4>
               	sub	x20, x29, #0x40
               	mov	x21, #0x0               // =0
               	mov	x22, #0x40              // =64
               	sub	x23, x29, #0x48
               	sub	x24, x29, #0x68
               	mov	x0, x20
               	mov	x4, x24
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400460 <.text+0x240>
               	sub	x0, x29, #0x40
               	ldrb	w24, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	b.ne	0x400790 <.text+0x570>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0xa0]
               	b	0x40079c <.text+0x57c>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xa0]
               	b	0x40079c <.text+0x57c>
               	ldur	x0, [x29, #-0xa0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
