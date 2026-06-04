
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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x118
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x11e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x125
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x19, [sp]
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	add	x1, x1, #0x5
               	str	w1, [x0]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldur	w1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	sub	x1, x1, #0x3
               	str	w1, [x0]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x66              // =102
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x166
               	ldur	w1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	add	x1, x1, #0x19f
               	str	x1, [x0]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x587
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x17c
               	ldur	x1, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41c              // =1052
               	stur	w0, [x29, #-0x18]
               	mov	x0, #0x19f              // =415
               	sub	x1, x29, #0x18
               	ldr	w2, [x1]
               	add	x0, x2, x0
               	str	w0, [x1]
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0x5bb             // =1467
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x195
               	ldur	w1, [x29, #-0x18]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x28]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x1b6
               	ldurb	w1, [x29, #-0x28]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x4
               	mov	x1, #0xa                // =10
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x8
               	mov	x1, #0x14               // =20
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0xc
               	mov	x1, #0x1e               // =30
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x10
               	mov	x1, #0x28               // =40
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x48]
               	sub	x0, x29, #0x48
               	ldr	x1, [x0]
               	add	x1, x1, #0xc
               	str	x1, [x0]
               	ldur	x0, [x29, #-0x48]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1d2
               	ldur	x1, [x29, #-0x48]
               	ldrsw	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
