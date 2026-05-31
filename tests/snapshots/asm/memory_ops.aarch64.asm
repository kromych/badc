
memory_ops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400308 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	mov	x20, #0xa               // =10
               	mov	x0, x20
               	bl	0x4005a8 <malloc>
               	mov	x21, x0
               	mov	x0, x20
               	bl	0x4005a8 <malloc>
               	mov	x22, x0
               	mov	x23, #0x41              // =65
               	mov	x24, #0x9               // =9
               	mov	x0, x21
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x4005b4 <memset>
               	add	x0, x21, #0x9
               	mov	x25, #0x0               // =0
               	strb	w25, [x0]
               	mov	x0, x22
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x4005b4 <memset>
               	add	x0, x22, #0x9
               	strb	w25, [x0]
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	0x4005c0 <memcmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4003dc <.text+0xec>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x22, #0x5
               	mov	x20, #0x42              // =66
               	strb	w20, [x0]
               	mov	x26, #0xa               // =10
               	mov	x0, x21
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x4005c0 <memcmp>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	0x40043c <.text+0x14c>
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
