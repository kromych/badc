
unroll_const_trip_index_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<bank_init>:
               	mov	x3, #0x1                // =1
               	str	x1, [x0, #0x20]
               	str	x3, [x0]
               	str	xzr, [x0, #0x28]
               	mov	x3, #0x100000001        // =4294967297
               	str	x1, [x0, #0x50]
               	str	x3, [x0, #0x30]
               	str	xzr, [x0, #0x58]
               	mov	x3, #0x1                // =1
               	movk	x3, #0x2, lsl #32
               	str	x1, [x0, #0x80]
               	str	x3, [x0, #0x60]
               	str	xzr, [x0, #0x88]
               	mov	x3, #0x1                // =1
               	movk	x3, #0x3, lsl #32
               	str	x1, [x0, #0xb0]
               	str	x3, [x0, #0x90]
               	str	xzr, [x0, #0xb8]
               	mov	x3, #0x1                // =1
               	movk	x3, #0x4, lsl #32
               	str	x1, [x0, #0xe0]
               	str	x3, [x0, #0xc0]
               	str	xzr, [x0, #0xe8]
               	mov	x3, #0x1                // =1
               	movk	x3, #0x5, lsl #32
               	str	x1, [x0, #0x110]
               	str	x3, [x0, #0xf0]
               	str	xzr, [x0, #0x118]
               	mov	x3, #0x1                // =1
               	movk	x3, #0x6, lsl #32
               	str	x1, [x0, #0x140]
               	str	x3, [x0, #0x120]
               	str	xzr, [x0, #0x148]
               	mov	x3, #0x1                // =1
               	movk	x3, #0x7, lsl #32
               	str	x1, [x0, #0x170]
               	str	x3, [x0, #0x150]
               	str	xzr, [x0, #0x178]
               	mov	x2, #0x2                // =2
               	movk	x2, #0x20, lsl #32
               	str	x1, [x0, #0x1a0]
               	str	x2, [x0, #0x180]
               	str	xzr, [x0, #0x1a8]
               	mov	x3, #0xb00              // =2816
               	str	x3, [x0, #0x190]
               	mov	x3, #0x2                // =2
               	movk	x3, #0x21, lsl #32
               	str	x1, [x0, #0x1d0]
               	str	x3, [x0, #0x1b0]
               	str	xzr, [x0, #0x1d8]
               	mov	x3, #0x1600             // =5632
               	str	x3, [x0, #0x1c0]
               	mov	x3, #0x2                // =2
               	movk	x3, #0x22, lsl #32
               	str	x1, [x0, #0x200]
               	str	x3, [x0, #0x1e0]
               	str	xzr, [x0, #0x208]
               	mov	x1, #0x2100             // =8448
               	str	x1, [x0, #0x1f0]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x30               // =48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mul	x2, x0, x3
               	add	x1, x20, x2
               	ldr	w5, [x1]
               	cmp	w5, #0x1
               	b.ne	<addr>
               	ldr	x5, [x1, #0x20]
               	cmp	x5, x21
               	b.ne	<addr>
               	ldr	w1, [x1, #0x4]
               	cmp	w1, w0
               	b.ne	<addr>
               	add	x1, x4, x2
               	ldr	x1, [x1, #0x28]
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x5, #0x30               // =48
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	add	x3, x1, #0x180
               	mov	x2, #0x0                // =0
               	mul	x4, x0, x5
               	add	x1, x3, x4
               	ldr	w8, [x1]
               	cmp	w8, #0x2
               	b.ne	<addr>
               	ldr	x8, [x1, #0x20]
               	cmp	x8, x7
               	b.ne	<addr>
               	ldr	w8, [x1, #0x4]
               	add	x9, x0, #0x20
               	cmp	w8, w9
               	b.ne	<addr>
               	ldr	x8, [x1, #0x28]
               	cbnz	x8, <addr>
               	ldr	x1, [x1, #0x10]
               	ldrsw	x8, [x6, x0, lsl #2]
               	lsl	x8, x8, #8
               	cmp	x1, x8
               	b.ne	<addr>
               	add	x1, x3, x4
               	ldr	x1, [x1, #0x10]
               	add	x2, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x17, #0x4200            // =16896
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	ldrsw	x4, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, w4
               	b.ge	<addr>
               	ldrsw	x5, [x3, x0, lsl #2]
               	add	x1, x1, x5, lsl #8
               	add	x0, x0, #0x1
               	cmp	w0, w4
               	b.lt	<addr>
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
