
global_initializer_pointer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x15, x19
               	ldr	x14, [x15]
               	ldrsw	x15, [x14]
               	cmp	x15, #0x7
               	b.eq	0x400288 <.text+0x58>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x14, x19
               	mov	x0, #0xb                // =11
               	str	w0, [x14]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x13, x19
               	ldr	x0, [x13]
               	ldrsw	x13, [x0]
               	cmp	x13, #0xb
               	b.eq	0x4002d0 <.text+0xa0>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
