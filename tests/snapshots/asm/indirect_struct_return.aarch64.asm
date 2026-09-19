
indirect_struct_return.aarch64:	file format elf64-littleaarch64

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

<make>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	str	w1, [x0]
               	lsl	x1, x1, #1
               	str	w1, [x0, #0x4]
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x0, #0x3
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
