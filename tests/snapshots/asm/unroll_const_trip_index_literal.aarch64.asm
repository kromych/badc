
unroll_const_trip_index_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<bank_init>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x2, x0, #0x0
               	mov	x3, #0x1                // =1
               	str	w3, [x2]
               	add	x2, x0, #0x0
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0x0
               	mov	x3, #0x0                // =0
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x0
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x30]
               	add	x2, x0, #0x30
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0x30
               	mov	x3, #0x1                // =1
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x30
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x60]
               	add	x2, x0, #0x60
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0x60
               	mov	x3, #0x2                // =2
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x60
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x90]
               	add	x2, x0, #0x90
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0x90
               	mov	x3, #0x3                // =3
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x90
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0xc0]
               	add	x2, x0, #0xc0
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0xc0
               	mov	x3, #0x4                // =4
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0xc0
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0xf0]
               	add	x2, x0, #0xf0
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0xf0
               	mov	x3, #0x5                // =5
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0xf0
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x120]
               	add	x2, x0, #0x120
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0x120
               	mov	x3, #0x6                // =6
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x120
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x150]
               	add	x2, x0, #0x150
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0x150
               	mov	x3, #0x7                // =7
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x150
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x0
               	mov	x3, #0x2                // =2
               	str	w3, [x2]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x0
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x0
               	mov	x3, #0x20               // =32
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x0
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x0
               	mov	x3, #0xb00              // =2816
               	str	x3, [x2, #0x10]
               	add	x2, x0, #0x180
               	mov	x3, #0x2                // =2
               	str	w3, [x2, #0x30]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x30
               	str	x1, [x2, #0x20]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x30
               	mov	x3, #0x21               // =33
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x30
               	mov	x3, #0x0                // =0
               	str	x3, [x2, #0x28]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x30
               	mov	x3, #0x1600             // =5632
               	str	x3, [x2, #0x10]
               	add	x2, x0, #0x180
               	mov	x3, #0x2                // =2
               	str	w3, [x2, #0x60]
               	add	x2, x0, #0x180
               	add	x2, x2, #0x60
               	str	x1, [x2, #0x20]
               	add	x1, x0, #0x180
               	add	x1, x1, #0x60
               	mov	x2, #0x22               // =34
               	str	w2, [x1, #0x4]
               	add	x1, x0, #0x180
               	add	x1, x1, #0x60
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x28]
               	add	x0, x0, #0x180
               	add	x0, x0, #0x60
               	mov	x1, #0x2100             // =8448
               	str	x1, [x0, #0x10]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

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
               	mov	x0, x21
               	b	<addr>
               	mov	x17, #0x30              // =48
               	mul	x2, x1, x17
               	add	x2, x20, x2
               	ldr	w2, [x2]
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x17, #0x30              // =48
               	mul	x2, x1, x17
               	add	x2, x20, x2
               	ldr	x2, [x2, #0x20]
               	cmp	x2, x22
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x17, #0x30              // =48
               	mul	x2, x1, x17
               	add	x2, x20, x2
               	ldr	w2, [x2, #0x4]
               	mov	w3, w1
               	cmp	x2, x3
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x17, #0x30              // =48
               	mul	x2, x1, x17
               	add	x2, x20, x2
               	ldr	x2, [x2, #0x28]
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	add	x2, x20, #0x180
               	mov	x17, #0x30              // =48
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	ldr	w2, [x2]
               	mov	x17, #0x2               // =2
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x20, #0x180
               	mov	x17, #0x30              // =48
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	ldr	x2, [x2, #0x20]
               	cmp	x2, x22
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x20, #0x180
               	mov	x17, #0x30              // =48
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	ldr	w3, [x2, #0x4]
               	add	x2, x0, #0x20
               	sxtw	x2, w2
               	mov	w2, w2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x2, x20, #0x180
               	mov	x17, #0x30              // =48
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	ldr	x2, [x2, #0x28]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	add	x2, x20, #0x180
               	mov	x17, #0x30              // =48
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	ldr	x3, [x2, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, x0, lsl #2]
               	lsl	x2, x2, #8
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x2, x20, #0x180
               	mov	x17, #0x30              // =48
               	mul	x3, x0, x17
               	add	x2, x2, x3
               	ldr	x2, [x2, #0x10]
               	add	x21, x21, x2
               	b	<addr>
               	b	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	mov	x17, #0x4200            // =16896
               	cmp	x21, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x3, [x3, x1, lsl #2]
               	lsl	x3, x3, #8
               	add	x2, x2, x3
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x3, [x3]
               	cmp	x1, x3
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
               	b	<addr>
               	b	<addr>
