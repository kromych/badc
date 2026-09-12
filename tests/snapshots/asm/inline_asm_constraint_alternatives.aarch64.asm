
inline_asm_constraint_alternatives.aarch64:	file format elf64-littleaarch64

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
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x14              // =20
               	str	x16, [sp, #0x8]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	add	x0, x1, x2
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x19
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x8]
               	mov	x16, #0x4               // =4
               	str	x16, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	add	x0, x1, x2
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	add	x0, x1, #0x7
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0x8]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x20              // =32
               	str	x16, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x1, [sp, #0x8]
               	add	x0, x0, x1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
