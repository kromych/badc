
double_pointers.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x2a               // =42
               	str	w1, [x0]
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x4                // =4
               	str	x1, [sp, #0x8]
               	bl	<addr>
               	ldr	x1, [sp, #0x8]
               	str	x0, [x1]
               	mov	x2, #0x7b               // =123
               	str	w2, [x0]
               	ldr	x0, [x1]
               	ldrsw	x1, [x0]
               	cmp	w1, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
