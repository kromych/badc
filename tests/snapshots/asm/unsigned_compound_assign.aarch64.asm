
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0x100
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x19, [sp]
               	mov	x15, #0x64              // =100
               	stur	w15, [x29, #-0x8]
               	sub	x14, x29, #0x8
               	ldr	w15, [x14]
               	add	x15, x15, #0x5
               	str	w15, [x14]
               	ldur	w14, [x29, #-0x8]
               	mov	x17, #0x69              // =105
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldur	w1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x8
               	ldr	w15, [x1]
               	sub	x15, x15, #0x3
               	str	w15, [x1]
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0x66              // =102
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x166
               	ldur	w1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3e8              // =1000
               	stur	x1, [x29, #-0x10]
               	sub	x15, x29, #0x10
               	ldr	x1, [x15]
               	add	x1, x1, #0x19f
               	str	x1, [x15]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x587
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x17c
               	ldur	x0, [x29, #-0x10]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41c              // =1052
               	stur	w0, [x29, #-0x18]
               	mov	x15, #0x19f             // =415
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	add	x1, x1, x15
               	str	w1, [x0]
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0x5bb             // =1467
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x15, <page>
               	add	x15, x15, #0x195
               	ldur	w1, [x29, #-0x18]
               	mov	x0, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xc8               // =200
               	sturb	w1, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	ldrb	w1, [x0]
               	add	x1, x1, #0x3c
               	strb	w1, [x0]
               	ldurb	w0, [x29, #-0x28]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x15, <page>
               	add	x15, x15, #0x1b6
               	ldurb	w1, [x29, #-0x28]
               	mov	x0, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x40
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	sub	x15, x29, #0x40
               	add	x15, x15, #0x4
               	mov	x0, #0xa                // =10
               	str	w0, [x15]
               	sub	x1, x29, #0x40
               	add	x1, x1, #0x8
               	mov	x0, #0x14               // =20
               	str	w0, [x1]
               	sub	x15, x29, #0x40
               	add	x15, x15, #0xc
               	mov	x0, #0x1e               // =30
               	str	w0, [x15]
               	sub	x1, x29, #0x40
               	add	x1, x1, #0x10
               	mov	x0, #0x28               // =40
               	str	w0, [x1]
               	sub	x15, x29, #0x40
               	stur	x15, [x29, #-0x48]
               	sub	x0, x29, #0x48
               	ldr	x15, [x0]
               	add	x15, x15, #0xc
               	str	x15, [x0]
               	ldur	x1, [x29, #-0x48]
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1e
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1d2
               	ldur	x1, [x29, #-0x48]
               	ldrsw	x15, [x1]
               	mov	x1, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
