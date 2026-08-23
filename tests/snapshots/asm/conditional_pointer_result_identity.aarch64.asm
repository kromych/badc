
conditional_pointer_result_identity.aarch64:	file format elf64-littleaarch64

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
               	add	x1, x0, #0x3
               	sub	x1, x1, x0
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x1, #0x2a               // =42
               	str	w1, [x0]
               	sxtw	x0, w1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	mov	x0, #0x0                // =0
               	ret
