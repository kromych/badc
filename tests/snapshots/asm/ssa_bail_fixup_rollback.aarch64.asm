
ssa_bail_fixup_rollback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	sub	sp, sp, #0x50
               	mov	x15, x0
               	mov	x14, x1
               	mov	x13, x2
               	mov	x12, x3
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x48]
               	b	<addr>
               	ldursw	x11, [x29, #-0x48]
               	cmp	x11, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x10, x29, #0x48
               	ldrsw	x11, [x10]
               	add	x11, x11, #0x1
               	str	w11, [x10]
               	b	<addr>
               	sub	x11, x29, #0x40
               	ldursw	x9, [x29, #-0x48]
               	mov	x17, #0x5               // =5
               	mul	x10, x9, x17
               	sxtw	x10, w10
               	lsl	x10, x10, #2
               	add	x11, x11, x10
               	lsl	x9, x9, #2
               	sxtw	x9, w9
               	add	x9, x12, x9
               	add	x10, x9, #0x3
               	ldrb	w8, [x10]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	lsl	x8, x8, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	add	x10, x9, #0x2
               	ldrb	w7, [x10]
               	orr	x8, x8, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	lsl	x8, x8, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	add	x7, x9, #0x1
               	ldrb	w10, [x7]
               	orr	x8, x8, x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	lsl	x8, x8, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	ldrb	w10, [x9]
               	orr	x8, x8, x10
               	str	w8, [x11]
               	sub	x10, x29, #0x40
               	ldursw	x8, [x29, #-0x48]
               	add	x11, x8, #0x1
               	sxtw	x11, w11
               	lsl	x11, x11, #2
               	add	x10, x10, x11
               	lsl	x8, x8, #2
               	sxtw	x8, w8
               	add	x8, x13, x8
               	add	x11, x8, #0x3
               	ldrb	w9, [x11]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	lsl	x9, x9, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	add	x11, x8, #0x2
               	ldrb	w7, [x11]
               	orr	x9, x9, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	lsl	x9, x9, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	add	x7, x8, #0x1
               	ldrb	w11, [x7]
               	orr	x9, x9, x11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	lsl	x9, x9, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	ldrb	w11, [x8]
               	orr	x9, x9, x11
               	str	w9, [x10]
               	sub	x11, x29, #0x40
               	ldursw	x9, [x29, #-0x48]
               	add	x10, x9, #0x6
               	sxtw	x10, w10
               	lsl	x10, x10, #2
               	add	x11, x11, x10
               	lsl	x9, x9, #2
               	sxtw	x9, w9
               	add	x9, x14, x9
               	add	x10, x9, #0x3
               	ldrb	w8, [x10]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	lsl	x8, x8, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	add	x10, x9, #0x2
               	ldrb	w7, [x10]
               	orr	x8, x8, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	lsl	x8, x8, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	add	x7, x9, #0x1
               	ldrb	w10, [x7]
               	orr	x8, x8, x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	lsl	x8, x8, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	ldrb	w10, [x9]
               	orr	x8, x8, x10
               	str	w8, [x11]
               	sub	x10, x29, #0x40
               	ldursw	x8, [x29, #-0x48]
               	add	x11, x8, #0xb
               	sxtw	x11, w11
               	lsl	x11, x11, #2
               	add	x10, x10, x11
               	add	x11, x13, #0x10
               	lsl	x8, x8, #2
               	sxtw	x8, w8
               	add	x11, x11, x8
               	add	x8, x11, #0x3
               	ldrb	w9, [x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	lsl	x9, x9, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	add	x8, x11, #0x2
               	ldrb	w7, [x8]
               	orr	x9, x9, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	lsl	x9, x9, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	add	x7, x11, #0x1
               	ldrb	w8, [x7]
               	orr	x9, x9, x8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	lsl	x9, x9, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	ldrb	w8, [x11]
               	orr	x9, x9, x8
               	str	w9, [x10]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x8, x29, #0x40
               	ldr	w12, [x8]
               	sub	x8, x29, #0x40
               	add	x8, x8, #0x14
               	ldr	w13, [x8]
               	eor	x12, x12, x13
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x28
               	ldr	w8, [x13]
               	eor	x12, x12, x8
               	sub	x8, x29, #0x40
               	add	x8, x8, #0x3c
               	ldr	w13, [x8]
               	eor	x12, x12, x13
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	strb	w12, [x15]
               	add	sp, sp, #0x50
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
               	b.ne	<addr>
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
               	b	<addr>
               	ldur	w13, [x29, #-0x58]
               	cmp	x13, #0x10
               	b.hs	<addr>
               	b	<addr>
               	sub	x12, x29, #0x58
               	ldr	w13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	<addr>
               	sub	x13, x29, #0x10
               	ldur	w11, [x29, #-0x58]
               	add	x13, x13, x11
               	mov	x11, #0x0               // =0
               	strb	w11, [x13]
               	b	<addr>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x58]
               	b	<addr>
               	ldur	w11, [x29, #-0x58]
               	cmp	x11, #0x8
               	b.hs	<addr>
               	b	<addr>
               	sub	x12, x29, #0x58
               	ldr	w11, [x12]
               	add	x11, x11, #0x1
               	str	w11, [x12]
               	b	<addr>
               	sub	x11, x29, #0x10
               	ldur	w13, [x29, #-0x58]
               	add	x11, x11, x13
               	add	x13, x3, x13
               	ldrb	w12, [x13]
               	strb	w12, [x11]
               	b	<addr>
               	b	<addr>
               	ldur	x12, [x29, #0x30]
               	cmp	x12, #0x40
               	b.lo	<addr>
               	sub	x21, x29, #0x50
               	sub	x22, x29, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x23, x19
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x58]
               	b	<addr>
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
               	b.hs	<addr>
               	b	<addr>
               	sub	x23, x29, #0x58
               	ldr	w0, [x23]
               	add	x0, x0, #0x1
               	str	w0, [x23]
               	b	<addr>
               	ldur	x0, [x29, #0x10]
               	ldur	w22, [x29, #-0x58]
               	add	x0, x0, x22
               	ldur	x22, [x29, #0x20]
               	cbz	x22, <addr>
               	b	<addr>
               	add	x22, x29, #0x30
               	ldr	x21, [x22]
               	sub	x21, x21, #0x40
               	str	x21, [x22]
               	add	x0, x29, #0x10
               	ldr	x21, [x0]
               	add	x21, x21, #0x40
               	str	x21, [x0]
               	ldur	x22, [x29, #0x20]
               	cbz	x22, <addr>
               	b	<addr>
               	ldur	x23, [x29, #0x20]
               	ldur	w22, [x29, #-0x58]
               	add	x23, x23, x22
               	ldrb	w22, [x23]
               	stur	x22, [x29, #-0x80]
               	b	<addr>
               	mov	x22, #0x0               // =0
               	stur	x22, [x29, #-0x80]
               	b	<addr>
               	ldur	x22, [x29, #-0x80]
               	sub	x23, x29, #0x50
               	ldur	w21, [x29, #-0x58]
               	add	x23, x23, x21
               	ldrb	w21, [x23]
               	eor	x22, x22, x21
               	strb	w22, [x0]
               	b	<addr>
               	add	x21, x29, #0x20
               	ldr	x22, [x21]
               	add	x22, x22, #0x40
               	str	x22, [x21]
               	b	<addr>
               	b	<addr>
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
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x70]
               	b	<addr>
               	ldursw	x13, [x29, #-0x70]
               	cmp	x13, #0x20
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x70
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	b	<addr>
               	sub	x13, x29, #0x68
               	ldursw	x15, [x29, #-0x70]
               	add	x13, x13, x15
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	strb	w15, [x13]
               	b	<addr>
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
               	bl	<addr>
               	sub	x0, x29, #0x40
               	ldrb	w24, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0xa0]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xa0]
               	b	<addr>
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
