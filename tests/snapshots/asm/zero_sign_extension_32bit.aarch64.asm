
zero_sign_extension_32bit.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0x100]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x110
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x128
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x12e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x135
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x14, eq
               	cmp	x14, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x160
               	mov	x21, #0x1               // =1
               	str	w21, [x13]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x13, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x168
               	mov	x2, #0x1b               // =27
               	mov	x0, x13
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x160
               	mov	x22, #0x2               // =2
               	str	w22, [x0]
               	mov	x0, x22
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x17e
               	mov	x2, #0x1c               // =28
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x13, x0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x23, #0x3               // =3
               	str	w23, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, #0x194
               	mov	x2, #0x20               // =32
               	mov	x3, x23
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0xfff9            // =65529
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x20, x17
               	b	<addr>
               	adrp	x21, <page>
               	add	x21, x21, #0x160
               	mov	x22, #0x4               // =4
               	str	w22, [x21]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x1aa
               	mov	x2, #0x21               // =33
               	mov	x0, x21
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x24, x17
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x1, x17
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	sxtw	x24, w24
               	b	<addr>
               	adrp	x21, <page>
               	add	x21, x21, #0x160
               	mov	x25, #0xa               // =10
               	str	w25, [x21]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x1c0
               	mov	x2, #0x28               // =40
               	mov	x0, x21
               	mov	x3, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x24, w24
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x160
               	mov	x22, #0xb               // =11
               	str	w22, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x2, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x1d6
               	mov	x0, #0x2a               // =42
               	mov	x3, x22
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4240             // =16960
               	movk	x0, #0xf, lsl #16
               	mov	x2, #0xbb8              // =3000
               	mul	x0, x0, x2
               	sxtw	x20, w0
               	b	<addr>
               	adrp	x21, <page>
               	add	x21, x21, #0x160
               	mov	x24, #0xc               // =12
               	str	w24, [x21]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x1ec
               	mov	x2, #0x30               // =48
               	mov	x0, x21
               	mov	x3, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x23, #0x14              // =20
               	str	w23, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, #0x202
               	mov	x2, #0x3a               // =58
               	mov	x3, x23
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	sxtw	x20, w20
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x10000            // =65536
               	mul	x0, x0, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x0, x17
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x160
               	mov	x24, #0x15              // =21
               	str	w24, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x2, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x218
               	mov	x22, #0x3b              // =59
               	mov	x0, x2
               	mov	x3, x24
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x22, #0x16              // =22
               	str	w22, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, #0x22e
               	mov	x2, #0x40               // =64
               	mov	x3, x22
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x80000000         // =2147483648
               	lsr	x0, x0, #1
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x160
               	mov	x24, #0x17              // =23
               	str	w24, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x2, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x244
               	mov	x23, #0x41              // =65
               	mov	x0, x2
               	mov	x3, x24
               	mov	x2, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	lsl	x0, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x23, <page>
               	add	x23, x23, #0x160
               	mov	x20, #0x1e              // =30
               	str	w20, [x23]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x23, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x25a
               	mov	x2, #0x4a               // =74
               	mov	x0, x23
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x160
               	mov	x24, #0x1f              // =31
               	str	w24, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x2, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x270
               	mov	x23, #0x4f              // =79
               	mov	x0, x2
               	mov	x3, x24
               	mov	x2, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x29c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	<addr>
               	adrp	x23, <page>
               	add	x23, x23, #0x160
               	mov	x20, #0x20              // =32
               	str	w20, [x23]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x23, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x286
               	mov	x2, #0x54               // =84
               	mov	x0, x23
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x21, #0x28              // =40
               	str	w21, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, #0x2a8
               	mov	x2, #0x5d               // =93
               	mov	x3, x21
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	sxtw	x24, w24
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x23, #0x1               // =1
               	add	x1, x24, x23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x160
               	mov	x20, #0x29              // =41
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x2, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x2be
               	mov	x22, #0x5e              // =94
               	mov	x0, x2
               	mov	x3, x20
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x24, x24, x23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x160
               	mov	x22, #0x32              // =50
               	str	w22, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x2, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x2d4
               	mov	x21, #0x68              // =104
               	mov	x0, x2
               	mov	x3, x22
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x24, #0x5678            // =22136
               	movk	x24, #0x1234, lsl #16
               	b	<addr>
               	adrp	x23, <page>
               	add	x23, x23, #0x160
               	mov	x20, #0x33              // =51
               	str	w20, [x23]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x23, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x2ea
               	mov	x2, #0x6c               // =108
               	mov	x0, x23
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x24, x17
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x25, #0x3c              // =60
               	str	w25, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, #0x300
               	mov	x2, #0x73               // =115
               	mov	x3, x25
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x24, #0x6c00            // =27648
               	movk	x24, #0x88ca, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	b	<addr>
               	adrp	x21, <page>
               	add	x21, x21, #0x160
               	mov	x23, #0x3d              // =61
               	str	w23, [x21]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x316
               	mov	x2, #0x75               // =117
               	mov	x0, x21
               	mov	x3, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x20, #0x3e              // =62
               	str	w20, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, #0x32c
               	mov	x2, #0x7a               // =122
               	mov	x3, x20
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x160
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x25, <page>
               	add	x25, x25, #0x160
               	mov	x21, #0x3f              // =63
               	str	w21, [x25]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x25, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x342
               	mov	x2, #0x7b               // =123
               	mov	x0, x25
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x358
               	mov	x0, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, #0x160
               	ldrsw	x2, [x2]
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
