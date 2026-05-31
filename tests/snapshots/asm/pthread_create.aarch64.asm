
pthread_create.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002d4 <.text+0x24>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	mov	x15, x0
               	mov	x0, #0xb                // =11
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	mov	x20, #0x0               // =0
               	mov	x21, #0x2               // =2
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400528 <dlopen>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400534 <dlsym>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x107
               	mov	x24, x19
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x400534 <dlsym>
               	mov	x23, x0
               	sub	x25, x29, #0x20
               	adrp	x19, 0x400000
               	add	x19, x19, #0x2c8
               	mov	x24, x19
               	mov	x9, x21
               	str	x20, [sp, #-0x10]!
               	str	x24, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	str	x25, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	mov	x10, x0
               	ldur	x22, [x29, #-0x20]
               	sub	x26, x29, #0x28
               	mov	x9, x23
               	str	x26, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x25, x0
               	ldur	x25, [x29, #-0x28]
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
