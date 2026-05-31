
warn_unused_symbols.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400250 <.text+0x30>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w1
               	lsl	x14, x15, #1
               	sxtw	x14, w14
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x15, #0x5               // =5
               	sxtw	x14, w15
               	add	x15, x14, #0x1
               	sxtw	x15, w15
               	sxtw	x20, w15
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
