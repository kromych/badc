
typedef_array_outer_dim.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	sxtw	x3, w1
               	lsl	x5, x3, #7
               	add	x5, x0, x5
               	sxtw	x6, w4
               	lsl	x3, x3, #4
               	add	x3, x3, x6
               	sxtw	x3, w3
               	str	x3, [x5, x6, lsl #3]
               	sxtw	x3, w1
               	lsl	x3, x3, #7
               	add	x3, x0, x3
               	sxtw	x5, w4
               	ldr	x3, [x3, x5, lsl #3]
               	add	x2, x2, x3
               	sxtw	x3, w4
               	add	x4, x3, #0x1
               	sxtw	x3, w4
               	cmp	x3, #0x10
               	b.lt	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	sxtw	x3, w1
               	cmp	x3, #0x4
               	b.lt	<addr>
               	mov	x0, x2
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	str	x20, [sp]
               	mov	x1, #0x0                // =0
               	mov	x20, x1
               	b	<addr>
               	sxtw	x0, w1
               	add	x20, x20, x0
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x200
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	ldr	x0, [x0, #0x1f8]
               	cmp	x0, #0x3f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	ldr	x0, [x0, #0xb8]
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
