
decl_specifier_order_const_after_type.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1                // =1
               	strb	w0, [x1, #0x30]
               	adrp	x1, <page>
               	strb	w0, [x1, #0x40]
               	adrp	x1, <page>
               	strb	w0, [x1, #0x50]
               	adrp	x1, <page>
               	strb	w0, [x1, #0x58]
               	adrp	x1, <page>
               	strb	w0, [x1, #0x60]
               	mov	x0, #0x0                // =0
               	ret
