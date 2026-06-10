
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
               	sxtw	x1, w1
               	sxtw	x2, w2
               	cbz	x0, <addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	sxtw	x0, w1
               	ret
               	sub	x0, x2, #0x1
               	sxtw	x1, w0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
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
               	sxtw	x1, w21
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
