
array_compound_literal_static_init.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x2, [x1, #0x8]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	cmp	w1, #0x61
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrsw	x2, [x1, #0x8]
               	cmp	w2, #0x2aa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x2, [x1]
               	ldrb	w2, [x2]
               	cmp	w2, #0x69
               	b.ne	<addr>
               	ldr	x2, [x1]
               	ldrb	w2, [x2, #0x1]
               	cmp	w2, #0x66
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x1, [x1, #0x18]
               	cmp	w1, #0x28b
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x1, #0x10]
               	ldrb	w2, [x2, #0x1]
               	cmp	w2, #0x6e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldrsw	x2, [x1, #0x28]
               	cmn	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	ldr	x1, [x1, #0x20]
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	ldr	x0, [x0, #0x10]
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldrsw	x1, [x0, #0x18]
               	cbnz	w1, <addr>
               	ldr	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	ldrsw	x0, [x0, #0x28]
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x0                // =0
               	ret
