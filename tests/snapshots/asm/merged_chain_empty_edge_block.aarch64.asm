
merged_chain_empty_edge_block.aarch64:	file format elf64-littleaarch64

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

<steps>:
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x9                // =9
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cmp	x0, #0x0
               	csel	x0, x1, x2, ne
               	ret
