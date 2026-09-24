
inline_asm_a64_bitfield.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x2, #0x0                // =0
               	mov	x16, #0x2a00            // =10752
               	str	x16, [sp]
               	ldr	x1, [sp]
               	ubfx	x0, x1, #8, #8
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	bfxil	x0, x1, #0, #8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
