
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, #0x2                // =2
               	str	w2, [x3]
               	ldrsw	x0, [x0]
               	sxtw	x2, w2
               	add	x0, x0, x2
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, x1
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x2, x0
               	mov	x1, x0
               	ret
