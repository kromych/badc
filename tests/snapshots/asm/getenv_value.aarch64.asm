
getenv_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400288 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400438 <getenv>
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.ne	0x4002d8 <.text+0x68>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w20, [x14]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
