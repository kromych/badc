
unsigned_compound_assign.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x0, [x14]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x0, [x21]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x64              // =100
               	stur	w15, [x29, #-0x8]
               	sub	x14, x29, #0x8
               	ldr	w15, [x14]
               	add	x15, x15, #0x5
               	str	w15, [x14]
               	ldur	w13, [x29, #-0x8]
               	mov	x17, #0x69              // =105
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x20, x19
               	ldur	w21, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x8
               	ldr	w0, [x21]
               	sub	x0, x0, #0x3
               	str	w0, [x21]
               	ldur	w20, [x29, #-0x8]
               	mov	x17, #0x66              // =102
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x166
               	mov	x22, x19
               	ldur	w23, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x3e8             // =1000
               	stur	x23, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	ldr	x23, [x0]
               	add	x23, x23, #0x19f
               	str	x23, [x0]
               	ldur	x22, [x29, #-0x10]
               	cmp	x22, #0x587
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x17c
               	mov	x21, x19
               	ldur	x23, [x29, #-0x10]
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x41c             // =1052
               	stur	w23, [x29, #-0x18]
               	mov	x0, #0x19f              // =415
               	sxtw	x0, w0
               	sub	x23, x29, #0x18
               	ldr	w21, [x23]
               	sxtw	x0, w0
               	add	x21, x21, x0
               	str	w21, [x23]
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0x5bb             // =1467
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x195
               	mov	x22, x19
               	ldur	w21, [x29, #-0x18]
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xc8              // =200
               	sturb	w21, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	ldrb	w21, [x0]
               	add	x21, x21, #0x3c
               	strb	w21, [x0]
               	ldurb	w22, [x29, #-0x28]
               	mov	x17, #0x4               // =4
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b6
               	mov	x23, x19
               	ldurb	w21, [x29, #-0x28]
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x40
               	mov	x0, #0x0                // =0
               	str	w0, [x21]
               	sub	x23, x29, #0x40
               	add	x23, x23, #0x4
               	mov	x0, #0xa                // =10
               	str	w0, [x23]
               	sub	x21, x29, #0x40
               	add	x21, x21, #0x8
               	mov	x0, #0x14               // =20
               	str	w0, [x21]
               	sub	x23, x29, #0x40
               	add	x23, x23, #0xc
               	mov	x0, #0x1e               // =30
               	str	w0, [x23]
               	sub	x21, x29, #0x40
               	add	x21, x21, #0x10
               	mov	x0, #0x28               // =40
               	str	w0, [x21]
               	sub	x23, x29, #0x40
               	stur	x23, [x29, #-0x48]
               	sub	x0, x29, #0x48
               	ldr	x23, [x0]
               	add	x23, x23, #0xc
               	str	x23, [x0]
               	ldur	x21, [x29, #-0x48]
               	ldrsw	x23, [x21]
               	cmp	x23, #0x1e
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d2
               	mov	x22, x19
               	ldur	x23, [x29, #-0x48]
               	ldrsw	x21, [x23]
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
