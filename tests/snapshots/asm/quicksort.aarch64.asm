
quicksort.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2c0              // =704
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrsw	x2, [x0]
               	ldrsw	x3, [x1]
               	str	w3, [x0]
               	str	w2, [x1]
               	mov	x0, #0x0                // =0
               	ret

<partition>:
               	mov	x3, x1
               	mov	x7, x2
               	sxtw	x3, w3
               	sxtw	x7, w7
               	ldrsw	x5, [x0, x7, lsl #2]
               	sub	x1, x3, #0x1
               	b	<addr>
               	ldrsw	x4, [x0, x2, lsl #2]
               	cmp	x4, x5
               	b.gt	<addr>
               	add	x1, x1, #0x1
               	sxtw	x4, w1
               	ldrsw	x6, [x0, x4, lsl #2]
               	ldrsw	x8, [x0, x2, lsl #2]
               	str	w8, [x0, x4, lsl #2]
               	str	w6, [x0, x2, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, x7
               	b.lt	<addr>
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	ldrsw	x3, [x0, x2, lsl #2]
               	ldrsw	x4, [x0, x7, lsl #2]
               	str	w4, [x0, x2, lsl #2]
               	str	w3, [x0, x7, lsl #2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<quicksort>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x22, x2
               	mov	x8, x1
               	sxtw	x8, w8
               	sxtw	x22, w22
               	cmp	x8, x22
               	b.ge	<addr>
               	sxtw	x2, w8
               	sxtw	x6, w22
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x21, w1
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	mov	x1, x8
               	bl	<addr>
               	add	x1, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x20, x0
               	mov	x1, #0x0                // =0
               	mov	x0, #0xc                // =12
               	str	w0, [x20]
               	mov	x2, #0x4                // =4
               	mov	x0, #0x7                // =7
               	str	w0, [x20, #0x4]
               	mov	x0, #0xf                // =15
               	str	w0, [x20, #0x8]
               	mov	x0, #0x5                // =5
               	str	w0, [x20, #0xc]
               	mov	x0, #0xa                // =10
               	str	w0, [x20, #0x10]
               	mov	x0, x20
               	bl	<addr>
               	ldrsw	x0, [x20]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldrsw	x0, [x20, #0x4]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldrsw	x0, [x20, #0x8]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldrsw	x0, [x20, #0xc]
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldrsw	x0, [x20, #0x10]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
