
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
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x2, x0
               	mov	x3, x1
               	mov	x0, #0x0                // =0
               	sub	x1, x2, x3
               	cmp	x1, #0x9
               	b.lo	<addr>
               	mov	x0, #0x9                // =9
               	mov	x1, x3
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, #0x9
               	b.ge	<addr>
               	b	<addr>

<copy_down>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x2, x0
               	mov	x3, x1
               	mov	x0, #0x0                // =0
               	sub	x1, x2, x3
               	cmp	x1, #0x7
               	b.lo	<addr>
               	mov	x0, #0x7                // =7
               	mov	x1, x3
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	cmp	w0, #0x7
               	b.ge	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x20, #0x3
               	mov	x2, #0x9                // =9
               	mov	x1, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x21, #0xa               // =10
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x1, x20, #0x3
               	mov	x2, #0x7                // =7
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x20               // =32
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x1, #0x2
               	sxtw	x2, w2
               	add	x2, x20, x2
               	add	x3, x20, x1
               	ldrb	w3, [x3]
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
