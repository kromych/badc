
global_struct_return_indirect.aarch64:	file format elf64-littleaarch64

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
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x10]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x10]
               	add	x0, x1, x0
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
