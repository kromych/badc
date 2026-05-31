
global_initializer_int.aarch64:	file format elf64-littleaarch64

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
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	ldrsw	x14, [x15]
               	cmp	x14, #0x2a
               	b.eq	0x400284 <.text+0x54>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x14, x19
               	ldrsw	x0, [x14]
               	cmp	x0, #0x63
               	b.eq	0x4002b4 <.text+0x84>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x0, x19
               	ldrsw	x14, [x0]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x0, x19
               	ldrsw	x13, [x0]
               	add	x14, x14, x13
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
