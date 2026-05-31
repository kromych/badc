
va_copy.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002dc <.text+0xbc>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x10
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	sub	x13, x29, #0x10
               	sub	x14, x29, #0x8
               	ldr	x17, [x14]
               	str	x17, [x13]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x18]
               	stur	w15, [x29, #-0x20]
               	b	0x400278 <.text+0x58>
               	ldursw	x15, [x29, #-0x20]
               	ldursw	x14, [x29, #0x10]
               	cmp	x15, x14
               	b.ge	0x4002c0 <.text+0xa0>
               	ldursw	x14, [x29, #-0x18]
               	sub	x13, x29, #0x10
               	ldr	x15, [x13]
               	add	x17, x15, #0x10
               	str	x17, [x13]
               	ldrsw	x13, [x15]
               	add	x15, x14, x13
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x18]
               	ldursw	x13, [x29, #-0x20]
               	add	x15, x13, #0x1
               	sxtw	x15, w15
               	stur	w15, [x29, #-0x20]
               	b	0x400278 <.text+0x58>
               	sub	x15, x29, #0x10
               	sub	x13, x29, #0x8
               	ldursw	x0, [x29, #-0x18]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x20, #0x4               // =4
               	mov	x21, #0xa               // =10
               	mov	x22, #0x14              // =20
               	mov	x23, #0x1e              // =30
               	mov	x24, #0x28              // =40
               	str	x24, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	bl	0x400238 <.text+0x18>
               	add	sp, sp, #0x50
               	cmp	x0, #0x64
               	b.eq	0x400358 <.text+0x138>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
