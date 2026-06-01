
write_stdout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x1, x0
               	mov	x20, #0x0               // =0
               	mov	x13, #0x68              // =104
               	strb	w13, [x1]
               	mov	x0, #0x1                // =1
               	add	x13, x1, #0x1
               	mov	x11, #0x69              // =105
               	strb	w11, [x13]
               	add	x10, x1, #0x2
               	mov	x11, #0xa               // =10
               	strb	w11, [x10]
               	mov	x2, #0x3                // =3
               	add	x11, x1, #0x3
               	strb	w20, [x11]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
