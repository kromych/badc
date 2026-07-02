
data_reloc_one_past_end.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x1, x0
               	b.eq	<addr>
               	ldr	x0, [x1]
               	add	x2, x2, x0
               	add	x1, x1, #0x8
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
