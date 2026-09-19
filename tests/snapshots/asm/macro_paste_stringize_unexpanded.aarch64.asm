
macro_paste_stringize_unexpanded.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2                // =2
               	str	w3, [x2]
               	ldrsw	x1, [x1]
               	add	x1, x1, #0x2
               	cmp	w1, #0x3
               	b.eq	<addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
