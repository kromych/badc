
break_continue.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	sxtw	x2, w0
               	cmp	x2, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	b	<addr>
               	sxtw	x2, w0
               	cmp	x2, #0x5
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	ret
               	b	<addr>
               	sxtw	x2, w0
               	mov	x3, #0x2                // =2
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	sxtw	x2, w0
               	add	x1, x1, x2
               	sxtw	x1, w1
               	b	<addr>
