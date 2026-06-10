
c99_arith_common_width.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x108
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
               	add	x2, x2, #0x120
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x126
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x12d
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	add	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x20, #0x1               // =1
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x140
               	mov	x2, #0x1a               // =26
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x1                // =1
               	sub	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x20, #0x2               // =2
               	str	w20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x156
               	mov	x2, #0x21               // =33
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x1                // =1
               	mul	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x20, #0x3               // =3
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x16c
               	mov	x2, #0x29               // =41
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xc350             // =50000
               	mul	x0, x0, x0
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x20, #0x4               // =4
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x182
               	mov	x2, #0x31               // =49
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x17, #0xf900            // =63744
               	movk	x17, #0x9502, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x1                // =1
               	add	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x20, #0x5               // =5
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x198
               	mov	x2, #0x3e               // =62
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x20, #0x64              // =100
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1ae
               	mov	x2, #0x4b               // =75
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	cmp	x0, x1
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x20, #0x65              // =101
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1c4
               	mov	x2, #0x54               // =84
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	eor	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x20, #0x66              // =102
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1da
               	mov	x2, #0x5d               // =93
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1f0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	ldrsw	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
