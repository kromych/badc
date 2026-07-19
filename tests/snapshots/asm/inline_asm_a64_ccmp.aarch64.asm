
inline_asm_a64_ccmp.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x3                // =3
               	mov	x1, #0x5                // =5
               	mov	x2, #0x28               // =40
               	stur	x2, [x29, #-0x18]
               	sub	x2, x29, #0x18
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	cmp	x1, #0x3
               	ccmp	x2, #0x5, #0x0, eq
               	cinc	x0, x0, eq
               	cinc	x0, x0, eq
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	add	sp, sp, #0x30
               	ldur	x0, [x29, #-0x18]
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
