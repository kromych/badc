
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
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	str	x1, [x0, #0x20]
               	str	wzr, [x0, #0x4]
               	str	xzr, [x0, #0x28]
               	str	w2, [x0, #0x30]
               	add	x4, x0, #0x30
               	str	x1, [x4, #0x20]
               	str	w2, [x4, #0x4]
               	str	xzr, [x4, #0x28]
               	str	w2, [x0, #0x60]
               	add	x4, x0, #0x60
               	str	x1, [x4, #0x20]
               	mov	x5, #0x2                // =2
               	str	w5, [x4, #0x4]
               	str	xzr, [x4, #0x28]
               	str	w2, [x0, #0x90]
               	add	x4, x0, #0x90
               	str	x1, [x4, #0x20]
               	mov	x6, #0x3                // =3
               	str	w6, [x4, #0x4]
               	str	xzr, [x4, #0x28]
               	str	w2, [x0, #0xc0]
               	add	x4, x0, #0xc0
               	str	x1, [x4, #0x20]
               	mov	x6, #0x4                // =4
               	str	w6, [x4, #0x4]
               	str	xzr, [x4, #0x28]
               	str	w2, [x0, #0xf0]
               	add	x4, x0, #0xf0
               	str	x1, [x4, #0x20]
               	mov	x6, #0x5                // =5
               	str	w6, [x4, #0x4]
               	str	xzr, [x4, #0x28]
               	str	w2, [x0, #0x120]
               	add	x4, x0, #0x120
               	str	x1, [x4, #0x20]
               	mov	x6, #0x6                // =6
               	str	w6, [x4, #0x4]
               	str	xzr, [x4, #0x28]
               	str	w2, [x0, #0x150]
               	add	x2, x0, #0x150
               	str	x1, [x2, #0x20]
               	mov	x4, #0x7                // =7
               	str	w4, [x2, #0x4]
               	str	xzr, [x2, #0x28]
               	add	x0, x0, #0x180
               	str	w5, [x0]
               	str	x1, [x0, #0x20]
               	mov	x2, #0x20               // =32
               	str	w2, [x0, #0x4]
               	str	xzr, [x0, #0x28]
               	mov	x2, #0xb00              // =2816
               	str	x2, [x0, #0x10]
               	str	w5, [x0, #0x30]
               	add	x2, x0, #0x30
               	str	x1, [x2, #0x20]
               	mov	x4, #0x21               // =33
               	str	w4, [x2, #0x4]
               	str	xzr, [x2, #0x28]
               	mov	x4, #0x1600             // =5632
               	str	x4, [x2, #0x10]
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x60]
               	add	x0, x0, #0x60
               	str	x1, [x0, #0x20]
               	mov	x1, #0x22               // =34
               	str	w1, [x0, #0x4]
               	str	xzr, [x0, #0x28]
               	mov	x1, #0x2100             // =8448
               	str	x1, [x0, #0x10]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x30               // =48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mul	x2, x0, x3
               	add	x1, x21, x2
               	ldr	w5, [x1]
               	eor	x5, x5, #0x1
               	cbnz	w5, <addr>
               	ldr	x5, [x1, #0x20]
               	cmp	x5, x22
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
               	mov	x4, #0x30               // =48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	add	x2, x6, #0x180
               	mul	x3, x0, x4
               	add	x1, x2, x3
               	ldr	w8, [x1]
               	eor	x8, x8, #0x2
               	cbnz	w8, <addr>
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
               	ldrsw	x8, [x5, x0, lsl #2]
               	lsl	x8, x8, #8
               	cmp	x1, x8
               	b.ne	<addr>
               	add	x1, x2, x3
               	ldr	x1, [x1, #0x10]
               	add	x20, x20, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x17, #0x4200            // =16896
               	cmp	x20, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x4, [x3]
               	cmp	w0, w4
               	b.ge	<addr>
               	ldrsw	x4, [x2, x0, lsl #2]
               	lsl	x4, x4, #8
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	ldrsw	x4, [x3]
               	cmp	w0, w4
               	b.lt	<addr>
               	cmp	x1, x20
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
