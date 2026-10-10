
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	mov	x1, #0x141              // =321
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	ldurb	w0, [x29, #-0x8]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x7]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x6]
               	mov	x17, #0x41              // =65
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x5]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
