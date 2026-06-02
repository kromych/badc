
return_value_in_callee_saved.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ge	<addr>
               	ret
               	ret
               	sxtw	x15, w0
               	add	x15, x15, #0x1
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
