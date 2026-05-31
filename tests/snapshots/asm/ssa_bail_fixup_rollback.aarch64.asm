
ssa_bail_fixup_rollback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4006a8 <.text+0x488>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	add	x14, x15, #0x3
               	ldrb	w13, [x14]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x13, x17
               	lsl	x13, x14, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x13, x17
               	add	x13, x15, #0x2
               	ldrb	w12, [x13]
               	orr	x13, x14, x12
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x13, x17
               	lsl	x13, x12, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x13, x17
               	add	x13, x15, #0x1
               	ldrb	w14, [x13]
               	orr	x13, x12, x14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x13, x17
               	lsl	x13, x14, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x13, x17
               	ldrb	w13, [x15]
               	orr	x0, x14, x13
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
               	str	x27, [sp, #0x38]
               	mov	x20, x0
               	mov	x21, x1
               	mov	x22, x2
               	mov	x23, x3
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x48]
               	b	0x400304 <.text+0xe4>
               	ldursw	x11, [x29, #-0x48]
               	cmp	x11, #0x4
               	b.ge	0x4003f4 <.text+0x1d4>
               	b	0x400328 <.text+0x108>
               	sub	x11, x29, #0x48
               	ldrsw	x10, [x11]
               	add	x9, x10, #0x1
               	str	w9, [x11]
               	b	0x400304 <.text+0xe4>
               	sub	x9, x29, #0x40
               	ldursw	x10, [x29, #-0x48]
               	mov	x17, #0x5               // =5
               	mul	x11, x10, x17
               	sxtw	x11, w11
               	lsl	x8, x11, #2
               	add	x24, x9, x8
               	lsl	x8, x10, #2
               	sxtw	x8, w8
               	add	x25, x23, x8
               	mov	x0, x25
               	bl	0x400238 <.text+0x18>
               	str	w0, [x24]
               	sub	x25, x29, #0x40
               	ldursw	x0, [x29, #-0x48]
               	add	x24, x0, #0x1
               	sxtw	x24, w24
               	lsl	x9, x24, #2
               	add	x26, x25, x9
               	lsl	x9, x0, #2
               	sxtw	x9, w9
               	add	x24, x22, x9
               	mov	x0, x24
               	bl	0x400238 <.text+0x18>
               	str	w0, [x26]
               	sub	x24, x29, #0x40
               	ldursw	x0, [x29, #-0x48]
               	add	x26, x0, #0x6
               	sxtw	x26, w26
               	lsl	x25, x26, #2
               	add	x27, x24, x25
               	lsl	x25, x0, #2
               	sxtw	x25, w25
               	add	x26, x21, x25
               	mov	x0, x26
               	bl	0x400238 <.text+0x18>
               	str	w0, [x27]
               	sub	x26, x29, #0x40
               	ldursw	x0, [x29, #-0x48]
               	add	x27, x0, #0xb
               	sxtw	x27, w27
               	lsl	x24, x27, #2
               	add	x25, x26, x24
               	add	x24, x22, #0x10
               	lsl	x26, x0, #2
               	sxtw	x26, w26
               	add	x27, x24, x26
               	mov	x0, x27
               	bl	0x400238 <.text+0x18>
               	str	w0, [x25]
               	b	0x400314 <.text+0xf4>
               	mov	x0, #0x0                // =0
               	sub	x27, x29, #0x40
               	ldr	w23, [x27]
               	sub	x27, x29, #0x40
               	add	x22, x27, #0x14
               	ldr	w27, [x22]
               	eor	x22, x23, x27
               	sub	x27, x29, #0x40
               	add	x23, x27, #0x28
               	ldr	w27, [x23]
               	eor	x23, x22, x27
               	sub	x27, x29, #0x40
               	add	x22, x27, #0x3c
               	ldr	w27, [x22]
               	eor	x22, x23, x27
               	mov	x17, #0xff              // =255
               	and	x27, x22, x17
               	strb	w27, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
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
               	b.ne	0x4004e0 <.text+0x2c0>
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x58]
               	b	0x4004ec <.text+0x2cc>
               	ldur	w12, [x29, #-0x58]
               	cmp	x12, #0x10
               	b.hs	0x400528 <.text+0x308>
               	b	0x400510 <.text+0x2f0>
               	sub	x12, x29, #0x58
               	ldr	w13, [x12]
               	add	x11, x13, #0x1
               	str	w11, [x12]
               	b	0x4004ec <.text+0x2cc>
               	sub	x11, x29, #0x10
               	ldur	w13, [x29, #-0x58]
               	add	x12, x11, x13
               	mov	x13, #0x0               // =0
               	strb	w13, [x12]
               	b	0x4004fc <.text+0x2dc>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x58]
               	b	0x400534 <.text+0x314>
               	ldur	w13, [x29, #-0x58]
               	cmp	x13, #0x8
               	b.hs	0x400574 <.text+0x354>
               	b	0x400558 <.text+0x338>
               	sub	x13, x29, #0x58
               	ldr	w11, [x13]
               	add	x12, x11, #0x1
               	str	w12, [x13]
               	b	0x400534 <.text+0x314>
               	sub	x12, x29, #0x10
               	ldur	w11, [x29, #-0x58]
               	add	x13, x12, x11
               	add	x12, x3, x11
               	ldrb	w11, [x12]
               	strb	w11, [x13]
               	b	0x400544 <.text+0x324>
               	b	0x400578 <.text+0x358>
               	ldur	x11, [x29, #0x30]
               	cmp	x11, #0x40
               	b.lo	0x4005b8 <.text+0x398>
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
               	b	0x4005e4 <.text+0x3c4>
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
               	b.hs	0x400620 <.text+0x400>
               	b	0x400608 <.text+0x3e8>
               	sub	x0, x29, #0x58
               	ldr	w23, [x0]
               	add	x22, x23, #0x1
               	str	w22, [x0]
               	b	0x4005e4 <.text+0x3c4>
               	ldur	x22, [x29, #0x10]
               	ldur	w23, [x29, #-0x58]
               	add	x0, x22, x23
               	ldur	x23, [x29, #0x20]
               	cbz	x23, 0x400664 <.text+0x444>
               	b	0x40064c <.text+0x42c>
               	add	x10, x29, #0x30
               	ldr	x22, [x10]
               	sub	x0, x22, #0x40
               	str	x0, [x10]
               	add	x22, x29, #0x10
               	ldr	x0, [x22]
               	add	x10, x0, #0x40
               	str	x10, [x22]
               	ldur	x0, [x29, #0x20]
               	cbz	x0, 0x4006a4 <.text+0x484>
               	b	0x400690 <.text+0x470>
               	ldur	x22, [x29, #0x20]
               	ldur	w23, [x29, #-0x58]
               	add	x21, x22, x23
               	ldrb	w23, [x21]
               	stur	x23, [x29, #-0x80]
               	b	0x400670 <.text+0x450>
               	mov	x23, #0x0               // =0
               	stur	x23, [x29, #-0x80]
               	b	0x400670 <.text+0x450>
               	ldur	x23, [x29, #-0x80]
               	sub	x21, x29, #0x50
               	ldur	w22, [x29, #-0x58]
               	add	x10, x21, x22
               	ldrb	w22, [x10]
               	eor	x10, x23, x22
               	strb	w10, [x0]
               	b	0x4005f4 <.text+0x3d4>
               	add	x10, x29, #0x20
               	ldr	x0, [x10]
               	add	x22, x0, #0x40
               	str	x22, [x10]
               	b	0x4006a4 <.text+0x484>
               	b	0x400578 <.text+0x358>
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
               	b	0x4006fc <.text+0x4dc>
               	ldursw	x13, [x29, #-0x70]
               	cmp	x13, #0x20
               	b.ge	0x40073c <.text+0x51c>
               	b	0x400720 <.text+0x500>
               	sub	x13, x29, #0x70
               	ldrsw	x14, [x13]
               	add	x15, x14, #0x1
               	str	w15, [x13]
               	b	0x4006fc <.text+0x4dc>
               	sub	x15, x29, #0x68
               	ldursw	x14, [x29, #-0x70]
               	add	x13, x15, x14
               	mov	x17, #0xff              // =255
               	and	x15, x14, x17
               	strb	w15, [x13]
               	b	0x40070c <.text+0x4ec>
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
               	bl	0x400468 <.text+0x248>
               	sub	x0, x29, #0x40
               	ldrb	w24, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	cmp	x24, #0x0
               	b.ne	0x400798 <.text+0x578>
               	mov	x24, #0x0               // =0
               	stur	x24, [x29, #-0xa0]
               	b	0x4007a4 <.text+0x584>
               	mov	x24, #0x1               // =1
               	stur	x24, [x29, #-0xa0]
               	b	0x4007a4 <.text+0x584>
               	ldur	x24, [x29, #-0xa0]
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
