
const_struct_array_inline_accessor.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x8
               	mov	x1, #0x0                // =0
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x8
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, x1
               	mov	x0, x1
               	ret
