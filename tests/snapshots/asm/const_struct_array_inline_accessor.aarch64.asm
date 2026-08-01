
const_struct_array_inline_accessor.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
