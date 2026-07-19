
inline_asm_a64_bitfield.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, #0x2a00             // =10752
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x18]
               	sub	x0, x29, #0x10
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	ubfx	x0, x1, #8, #8
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	ldur	x1, [x29, #-0x10]
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x1, [sp, #0x8]
               	bfxil	x0, x1, #0, #8
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldur	x0, [x29, #-0x18]
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
