
compound_literal_file_scope.aarch64:	file format elf64-littleaarch64

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
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x1, [x0]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x40]
               	ldrsw	x2, [x0]
               	cbz	w2, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x2, [x0, #0x8]
               	ldrb	w2, [x2]
               	cmp	w2, #0x72
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	ldrb	w0, [x0, #0x1]
               	cmp	w0, #0x6f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x0, [x1, #0x40]
               	ldr	x0, [x0, #0x10]
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
