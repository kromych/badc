
inline_asm_section_label.aarch64:	file format elf64-littleaarch64

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
               	ldrb	w1, [x0]
               	cmp	w1, #0x74
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x61
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	cmp	w1, #0x67
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w1, [x0, #0x3]
               	cbz	w1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x1, x0
               	cmp	x2, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x1, [x1]
               	cmp	w1, #0x63
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x0, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x2a               // =42
               	ret
