
inline_asm_reg_var_inout.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x28
               	str	x16, [sp]
               	mov	x16, #0x4               // =4
               	str	x16, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	add	x0, x0, #0x1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	sub	x16, x29, #0x18
               	str	x16, [sp, #0x8]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x18]
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x20]
               	mov	x16, #0x2               // =2
               	str	x16, [sp, #0x28]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x30]
               	mov	x16, #0x4               // =4
               	str	x16, [sp, #0x38]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x40]
               	mov	x16, #0x6               // =6
               	str	x16, [sp, #0x48]
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
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
