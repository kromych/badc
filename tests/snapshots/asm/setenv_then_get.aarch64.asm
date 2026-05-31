
setenv_then_get.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002c8 <.text+0x18>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x101
               	mov	x21, x19
               	mov	x22, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x4004c8 <setenv>
               	sxtw	x0, w0
               	mov	x12, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x103
               	mov	x23, x19
               	mov	x0, x23
               	bl	0x4004d4 <getenv>
               	mov	x22, x0
               	cmp	x22, #0x0
               	b.ne	0x400364 <.text+0xb4>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w23, [x22]
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
