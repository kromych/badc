
struct_array_init_from_lvalue.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x1, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sub	x3, x29, #0x30
               	stur	x2, [x29, #-0x30]
               	stur	w1, [x29, #-0x28]
               	stur	w0, [x29, #-0x24]
               	sub	x2, x29, #0x20
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	mov	x1, #0x1                // =1
               	mov	x4, #0x2                // =2
               	stur	x4, [x29, #-0x20]
               	stur	w1, [x29, #-0x18]
               	stur	w0, [x29, #-0x14]
               	add	x1, x2, #0x10
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	mov	x1, x0
               	add	x3, x2, x0, lsl #4
               	ldr	x3, [x3]
               	orr	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lo	<addr>
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
