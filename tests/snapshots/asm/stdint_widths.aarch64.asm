
stdint_widths.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x2a               // =42
               	stur	w0, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
