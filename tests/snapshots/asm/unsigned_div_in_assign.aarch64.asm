
unsigned_div_in_assign.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400278 <.text+0x58>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	ldr	x14, [x15]
               	mov	x13, #0x18              // =24
               	udiv	x12, x14, x13
               	ldr	x13, [x15]
               	mov	x15, #0x7               // =7
               	udiv	x17, x13, x15
               	msub	x14, x17, x15, x13
               	sxtw	x15, w12
               	mov	x17, #0x64              // =100
               	mul	x12, x15, x17
               	sxtw	x12, w12
               	sxtw	x15, w14
               	add	x14, x12, x15
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x15, x29, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x3ea
               	b.ne	0x4002d4 <.text+0xb4>
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x18]
               	b	0x4002e0 <.text+0xc0>
               	mov	x14, #0x1               // =1
               	stur	x14, [x29, #-0x18]
               	b	0x4002e0 <.text+0xc0>
               	ldur	x14, [x29, #-0x18]
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
