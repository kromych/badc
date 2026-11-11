
file_scope_array_compound_literal_address.aarch64:	file format elf64-littleaarch64

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
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x79
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x3]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x79
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x7a
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrb	w1, [x1, #0x1]
               	cmp	w1, #0x69
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x90]
               	ldrb	w2, [x1, #0x1]
               	cmp	w2, #0x62
               	b.ne	<addr>
               	ldrb	w1, [x1, #0x2]
               	cbnz	w1, <addr>
               	ldr	x0, [x0, #0x90]
               	ldrb	w0, [x0, #0x3]
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0, #0x7]
               	cmp	w0, #0x68
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x7a
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w1, [x0]
               	cmp	w1, #0x61
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x1]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x64
               	b.ne	<addr>
               	sub	x0, x0, #0x4
               	ldrb	w0, [x0]
               	cmp	w0, #0x61
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w1, [x0, #0x7]
               	cmp	w1, #0x66
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x9]
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	w1, [x0, #0x4]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	ldr	w0, [x0, #0x8]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x1, [x0]
               	ldr	w1, [x1]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	sub	x0, x0, #0x8
               	ldr	x0, [x0]
               	ldr	w0, [x0]
               	cmp	w0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	ldrsw	x0, [x0, #0x148]
               	cmp	w0, #0x4
               	csel	x0, x1, x2, eq
               	ret
