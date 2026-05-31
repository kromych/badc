
tentative_definitions.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldrsw	x14, [x15]
               	cmp	x14, #0x3
               	b.eq	0x400274 <.text+0x54>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd8
               	mov	x15, x19
               	ldrsw	x0, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x12, [x13]
               	add	x13, x0, x12
               	sxtw	x13, w13
               	add	x12, x15, #0x8
               	ldrsw	x15, [x12]
               	add	x12, x13, x15
               	sxtw	x12, w12
               	cmp	x12, #0x6
               	b.eq	0x4002c0 <.text+0xa0>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
