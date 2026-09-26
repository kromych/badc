
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
               	ret

<partition>:
               	sxtw	x1, w1
               	ldrsw	x4, [x0, w2, sxtw #2]
               	sub	x3, x1, #0x1
               	cmp	w1, w2
               	b.ge	<addr>
               	ldrsw	x5, [x0, x1, lsl #2]
               	cmp	w5, w4
               	b.gt	<addr>
               	add	x3, x3, #0x1
               	ldrsw	x5, [x0, w3, sxtw #2]
               	ldrsw	x6, [x0, x1, lsl #2]
               	str	w6, [x0, w3, sxtw #2]
               	str	w5, [x0, x1, lsl #2]
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	add	x1, x3, #0x1
               	ldrsw	x3, [x0, w1, sxtw #2]
               	ldrsw	x4, [x0, w2, sxtw #2]
               	str	w4, [x0, w1, sxtw #2]
               	str	w3, [x0, w2, sxtw #2]
               	mov	x0, x1
               	ret

<quicksort>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x2
               	sxtw	x0, w1
               	cmp	w0, w21
               	b.ge	<addr>
               	ldrsw	x2, [x20, w21, sxtw #2]
               	sub	x3, x0, #0x1
               	mov	x1, x0
               	cmp	w1, w21
               	b.ge	<addr>
               	ldrsw	x4, [x20, x1, lsl #2]
               	cmp	w4, w2
               	b.gt	<addr>
               	add	x3, x3, #0x1
               	ldrsw	x4, [x20, w3, sxtw #2]
               	ldrsw	x5, [x20, x1, lsl #2]
               	str	w5, [x20, w3, sxtw #2]
               	str	w4, [x20, x1, lsl #2]
               	add	x1, x1, #0x1
               	cmp	w1, w21
               	b.lt	<addr>
               	add	x22, x3, #0x1
               	ldrsw	x1, [x20, w22, sxtw #2]
               	ldrsw	x2, [x20, w21, sxtw #2]
               	str	w2, [x20, w22, sxtw #2]
               	str	w1, [x20, w21, sxtw #2]
               	sub	x2, x22, #0x1
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x22, #0x1
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
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
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrsw	x0, [x20, #0x4]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrsw	x0, [x20, #0x8]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrsw	x0, [x20, #0xc]
               	cmp	w0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrsw	x0, [x20, #0x10]
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
