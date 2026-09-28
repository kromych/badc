
address_constant_array_strides.aarch64:	file format elf64-littleaarch64

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
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x2, x1, #0x10
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x3, x0, #0x20
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	add	x3, x0, #0x30
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x4, x2, #0x14
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	add	x2, x2, #0x28
               	cmp	x3, x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x2, x2, #0x3
               	ldrb	w2, [x2]
               	mov	x17, #0x62              // =98
               	eor	x2, x2, x17
               	cbz	w2, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	ldrb	w3, [x3]
               	mov	x17, #0x65              // =101
               	eor	x3, x3, x17
               	cbnz	w3, <addr>
               	ldr	x2, [x2]
               	ldrb	w2, [x2, #0x3]
               	mov	x17, #0x68              // =104
               	eor	x2, x2, x17
               	cbz	w2, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	ldrb	w2, [x2]
               	mov	x17, #0x61              // =97
               	eor	x2, x2, x17
               	cbnz	w2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	ldrb	w2, [x2]
               	mov	x17, #0x62              // =98
               	eor	x2, x2, x17
               	cbz	w2, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	add	x1, x1, #0xc
               	cmp	x2, x1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	add	x0, x0, #0x10
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x0                // =0
               	ret
