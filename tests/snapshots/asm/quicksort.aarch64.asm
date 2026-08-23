
quicksort.aarch64:	file format elf64-littleaarch64

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

<swap>:
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
               	sxtw	x2, w3
               	ldrsw	x4, [x0, x2, lsl #2]
               	cmp	w4, w5
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
               	cmp	w3, w7
               	b.lt	<addr>
               	add	x3, x1, #0x1
               	sxtw	x2, w3
               	ldrsw	x4, [x0, x2, lsl #2]
               	ldrsw	x5, [x0, x7, lsl #2]
               	str	w5, [x0, x2, lsl #2]
               	str	w4, [x0, x7, lsl #2]
               	mov	x0, x2
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
               	cmp	w8, w22
               	b.ge	<addr>
               	sxtw	x1, w8
               	sxtw	x6, w22
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x1, #0x1
               	b	<addr>
               	sxtw	x2, w1
               	ldrsw	x3, [x20, x2, lsl #2]
               	cmp	w3, w4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x2, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x2, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x1, x2, #0x1
               	cmp	w1, w6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x21, w1
               	ldrsw	x2, [x20, x21, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x21, lsl #2]
               	str	w2, [x20, x6, lsl #2]
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
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x20, x0
               	mov	x21, #0x0               // =0
               	mov	x0, #0xc                // =12
               	str	w0, [x20]
               	mov	x22, #0x4               // =4
               	mov	x0, #0x7                // =7
               	str	w0, [x20, #0x4]
               	mov	x0, #0xf                // =15
               	str	w0, [x20, #0x8]
               	mov	x23, #0x5               // =5
               	str	w23, [x20, #0xc]
               	mov	x0, #0xa                // =10
               	str	w0, [x20, #0x10]
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	ldrsw	x0, [x20]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrsw	x0, [x20, #0x4]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrsw	x0, [x20, #0x8]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrsw	x0, [x20, #0xc]
               	cmp	w0, #0xc
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrsw	x0, [x20, #0x10]
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, x23
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
