
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x4               // =4
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x22, #0x0               // =0
               	mov	x13, #0x68              // =104
               	strb	w13, [x21]
               	mov	x20, #0x1               // =1
               	add	x13, x21, #0x1
               	mov	x11, #0x69              // =105
               	strb	w11, [x13]
               	add	x10, x21, #0x2
               	mov	x11, #0xa               // =10
               	strb	w11, [x10]
               	mov	x23, #0x3               // =3
               	add	x11, x21, #0x3
               	strb	w22, [x11]
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
