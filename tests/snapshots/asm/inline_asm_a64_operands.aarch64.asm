
inline_asm_a64_operands.aarch64:	file format elf64-littleaarch64

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

<compute>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	add	x0, x1, x2
               	str	x0, [sp]
               	ldr	x0, [sp]
               	lsl	x0, x0, #1
               	mov	x1, x0
               	mrs	x0, CNTVCT_EL0
               	cbz	x0, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x14              // =20
               	str	x16, [sp]
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	add	x0, x1, x2
               	str	x0, [sp]
               	ldr	x0, [sp]
               	lsl	x0, x0, #1
               	mov	x1, x0
               	mrs	x0, CNTVCT_EL0
               	cbz	x0, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
