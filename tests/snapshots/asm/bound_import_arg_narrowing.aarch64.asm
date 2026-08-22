
bound_import_arg_narrowing.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x50]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	mov	x21, #0x3               // =3
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x20, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	ldrb	w1, [x20]
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w0, [x20, #0x1]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x2]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldrb	w0, [x20, #0x3]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	b	<addr>
               	b	<addr>
