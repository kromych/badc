
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
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x141              // =321
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	mov	x17, #0x41              // =65
               	eor	x1, x1, x17
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x41              // =65
               	eor	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x41              // =65
               	eor	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
