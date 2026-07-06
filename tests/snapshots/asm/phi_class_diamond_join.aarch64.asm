
phi_class_diamond_join.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	x0, x1, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
               	sub	x0, x2, #0x1
               	sxtw	x0, w0
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x1                // =1
               	mov	x1, #0xa                // =10
               	mov	x20, #0x0               // =0
               	mov	x2, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x2, #0x14               // =20
               	mov	x0, x20
               	mov	x1, x20
               	bl	<addr>
               	add	x0, x21, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
