
block_scope_typedef_restores_the_outer_typedef.aarch64:	file format elf64-littleaarch64

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

<inc>:
               	add	x0, x0, #0x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x2
               	cset	x0, ne
               	lsl	x0, x0, #1
               	ldp	x29, x30, [sp], #0x10
               	ret
