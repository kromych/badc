
ptr_to_array_typedef.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x18]
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0, #0x18]
               	cmp	x1, #0x2
               	b.ne	<addr>
               	ldr	x1, [x0, #0x18]
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x0, [x0, #0x18]
               	add	x0, x0, #0x1e
               	add	x0, x0, #0x11
               	sub	x0, x0, #0x7
               	ret
