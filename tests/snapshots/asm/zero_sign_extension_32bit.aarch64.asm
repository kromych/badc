
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
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x110
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x128
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x12e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x135
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
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
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x21, #0x1               // =1
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x148
               	mov	x2, #0x1b               // =27
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
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x2               // =2
               	str	w20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x15e
               	mov	x2, #0x1c               // =28
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x21, #0x3               // =3
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x174
               	mov	x2, #0x20               // =32
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0xfff9            // =65529
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x20, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x4               // =4
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x18a
               	mov	x2, #0x21               // =33
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x22, #0xa               // =10
               	str	w22, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1a0
               	mov	x2, #0x28               // =40
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x21, #0xb               // =11
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1b6
               	mov	x2, #0x2a               // =42
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4240             // =16960
               	movk	x0, #0xf, lsl #16
               	mov	x1, #0xbb8              // =3000
               	mul	x0, x0, x1
               	sxtw	x20, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0xc               // =12
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1cc
               	mov	x2, #0x30               // =48
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x21, #0x14              // =20
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1e2
               	mov	x2, #0x3a               // =58
               	mov	x3, x21
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
               	mov	x0, #0x10000            // =65536
               	mul	x0, x0, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x15              // =21
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1f8
               	mov	x2, #0x3b               // =59
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x21, #0x16              // =22
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x20e
               	mov	x2, #0x40               // =64
               	mov	x3, x21
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
               	mov	x0, #0x80000000         // =2147483648
               	lsr	x0, x0, #1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x17              // =23
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x224
               	mov	x2, #0x41               // =65
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x1e              // =30
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x23a
               	mov	x2, #0x4a               // =74
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
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x1f              // =31
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x250
               	mov	x2, #0x4f               // =79
               	mov	x3, x20
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
               	add	x0, x0, #0x27c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x20              // =32
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x266
               	mov	x2, #0x54               // =84
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x21, #0x28              // =40
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x288
               	mov	x2, #0x5d               // =93
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w20
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
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	add	x0, x20, x21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x29              // =41
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x29e
               	mov	x2, #0x5e               // =94
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x20, x21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x22, #0x32              // =50
               	str	w22, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2b4
               	mov	x2, #0x68               // =104
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0x5678            // =22136
               	movk	x20, #0x1234, lsl #16
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x33              // =51
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2ca
               	mov	x2, #0x6c               // =108
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x21, #0x3c              // =60
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2e0
               	mov	x2, #0x73               // =115
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0x6c00            // =27648
               	movk	x20, #0x88ca, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x3d              // =61
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2f6
               	mov	x2, #0x75               // =117
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x21, #0x3e              // =62
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x30c
               	mov	x2, #0x7a               // =122
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	mov	x20, #0x3f              // =63
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x322
               	mov	x2, #0x7b               // =123
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x338
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x140
               	ldrsw	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
