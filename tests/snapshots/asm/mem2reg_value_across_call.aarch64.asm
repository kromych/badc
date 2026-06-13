
mem2reg_value_across_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x7
               	ret

<noise>:
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	ret

<g>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x22, #0x0               // =0
               	mov	x23, x22
               	cmp	x22, x20
               	b.ge	<addr>
               	mov	x0, x22
               	bl	<addr>
               	add	x23, x23, x0
               	mov	x9, x21
               	str	x22, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x23, x23, x0
               	add	x22, x22, #0x1
               	b	<addr>
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	ldp	x29, x30, [sp], #0x10
               	ret
