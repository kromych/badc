
ssa_call_result_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400310 <.text+0xf0>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	sxtw	x14, w1
               	lsr	x13, x15, x14
               	mov	x12, #0x40              // =64
               	sub	x11, x12, x14
               	sxtw	x11, w11
               	lsl	x12, x15, x11
               	orr	x0, x13, x12
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	mov	x13, x2
               	and	x12, x15, x14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x14, x15, x17
               	and	x15, x14, x13
               	eor	x0, x12, x15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x20, x0
               	mov	x21, #0xe               // =14
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	mov	x22, x0
               	mov	x23, #0x12              // =18
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400238 <.text+0x18>
               	mov	x12, x0
               	eor	x21, x22, x12
               	mov	x23, #0x29              // =41
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400238 <.text+0x18>
               	mov	x22, x0
               	eor	x23, x21, x22
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x15, #0x100             // =256
               	stur	x15, [x29, #-0x8]
               	mov	x14, #0x200             // =512
               	stur	x14, [x29, #-0x10]
               	mov	x15, #0x400             // =1024
               	stur	x15, [x29, #-0x18]
               	mov	x14, #0x800             // =2048
               	stur	x14, [x29, #-0x20]
               	mov	x15, #0x1000            // =4096
               	stur	x15, [x29, #-0x28]
               	mov	x14, #0x2000            // =8192
               	stur	x14, [x29, #-0x30]
               	mov	x15, #0x4000            // =16384
               	stur	x15, [x29, #-0x38]
               	mov	x14, #0x8000            // =32768
               	stur	x14, [x29, #-0x40]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x48]
               	b	0x40037c <.text+0x15c>
               	ldursw	x15, [x29, #-0x48]
               	cmp	x15, #0x4
               	b.ge	0x400444 <.text+0x224>
               	b	0x4003a0 <.text+0x180>
               	sub	x15, x29, #0x48
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x40037c <.text+0x15c>
               	ldur	x20, [x29, #-0x28]
               	mov	x0, x20
               	bl	0x40028c <.text+0x6c>
               	mov	x21, x0
               	ldur	x22, [x29, #-0x28]
               	ldur	x20, [x29, #-0x30]
               	ldur	x23, [x29, #-0x38]
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x20
               	bl	0x40025c <.text+0x3c>
               	mov	x11, x0
               	add	x23, x21, x11
               	ldur	x11, [x29, #-0x40]
               	add	x21, x23, x11
               	stur	x21, [x29, #-0x50]
               	ldur	x24, [x29, #-0x8]
               	mov	x0, x24
               	bl	0x40028c <.text+0x6c>
               	mov	x21, x0
               	stur	x21, [x29, #-0x58]
               	ldur	x24, [x29, #-0x38]
               	stur	x24, [x29, #-0x40]
               	ldur	x21, [x29, #-0x30]
               	stur	x21, [x29, #-0x38]
               	ldur	x24, [x29, #-0x28]
               	stur	x24, [x29, #-0x30]
               	ldur	x21, [x29, #-0x20]
               	ldur	x24, [x29, #-0x50]
               	add	x23, x21, x24
               	stur	x23, [x29, #-0x28]
               	ldur	x21, [x29, #-0x18]
               	stur	x21, [x29, #-0x20]
               	ldur	x23, [x29, #-0x10]
               	stur	x23, [x29, #-0x18]
               	ldur	x21, [x29, #-0x8]
               	stur	x21, [x29, #-0x10]
               	ldur	x23, [x29, #-0x58]
               	add	x21, x24, x23
               	stur	x21, [x29, #-0x8]
               	b	0x40038c <.text+0x16c>
               	ldur	x21, [x29, #-0x8]
               	mov	x17, #0xbb19            // =47897
               	movk	x17, #0xde61, lsl #16
               	movk	x17, #0x5d88, lsl #32
               	movk	x17, #0x30a5, lsl #48
               	cmp	x21, x17
               	b.eq	0x400488 <.text+0x268>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x23, [x29, #-0x40]
               	mov	x17, #0xc800            // =51200
               	movk	x17, #0x8, lsl #32
               	movk	x17, #0x4400, lsl #48
               	cmp	x23, x17
               	b.eq	0x4004c8 <.text+0x2a8>
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec615
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406b48 <exit+0x6510>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8bd8
               	tbz	w21, #0x6, 0x3feb9c
               	<unknown>
               	cbnz	w16, 0x46eb44
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400150
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
		...
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x400638 <exit>
               	uxtb	w0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec6e1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406c14 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8ca4
               	tbz	w21, #0x6, 0x3fec68
               	<unknown>
               	cbnz	w16, 0x46ec10
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40021c
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	br	x16
