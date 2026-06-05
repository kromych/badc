
warn_unused_symbols.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	sxtw	x1, w1
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x5                // =5
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
