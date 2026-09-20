
inline_asm_output_reg.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	stur	xzr, [x29, #-0x18]
               	sub	x16, x29, #0x18
               	str	x16, [sp]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	str	x1, [x0]
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	mov	x16, #0xa               // =10
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	add	x0, x1, #0x7
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x8]
               	mov	x16, #0x6               // =6
               	str	x16, [sp, #0x10]
               	ldr	x2, [sp, #0x10]
               	mov	x0, x2
               	mov	x1, x2
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
