
loop_idiom_overlap.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x20, #0x0               // =0
               	mov	x2, #0x20               // =32
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	mov	x0, x21
               	bl	<addr>
               	add	x1, x21, #0x3
               	b	<addr>
               	sxtw	x0, w20
               	add	x2, x1, x0
               	add	x3, x21, x0
               	ldrb	w3, [x3]
               	strb	w3, [x2]
               	add	x20, x0, #0x1
               	cmp	w20, #0x9
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x20, #0x0               // =0
               	mov	x2, #0x20               // =32
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x22, #0xa               // =10
               	mov	x0, x21
               	mov	x2, x22
               	bl	<addr>
               	add	x1, x21, #0x3
               	b	<addr>
               	sxtw	x0, w20
               	add	x2, x21, x0
               	add	x3, x1, x0
               	ldrb	w3, [x3]
               	strb	w3, [x2]
               	add	x20, x0, #0x1
               	cmp	w20, #0x7
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x20, #0x0               // =0
               	mov	x2, #0x20               // =32
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	mov	x0, x21
               	bl	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x1, x0, #0x2
               	sxtw	x1, w1
               	add	x1, x21, x1
               	add	x2, x21, x0
               	ldrb	w2, [x2]
               	strb	w2, [x1]
               	add	x20, x0, #0x1
               	cmp	w20, #0xa
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
