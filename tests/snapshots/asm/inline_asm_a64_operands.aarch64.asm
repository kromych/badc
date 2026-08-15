
inline_asm_a64_operands.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<compute>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x2, x29, #0x8
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	add	x0, x1, x2
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	lsl	x0, x0, #1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	sub	x0, x29, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	mrs	x0, CNTVCT_EL0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x14               // =20
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x10
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	add	x0, x1, x2
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	sub	x0, x29, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	lsl	x0, x0, #1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	mrs	x0, CNTVCT_EL0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	ldur	x0, [x29, #-0x10]
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
