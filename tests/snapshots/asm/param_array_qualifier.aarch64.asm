
param_array_qualifier.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<sum_qualified>:
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<sum_volatile>:
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<first_row>:
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, #0xdc
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x28
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
