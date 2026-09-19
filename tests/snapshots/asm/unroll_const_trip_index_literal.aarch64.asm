
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
               	mov	x2, #0x22               // =34
               	str	w2, [x3, #0x4]
               	str	x4, [x3, #0x28]
               	add	x0, x0, #0x180
               	add	x0, x0, #0x60
               	mov	x1, #0x2100             // =8448
               	str	x1, [x0, #0x10]
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
               	mov	x4, #0x30               // =48
               	mov	x0, x21
               	cmp	w0, #0x8
               	b.ge	<addr>
               	mul	x2, x0, x4
               	add	x1, x20, x2
               	ldr	w3, [x1]
               	eor	x3, x3, #0x1
               	cbnz	w3, <addr>
               	ldr	x3, [x1, #0x20]
               	cmp	x3, x22
               	b.ne	<addr>
               	ldr	w3, [x1, #0x4]
               	cmp	w3, w0
               	b.ne	<addr>
               	ldr	x1, [x1, #0x28]
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x6, #0x30               // =48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x3
               	b.ge	<addr>
               	add	x2, x20, #0x180
               	mul	x3, x0, x6
               	add	x1, x2, x3
               	ldr	w4, [x1]
               	eor	x4, x4, #0x2
               	cbnz	w4, <addr>
               	ldr	x4, [x1, #0x20]
               	cmp	x4, x22
               	b.ne	<addr>
               	ldr	w7, [x1, #0x4]
               	add	x4, x0, #0x20
               	cmp	w7, w4
               	b.ne	<addr>
               	ldr	x4, [x1, #0x28]
               	cbnz	x4, <addr>
               	ldr	x4, [x1, #0x10]
               	ldrsw	x7, [x5, x0, lsl #2]
               	lsl	x7, x7, #8
               	cmp	x4, x7
               	b.ne	<addr>
               	ldr	x1, [x1, #0x10]
               	add	x21, x21, x1
               	add	x0, x0, #0x1
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
               	cmp	x1, x21
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
