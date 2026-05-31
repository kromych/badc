
return_int_widens_to_double.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400438 <.text+0x178>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400758 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
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
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	bl	0x40040c <.text+0x14c>
               	stur	x0, [x29, #-0x8]
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x900000000000     // =158329674399744
               	movk	x0, #0x407f, lsl #48
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x40049c <.text+0x1dc>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x407f, lsl #48
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, mi
               	stur	x14, [x29, #-0x38]
               	cbnz	x14, 0x4004e4 <.text+0x224>
               	ldur	x0, [x29, #-0x8]
               	mov	x14, #0xa00000000000    // =175921860444160
               	movk	x14, #0x407f, lsl #48
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, gt
               	stur	x0, [x29, #-0x38]
               	b	0x4004e4 <.text+0x224>
               	ldur	x0, [x29, #-0x38]
               	cbz	x0, 0x400510 <.text+0x250>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x40041c <.text+0x15c>
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x20
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x20, ne
               	cbz	x20, 0x400554 <.text+0x294>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	scvtf	d7, x20
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, 0x40059c <.text+0x2dc>
               	mov	x20, #0x4               // =4
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x18
               	sub	x22, x29, #0x8
               	mov	x20, #0x8               // =8
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	0x400764 <memcpy>
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0x900000000000    // =158329674399744
               	movk	x17, #0x407f, lsl #48
               	cmp	x0, x17
               	b.eq	0x4005f0 <.text+0x330>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
