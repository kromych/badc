
typedef_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40024c <.text+0x2c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w1
               	add	x13, x15, x14
               	sxtw	x0, w13
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x15, #0x64              // =100
               	mov	x20, #0x41              // =65
               	mov	x21, #0x2d2             // =722
               	movk	x21, #0x4996, lsl #16
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x22, x19
               	sub	x11, x29, #0x30
               	mov	x10, #0x7               // =7
               	str	w10, [x11]
               	sub	x9, x29, #0x30
               	add	x10, x9, #0x8
               	mov	x9, #0x0                // =0
               	str	x9, [x10]
               	sub	x11, x29, #0x38
               	mov	x9, #0xb                // =11
               	str	w9, [x11]
               	sub	x10, x29, #0x38
               	add	x9, x10, #0x4
               	mov	x10, #0x16              // =22
               	str	w10, [x9]
               	sub	x11, x29, #0x48
               	mov	x10, #0x1               // =1
               	str	w10, [x11]
               	sub	x9, x29, #0x48
               	add	x10, x9, #0x4
               	mov	x9, #0x2                // =2
               	str	w9, [x10]
               	sub	x11, x29, #0x48
               	add	x9, x11, #0x8
               	mov	x11, #0x3               // =3
               	str	w11, [x9]
               	sxtw	x23, w15
               	mov	x17, #0xff              // =255
               	and	x24, x20, x17
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0xa5
               	b.eq	0x400338 <.text+0x118>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w24, [x22]
               	mov	x17, #0x68              // =104
               	eor	x22, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x22, x17
               	cmp	x24, #0x0
               	b.eq	0x400384 <.text+0x164>
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x30
               	ldrsw	x24, [x22]
               	cmp	x24, #0x7
               	b.eq	0x4003c0 <.text+0x1a0>
               	mov	x24, #0x3               // =3
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x38
               	ldrsw	x24, [x22]
               	sub	x22, x29, #0x38
               	add	x0, x22, #0x4
               	ldrsw	x22, [x0]
               	add	x0, x24, x22
               	sxtw	x0, w0
               	cmp	x0, #0x21
               	b.eq	0x40040c <.text+0x1ec>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x48
               	ldrsw	x0, [x22]
               	sub	x22, x29, #0x48
               	add	x24, x22, #0x4
               	ldrsw	x22, [x24]
               	add	x24, x0, x22
               	sxtw	x24, w24
               	sub	x22, x29, #0x48
               	add	x0, x22, #0x8
               	ldrsw	x22, [x0]
               	add	x0, x24, x22
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	0x40046c <.text+0x24c>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x2d2             // =722
               	movk	x17, #0x4996, lsl #16
               	cmp	x21, x17
               	b.eq	0x4004a8 <.text+0x288>
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff              // =255
               	and	x22, x20, x17
               	cmp	x22, #0x41
               	b.eq	0x4004e4 <.text+0x2c4>
               	mov	x22, #0x7               // =7
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	cbz	x21, 0x400518 <.text+0x2f8>
               	mov	x22, #0x8               // =8
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	cbz	x21, 0x40054c <.text+0x32c>
               	mov	x22, #0x9               // =9
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
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
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
