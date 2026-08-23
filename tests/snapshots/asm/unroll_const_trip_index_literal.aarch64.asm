
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
               	mov	x2, x1
               	add	x4, x0, #0x0
               	mov	x1, #0x1                // =1
               	str	w1, [x4]
               	str	x2, [x4, #0x20]
               	mov	x3, #0x0                // =0
               	str	w3, [x4, #0x4]
               	str	x3, [x4, #0x28]
               	str	w1, [x0, #0x30]
               	add	x4, x0, #0x30
               	str	x2, [x4, #0x20]
               	str	w1, [x4, #0x4]
               	str	x3, [x4, #0x28]
               	str	w1, [x0, #0x60]
               	add	x4, x0, #0x60
               	str	x2, [x4, #0x20]
               	mov	x5, #0x2                // =2
               	str	w5, [x4, #0x4]
               	str	x3, [x4, #0x28]
               	str	w1, [x0, #0x90]
               	add	x4, x0, #0x90
               	str	x2, [x4, #0x20]
               	mov	x6, #0x3                // =3
               	str	w6, [x4, #0x4]
               	str	x3, [x4, #0x28]
               	str	w1, [x0, #0xc0]
               	add	x4, x0, #0xc0
               	str	x2, [x4, #0x20]
               	mov	x6, #0x4                // =4
               	str	w6, [x4, #0x4]
               	str	x3, [x4, #0x28]
               	str	w1, [x0, #0xf0]
               	add	x4, x0, #0xf0
               	str	x2, [x4, #0x20]
               	mov	x6, #0x5                // =5
               	str	w6, [x4, #0x4]
               	str	x3, [x4, #0x28]
               	str	w1, [x0, #0x120]
               	add	x4, x0, #0x120
               	str	x2, [x4, #0x20]
               	mov	x6, #0x6                // =6
               	str	w6, [x4, #0x4]
               	str	x3, [x4, #0x28]
               	str	w1, [x0, #0x150]
               	add	x1, x0, #0x150
               	str	x2, [x1, #0x20]
               	mov	x4, #0x7                // =7
               	str	w4, [x1, #0x4]
               	str	x3, [x1, #0x28]
               	add	x1, x0, #0x180
               	add	x3, x1, #0x0
               	str	w5, [x3]
               	str	x2, [x3, #0x20]
               	mov	x4, #0x20               // =32
               	str	w4, [x3, #0x4]
               	mov	x4, #0x0                // =0
               	str	x4, [x3, #0x28]
               	mov	x6, #0xb00              // =2816
               	str	x6, [x3, #0x10]
               	str	w5, [x1, #0x30]
               	add	x3, x1, #0x30
               	str	x2, [x3, #0x20]
               	mov	x5, #0x21               // =33
               	str	w5, [x3, #0x4]
               	str	x4, [x3, #0x28]
               	mov	x5, #0x1600             // =5632
               	str	x5, [x3, #0x10]
               	mov	x3, #0x2                // =2
               	str	w3, [x1, #0x60]
               	add	x3, x1, #0x60
               	str	x2, [x3, #0x20]
               	mov	x1, #0x22               // =34
               	str	w1, [x3, #0x4]
               	add	x2, x0, #0x180
               	add	x1, x2, #0x60
               	str	x4, [x1, #0x28]
               	mov	x0, #0x2100             // =8448
               	str	x0, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0x0               // =0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x6, #0x1                // =1
               	mov	x7, #0x30               // =48
               	mov	x0, x21
               	b	<addr>
               	sxtw	x2, w0
               	mul	x3, x2, x7
               	add	x1, x20, x3
               	ldr	w4, [x1]
               	eor	x4, x4, x6
               	mov	w5, w4
               	cmp	w5, #0x0
               	cset	x4, ne
               	cbnz	x5, <addr>
               	ldr	x4, [x1, #0x20]
               	cmp	x4, x22
               	cset	x4, ne
               	cbnz	x4, <addr>
               	ldr	w4, [x1, #0x4]
               	mov	w5, w2
               	cmp	w4, w5
               	cset	x4, ne
               	cbnz	x4, <addr>
               	ldr	x1, [x1, #0x28]
               	cmp	x1, #0x0
               	cset	x4, ne
               	cbz	x4, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x8, #0x2                // =2
               	mov	x9, #0x30               // =48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	b	<addr>
               	add	x3, x20, #0x180
               	sxtw	x2, w0
               	mul	x4, x2, x9
               	add	x1, x3, x4
               	ldr	w5, [x1]
               	eor	x5, x5, x8
               	mov	w7, w5
               	cmp	w7, #0x0
               	cset	x5, ne
               	cbnz	x7, <addr>
               	ldr	x5, [x1, #0x20]
               	cmp	x5, x22
               	cset	x5, ne
               	cbnz	x5, <addr>
               	ldr	w7, [x1, #0x4]
               	add	x5, x2, #0x20
               	mov	w5, w5
               	cmp	w7, w5
               	b.ne	<addr>
               	ldr	x5, [x1, #0x28]
               	cbnz	x5, <addr>
               	ldr	x5, [x1, #0x10]
               	ldrsw	x7, [x6, x2, lsl #2]
               	lsl	x7, x7, #8
               	cmp	x5, x7
               	b.ne	<addr>
               	ldr	x1, [x1, #0x10]
               	add	x21, x21, x1
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x17, #0x4200            // =16896
               	cmp	x21, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldrsw	x5, [x3, x1, lsl #2]
               	lsl	x5, x5, #8
               	add	x2, x2, x5
               	add	x0, x1, #0x1
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	b.lt	<addr>
               	cmp	x2, x21
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
