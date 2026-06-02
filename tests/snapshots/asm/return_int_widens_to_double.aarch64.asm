
return_int_widens_to_double.aarch64:	file format elf64-littleaarch64

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
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x1f9             // =505
               	scvtf	d0, x15
               	fmov	x0, d0
               	ret
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	scvtf	d0, x15
               	fmov	x0, d0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x19, [sp]
               	mov	x15, #0x1f9             // =505
               	scvtf	d7, x15
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x15, [x29, #-0x8]
               	mov	x14, #0x900000000000    // =158329674399744
               	movk	x14, #0x407f, lsl #48
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x8]
               	mov	x14, #0x800000000000    // =140737488355328
               	movk	x14, #0x407f, lsl #48
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x15, mi
               	stur	x15, [x29, #-0x38]
               	cbnz	x15, <addr>
               	ldur	x14, [x29, #-0x8]
               	mov	x15, #0xa00000000000    // =175921860444160
               	movk	x15, #0x407f, lsl #48
               	fmov	d0, x14
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x14, gt
               	stur	x14, [x29, #-0x38]
               	b	<addr>
               	ldur	x14, [x29, #-0x38]
               	cbz	x14, <addr>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	scvtf	d7, x14
               	mov	x14, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x14
               	fneg	d6, d0
               	fcmp	d7, d6
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	scvtf	d6, x14
               	fcmp	d7, d6
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0x900000000000    // =158329674399744
               	movk	x17, #0x407f, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x1, #0x5                // =5
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
