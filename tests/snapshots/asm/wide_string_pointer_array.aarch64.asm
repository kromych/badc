
wide_string_pointer_array.aarch64:	file format elf64-littleaarch64

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
               	ldr	w1, [x1]
               	cmp	w1, #0x4c
               	b.ne	<addr>
               	ldr	x1, [x0]
               	ldr	w1, [x1, #0x1c]
               	cmp	w1, #0x42
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0, #0x8]
               	ldr	w1, [x1, #0x1c]
               	cmp	w1, #0x46
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	ldr	w1, [x1, #0x20]
               	cmp	w1, #0x6c
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x1, [x0, #0x8]
               	ldr	w1, [x1, #0x30]
               	cmp	w1, #0x79
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x10]
               	ldr	w1, [x1]
               	cmp	w1, #0x43
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	ldr	w1, [x1, #0x4]
               	cmp	w1, #0x44
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldr	w1, [x1, #0x8]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cmp	x1, x2
               	b.eq	<addr>
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0, #0x10]
               	cmp	x1, x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	cmp	w0, #0x61
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x4]
               	cmp	w0, #0x62
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x8]
               	cmp	w0, #0x63
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0xc]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	cmp	w0, #0x78
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x4]
               	cmp	w0, #0x79
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x8]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
