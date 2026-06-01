
c99_arith_common_width.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
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
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x126
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x12d
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
               	add	x19, x19, #0x108
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
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
               	sub	sp, sp, #0x100
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	add	x15, x15, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x15, x17
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x20, x17
               	cmp	x15, #0x0
               	cset	x15, eq
               	cmp	x15, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x0, #0x0                // =0
               	sub	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x13, x19
               	mov	x21, #0x1               // =1
               	str	w21, [x13]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x13, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x160
               	mov	x1, x19
               	mov	x2, #0x1a               // =26
               	mov	x0, x13
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x2, #0x1                // =1
               	sub	x21, x21, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x23, #0x2               // =2
               	str	w23, [x20]
               	mov	x0, x23
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x176
               	mov	x1, x19
               	mov	x2, #0x21               // =33
               	mov	x3, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x21, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x2, x17
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x2, #0x1                // =1
               	mul	x0, x0, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x20, #0x3               // =3
               	str	w20, [x22]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x18c
               	mov	x1, x19
               	mov	x2, #0x29               // =41
               	mov	x0, x22
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x0, #0xc350             // =50000
               	mul	x0, x0, x0
               	sxtw	x22, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0x4               // =4
               	str	w24, [x21]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a2
               	mov	x1, x19
               	mov	x2, #0x31               // =49
               	mov	x0, x21
               	mov	x3, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xf900            // =63744
               	movk	x17, #0x9502, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x2, #0x1                // =1
               	add	x0, x0, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x5               // =5
               	str	w20, [x23]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x1, x19
               	mov	x2, #0x3e               // =62
               	mov	x0, x23
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x24, #0x64              // =100
               	str	w24, [x22]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1ce
               	mov	x1, x19
               	mov	x2, #0x4b               // =75
               	mov	x0, x22
               	mov	x3, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	cmp	x23, x20
               	cset	x21, lt
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x1, x19
               	mov	x25, #0x65              // =101
               	str	w25, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1e4
               	mov	x0, x19
               	mov	x2, #0x54               // =84
               	mov	x3, x25
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x9, x0
               	b	<addr>
               	b	<addr>
               	eor	x20, x22, x24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x0, x19
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x21, #0x66              // =102
               	str	w21, [x23]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1fa
               	mov	x1, x19
               	mov	x2, #0x5d               // =93
               	mov	x0, x23
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x210
               	mov	x2, x19
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
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x2, x19
               	ldrsw	x2, [x2]
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
