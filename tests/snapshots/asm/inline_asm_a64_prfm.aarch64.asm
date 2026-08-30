
inline_asm_a64_prfm.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	mov	x1, #0x8                // =8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	prfm	pldl1keep, [x0]
               	ldr	x0, [sp, #0x8]
               	sub	x0, x29, #0x40
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	prfm	pstl1strm, [x0, #0x10]
               	ldr	x0, [sp, #0x8]
               	sub	x0, x29, #0x40
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	prfm	pldl2keep, [x0, x1]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
