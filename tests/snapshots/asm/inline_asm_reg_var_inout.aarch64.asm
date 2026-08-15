
inline_asm_reg_var_inout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0x28
               	str	x0, [sp, #0x10]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	add	x0, x0, #0x1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	sub	x6, x29, #0x20
               	sub	x7, x29, #0x18
               	sub	x8, x29, #0x10
               	sub	x9, x29, #0x8
               	str	x0, [sp, #0x50]
               	str	x1, [sp, #0x58]
               	str	x2, [sp, #0x60]
               	str	x3, [sp, #0x68]
               	str	x4, [sp, #0x70]
               	str	x5, [sp, #0x78]
               	str	x6, [sp]
               	str	x7, [sp, #0x8]
               	str	x8, [sp, #0x10]
               	str	x9, [sp, #0x18]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	str	x2, [sp, #0x30]
               	str	x3, [sp, #0x38]
               	str	x4, [sp, #0x40]
               	str	x5, [sp, #0x48]
               	ldr	x0, [sp, #0x20]
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x30]
               	ldr	x3, [sp, #0x38]
               	ldr	x4, [sp, #0x40]
               	ldr	x5, [sp, #0x48]
               	add	x0, x0, x4
               	add	x1, x1, x5
               	add	x2, x2, #0x2
               	add	x3, x3, #0x3
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x16, [sp, #0x10]
               	str	x2, [x16]
               	ldr	x16, [sp, #0x18]
               	str	x3, [x16]
               	ldr	x0, [sp, #0x50]
               	ldr	x1, [sp, #0x58]
               	ldr	x2, [sp, #0x60]
               	ldr	x3, [sp, #0x68]
               	ldr	x4, [sp, #0x70]
               	ldr	x5, [sp, #0x78]
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	cmp	x0, #0x1a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
