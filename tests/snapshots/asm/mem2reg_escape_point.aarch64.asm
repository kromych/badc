
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
               	ret

<noise>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x10]
               	sub	x3, x29, #0x10
               	mov	x1, #0xf                // =15
               	str	w1, [x3]
               	ldursw	x1, [x29, #-0x10]
               	sub	x1, x1, #0xa
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x1, x0
               	ldursw	x4, [x29, #-0x10]
               	add	x2, x2, x4
               	cbnz	w0, <addr>
               	mov	x1, x3
               	ldrsw	x4, [x1]
               	add	x4, x4, #0x1
               	str	w4, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	w2, #0x21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	sub	x0, x0, #0xa
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x18]
               	bl	<addr>
               	stur	w0, [x29, #-0x18]
               	sub	x0, x0, #0xa
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
