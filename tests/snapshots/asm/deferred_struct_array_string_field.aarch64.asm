
deferred_struct_array_string_field.aarch64:	file format elf64-littleaarch64

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

<check>:
               	mov	x4, x1
               	mov	x5, x2
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	ldrb	w2, [x4]
               	cmp	x1, x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldrb	w1, [x1]
               	ldrb	w2, [x5]
               	cmp	x1, x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x3, x4, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	add	x6, x4, x2
               	ldrb	w6, [x6]
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x3, x5, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	add	x4, x5, x2
               	ldrb	w4, [x4]
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	cmp	x1, #0x61
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldrb	w1, [x1]
               	cmp	x1, #0x62
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x2, #0x1                // =1
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	cmp	x1, #0x63
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldrb	w1, [x1]
               	cmp	x1, #0x64
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x10]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrb	w0, [x3]
               	cmp	x0, #0x65
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x4]
               	cmp	x0, #0x66
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x8, [x0]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrb	w0, [x3]
               	cmp	x0, #0x67
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x4]
               	cmp	x0, #0x68
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrb	w0, [x8, #0x7]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	w1, w0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w0, [x8, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	cmp	x1, #0x6a
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldrb	w1, [x1]
               	cmp	x1, #0x6b
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0xa
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x3, x4, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	add	x6, x4, x2
               	ldrb	w6, [x6]
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x3, x5, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	add	x4, x5, x2
               	ldrb	w4, [x4]
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x1, w0
               	add	x2, x5, x1
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	cbz	x2, <addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x7, x5, x1
               	ldrb	w7, [x7]
               	cmp	x2, x7
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x1, w0
               	add	x2, x6, x1
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x2, x4, x1
               	ldrb	w2, [x2]
               	cbz	x2, <addr>
               	add	x2, x4, x1
               	ldrb	w2, [x2]
               	add	x3, x6, x1
               	ldrb	w3, [x3]
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x1, w0
               	add	x2, x5, x1
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	cbz	x2, <addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x7, x5, x1
               	ldrb	w7, [x7]
               	cmp	x2, x7
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x1, w0
               	add	x2, x6, x1
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x2, x4, x1
               	ldrb	w2, [x2]
               	cbz	x2, <addr>
               	add	x2, x4, x1
               	ldrb	w2, [x2]
               	add	x3, x6, x1
               	ldrb	w3, [x3]
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x3, x4, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	add	x6, x4, x2
               	ldrb	w6, [x6]
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x3, x5, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	add	x4, x5, x2
               	ldrb	w4, [x4]
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x3, x4, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	add	x6, x4, x2
               	ldrb	w6, [x6]
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x3, x5, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	add	x4, x5, x2
               	ldrb	w4, [x4]
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
