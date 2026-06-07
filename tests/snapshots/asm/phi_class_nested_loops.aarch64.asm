
phi_class_nested_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	sxtw	x3, w1
               	cmp	x3, x0
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	mov	x4, #0x0                // =0
               	mov	x3, x4
               	b	<addr>
               	sxtw	x0, w2
               	ret
               	sxtw	x5, w3
               	cmp	x5, x0
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x3, w3
               	add	x3, x3, #0x1
               	b	<addr>
               	sxtw	x4, w4
               	add	x4, x4, #0x1
               	sxtw	x4, w4
               	b	<addr>
               	sxtw	x2, w2
               	sxtw	x3, w4
               	add	x2, x2, x3
               	sxtw	x2, w2
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
