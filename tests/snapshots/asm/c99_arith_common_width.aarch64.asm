
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
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
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
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
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
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
               	mov	x22, #0x0               // =0
               	cbnz	x22, <addr>
               	mov	x0, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	sub	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x13, x19
               	mov	x21, #0x1               // =1
               	str	w21, [x13]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x160
               	mov	x24, x19
               	mov	x22, #0x1a              // =26
               	mov	x0, x23
               	mov	x3, x21
               	mov	x2, x22
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	sub	x0, x0, x20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x22, #0x2               // =2
               	str	w22, [x20]
               	mov	x0, x22
               	bl	<addr>
               	mov	x26, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x176
               	mov	x24, x19
               	mov	x20, #0x21              // =33
               	mov	x0, x26
               	mov	x3, x22
               	mov	x2, x20
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x23, #0x1               // =1
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	mul	x0, x0, x23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x20, #0x3               // =3
               	str	w20, [x25]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x18c
               	mov	x25, x19
               	mov	x23, #0x29              // =41
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x23
               	mov	x1, x25
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
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	mov	x0, #0xc350             // =50000
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mul	x0, x0, x0
               	sxtw	x20, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x23, #0x4               // =4
               	str	w23, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a2
               	mov	x21, x19
               	mov	x26, #0x31              // =49
               	mov	x0, x25
               	mov	x3, x23
               	mov	x2, x26
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xf900            // =63744
               	movk	x17, #0x9502, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x24, #0x1               // =1
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	add	x0, x0, x24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x26, #0x5               // =5
               	str	w26, [x22]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x22, x19
               	mov	x24, #0x3e              // =62
               	mov	x0, x21
               	mov	x3, x26
               	mov	x2, x24
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x24, #0x64              // =100
               	str	w24, [x20]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1ce
               	mov	x20, x19
               	mov	x25, #0x4b              // =75
               	mov	x0, x22
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x26, x23
               	cset	x20, lt
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x25, #0x65              // =101
               	str	w25, [x23]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1e4
               	mov	x23, x19
               	mov	x20, #0x54              // =84
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x20
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x21, w24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x27, x17
               	eor	x21, x21, x26
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x0, x19
               	ldrsw	x21, [x0]
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x20, #0x66              // =102
               	str	w20, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1fa
               	mov	x26, x19
               	mov	x21, #0x5d              // =93
               	mov	x0, x23
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x210
               	mov	x25, x19
               	mov	x0, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	ldrsw	x0, [x25]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
