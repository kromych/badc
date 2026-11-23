
mem2reg_escape_point.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	mov	x0, #0x1e               // =30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x1, x0
               	b	<addr>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.ge	<addr>
               	ldursw	x3, [x29, #-0x8]
               	add	x2, x2, x3
               	cbnz	w0, <addr>
               	sub	x1, x29, #0x8
               	b	<addr>
               	cmp	w2, #0x21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
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
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	sub	x0, x0, #0xa
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
