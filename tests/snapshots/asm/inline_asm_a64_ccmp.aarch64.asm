
inline_asm_a64_ccmp.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x0, #0x28               // =40
               	str	x0, [sp]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x8]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	cmp	x1, #0x3
               	ccmp	x2, #0x5, #0x0, eq
               	cinc	x0, x0, eq
               	cinc	x0, x0, eq
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
