
compound_literal_pointer_field.aarch64:	file format elf64-littleaarch64

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
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0, #0x18]
               	cmp	w1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x1, [x0, #0x20]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x28]
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	eor	x1, x1, #0x78
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
