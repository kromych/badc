
mem2reg_escape_point.aarch64:	file format elf64-littleaarch64

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

<bump>:
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x7
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<noise>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x10]
               	sub	x4, x29, #0x10
               	mov	x1, #0xf                // =15
               	str	w1, [x4]
               	ldursw	x1, [x29, #-0x10]
               	sub	x1, x1, #0xa
               	sxtw	x1, w1
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x1, x0
               	b	<addr>
               	ldursw	x3, [x29, #-0x10]
               	add	x2, x2, x3
               	cbnz	x0, <addr>
               	mov	x1, x4
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w2
               	cmp	w0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x20, #0xa               // =10
               	stur	w20, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	sub	x0, x0, #0xa
               	sxtw	x0, w0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	stur	w20, [x29, #-0x18]
               	mov	x0, x20
               	bl	<addr>
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	ldursw	x0, [x29, #-0x18]
               	sub	x0, x0, #0xa
               	sxtw	x0, w0
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
