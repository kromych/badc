
string_subscript_const_init.aarch64:	file format elf64-littleaarch64

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

<f>:
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x68]
               	mov	x0, #0x0                // =0
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x38]
               	cmp	w0, #0x7a
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	ret

<main>:
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	ldrb	w1, [x1]
               	cmp	w1, #0x79
               	b.ne	<addr>
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x73
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	ldrb	w0, [x0]
               	cmp	w0, #0x79
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x60]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x20]
               	cmp	w0, #0x69
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x24]
               	cmp	w0, #0x6a
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w1, [x0]
               	cmp	w1, #0x61
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x38]
               	cmp	w0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
