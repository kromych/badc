
slot_coalesce_declared.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	x2, x0, x0, lsl #1
               	add	x3, x2, #0x7
               	add	x1, x1, x3
               	add	x3, x0, x0
               	add	x3, x3, x0
               	sub	x2, x3, x2
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x32
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	add	x3, x0, x0, lsl #1
               	add	x3, x3, #0x7
               	add	x2, x2, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x32
               	b.lt	<addr>
               	cmp	x1, x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
