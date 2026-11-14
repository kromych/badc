
typeof_operator.aarch64:	file format elf64-littleaarch64

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

<with_side_effect>:
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x20]
               	mov	x0, #0x7                // =7
               	ret

<main>:
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cbz	w0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
