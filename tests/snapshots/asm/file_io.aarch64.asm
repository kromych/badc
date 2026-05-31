
file_io.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400348 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x20, x19
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400578 <open>
               	sxtw	x0, w0
               	mov	x22, x0
               	sxtw	x21, w22
               	cmp	x21, #0x0
               	b.ge	0x4003c8 <.text+0x98>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0xa               // =10
               	mov	x0, x23
               	bl	0x400584 <malloc>
               	mov	x21, x0
               	sxtw	x20, w22
               	mov	x23, #0x9               // =9
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x400590 <read>
               	sxtw	x0, w0
               	add	x21, x21, #0x9
               	mov	x24, #0x0               // =0
               	strb	w24, [x21]
               	sxtw	x22, w22
               	mov	x0, x22
               	bl	0x40059c <close>
               	sxtw	x0, w0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
