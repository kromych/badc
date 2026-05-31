
memcpy_oob_dst.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x64              // =100
               	mov	x0, x20
               	bl	0x400488 <malloc>
               	mov	x21, x0
               	mov	x22, #0x8               // =8
               	mov	x0, x22
               	bl	0x400488 <malloc>
               	mov	x23, x0
               	mov	x0, x23
               	mov	x2, x20
               	mov	x1, x21
               	bl	0x400494 <memcpy>
               	mov	x22, x0
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
