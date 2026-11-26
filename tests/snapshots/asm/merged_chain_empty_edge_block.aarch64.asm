
merged_chain_empty_edge_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<steps>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x0, #0x0
               	mov	x16, #0x9               // =9
               	csel	x0, x16, xzr, ne
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x0, #0x0
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, ne
               	ret
