
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
               	add	x0, x0, x1
               	str	x0, [sp]
               	ldr	x0, [sp]
               	lsl	x0, x0, #1
               	mrs	x1, CNTVCT_EL0
               	cbz	x1, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x14              // =20
               	mov	x17, #0x1               // =1
               	add	x0, x16, x17
               	str	x0, [sp]
               	ldr	x0, [sp]
               	lsl	x0, x0, #1
               	mrs	x1, CNTVCT_EL0
               	cbz	x1, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
