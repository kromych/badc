
file_io.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x21, x0
               	sxtw	x0, w20
               	mov	x2, #0x9                // =9
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	add	x0, x21, #0x9
               	mov	x21, #0x0               // =0
               	strb	w21, [x0]
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
