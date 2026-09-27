
typeof_redeclaration_after_multidim_array.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x7                // =7
               	str	x0, [x2, #0x7f8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x7, #0x8                // =8
               	mov	x0, #0x9                // =9
               	str	x0, [x3, #0xf8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x5                // =5
               	str	w0, [x4, #0x2c]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x6, #0x6                // =6
               	str	w6, [x5, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w7, [x1, #0x10]
               	ldr	x2, [x2, #0x7f8]
               	cmp	x2, #0x7
               	b.ne	<addr>
               	ldr	x2, [x3, #0xf8]
               	cmp	x2, #0x9
               	b.ne	<addr>
               	ldrsw	x2, [x4, #0x2c]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	ret
               	ldrsw	x0, [x5, #0x10]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x10]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	add	x0, x1, #0x10
               	sub	x0, x0, x1
               	asr	x1, x0, #63
               	lsr	x1, x1, #62
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, x6
               	ret
               	mov	x0, #0x0                // =0
               	ret
