
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
               	mov	x1, #0x0                // =0
               	ldr	x2, [x0]
               	ldr	w2, [x2]
               	cmp	x2, #0x4c
               	b.ne	<addr>
               	ldr	x2, [x0]
               	ldr	w2, [x2, #0x1c]
               	cmp	x2, #0x42
               	cset	x2, eq
               	cbnz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x2, [x0, #0x8]
               	ldr	w2, [x2, #0x1c]
               	cmp	x2, #0x46
               	b.ne	<addr>
               	ldr	x2, [x0, #0x8]
               	ldr	w2, [x2, #0x20]
               	cmp	x2, #0x6c
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x2, [x0, #0x8]
               	ldr	w2, [x2, #0x30]
               	cmp	x2, #0x79
               	cset	x2, eq
               	cbnz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x2, [x0, #0x10]
               	ldr	w2, [x2]
               	cmp	x2, #0x43
               	b.ne	<addr>
               	ldr	x2, [x0, #0x10]
               	ldr	w2, [x2, #0x4]
               	cmp	x2, #0x44
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x2, [x0, #0x10]
               	ldr	w2, [x2, #0x8]
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	cmp	x2, x3
               	cset	x2, eq
               	cbnz	x2, <addr>
               	ldr	x2, [x0, #0x8]
               	ldr	x0, [x0, #0x10]
               	cmp	x2, x0
               	cset	x2, eq
               	cbz	x2, <addr>
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
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldr	w1, [x1]
               	cmp	x1, #0x61
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1, #0x4]
               	cmp	x1, #0x62
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1, #0x8]
               	cmp	x1, #0x63
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1, #0xc]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	cmp	x1, #0x78
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1, #0x4]
               	cmp	x1, #0x79
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1, #0x8]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0x69              // =105
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0x2]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
