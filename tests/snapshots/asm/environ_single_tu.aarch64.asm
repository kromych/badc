
environ_single_tu.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x2, [x0]
               	cbz	x2, <addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x8
               	ldr	x2, [x0]
               	cbnz	x2, <addr>
               	cmp	w1, #0x0
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, gt
               	ldp	x29, x30, [sp], #0x10
               	ret
