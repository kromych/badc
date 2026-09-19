
block_scope_function_declaration.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x0
               	ldrb	w3, [x1]
               	cbz	x3, <addr>
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	add	x2, x2, #0x1
               	ldrb	w3, [x1]
               	cbnz	x3, <addr>
               	ldrb	w1, [x1]
               	ldrb	w2, [x2]
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret

<sum3>:
               	add	x0, x0, x1
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ret

<add>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<label>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret
