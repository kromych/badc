
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

<copy_up>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x2, x0
               	mov	x3, #0x9                // =9
               	mov	x0, #0x0                // =0
               	sub	x4, x2, x1
               	cmp	x4, #0x9
               	b.lo	<addr>
               	mov	x0, x2
               	mov	x2, x3
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x9
               	b.ge	<addr>
               	b	<addr>

<copy_down>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x2, x0
               	mov	x3, #0x7                // =7
               	mov	x0, #0x0                // =0
               	sub	x4, x2, x1
               	cmp	x4, #0x7
               	b.lo	<addr>
               	mov	x0, x2
               	mov	x2, x3
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x7
               	b.ge	<addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, #0x3
               	mov	x2, #0x9                // =9
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x3
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	bl	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	x1, x0, #0x2
               	ldrb	w2, [x20, x0]
               	strb	w2, [x20, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
