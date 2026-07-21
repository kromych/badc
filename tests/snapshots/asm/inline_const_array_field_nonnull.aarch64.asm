
inline_const_array_field_nonnull.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	add	x1, x1, #0x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0, #0x28]
               	add	x1, x1, x2
               	add	x0, x1, #0x3
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sxtw	x0, w0
               	ret
