
libc_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0x178]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x13, x19
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
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x1a6
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x1ad
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x11, x19
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
               	sub	sp, sp, #0xc0
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1de
               	mov	x14, x19
               	mov	x0, x14
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1df
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e3
               	mov	x1, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x13, x0
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1e7
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1ee
               	mov	x1, x19
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x2, #0x4                // =4
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1f5
               	mov	x0, x19
               	mov	x1, #0x6c               // =108
               	bl	<addr>
               	mov	x2, x0
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x2]
               	mov	x17, #0x6c              // =108
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	b.eq	<addr>
               	mov	x1, #0x6                // =6
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	adrp	x19, <page>
               	add	x19, x19, #0x1fb
               	mov	x1, x19
               	bl	<addr>
               	mov	x2, x0
               	sub	x0, x29, #0x80
               	adrp	x19, <page>
               	add	x19, x19, #0x1ff
               	mov	x1, x19
               	bl	<addr>
               	mov	x2, x0
               	sub	x0, x29, #0x80
               	adrp	x19, <page>
               	add	x19, x19, #0x203
               	mov	x1, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	cmp	x2, #0x0
               	b.eq	<addr>
               	mov	x1, #0x7                // =7
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	adrp	x19, <page>
               	add	x19, x19, #0x20a
               	mov	x1, x19
               	bl	<addr>
               	mov	x2, x0
               	sub	x2, x29, #0x80
               	add	x0, x2, #0x2
               	sub	x1, x29, #0x80
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	mov	x12, x0
               	sub	x12, x29, #0x80
               	add	x12, x12, #0x2
               	ldrb	w12, [x12]
               	mov	x17, #0x30              // =48
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x2, #0x8                // =8
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x80
               	add	x12, x12, #0x6
               	ldrb	w12, [x12]
               	mov	x17, #0x34              // =52
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x2, #0x9                // =9
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	adrp	x19, <page>
               	add	x19, x19, #0x215
               	mov	x1, x19
               	mov	x2, #0x7                // =7
               	adrp	x19, <page>
               	add	x19, x19, #0x21e
               	mov	x3, x19
               	mov	x4, #0x2a               // =42
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	sub	x0, x29, #0x80
               	adrp	x19, <page>
               	add	x19, x19, #0x221
               	mov	x1, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x3, x0
               	cmp	x3, #0x0
               	b.eq	<addr>
               	mov	x1, #0xa                // =10
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x10               // =16
               	adrp	x19, <page>
               	add	x19, x19, #0x229
               	mov	x2, x19
               	mov	x3, #0x63               // =99
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x4, x0
               	sub	x0, x29, #0x80
               	adrp	x19, <page>
               	add	x19, x19, #0x22c
               	mov	x1, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	cmp	x2, #0x0
               	b.eq	<addr>
               	mov	x1, #0xb                // =11
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x35               // =53
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0xd                // =13
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x61               // =97
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	cbz	x1, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x51               // =81
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0xf                // =15
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7a               // =122
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x61               // =97
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x41
               	b.eq	<addr>
               	mov	x1, #0x11               // =17
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5a               // =90
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	cmp	x1, #0x7a
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x66               // =102
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0x13               // =19
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x22f
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x232
               	mov	x1, x19
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x1, #0x15               // =21
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
