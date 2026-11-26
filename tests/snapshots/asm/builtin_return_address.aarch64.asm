
builtin_return_address.aarch64:	file format elf64-littleaarch64

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
               	ldr	x30, [x29, #0x8]
               	xpaclri
               	mov	x1, x30
               	str	x1, [x0, #0x20]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x0
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, ne
               	ldp	x29, x30, [sp], #0x10
               	ret
