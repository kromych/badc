
library_name_defined_by_program.aarch64:	file format elf64-littleaarch64

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

<abs>:
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x1, #0x1                // =1
               	sub	x0, x1, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	b	<addr>

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x6                // =6
               	mov	x0, #0x3                // =3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x7                // =7
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x4                // =4
               	mov	x0, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
