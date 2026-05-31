
unsigned_div_in_assign.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	ldr	x14, [x15]
               	mov	x13, #0x18              // =24
               	udiv	x14, x14, x13
               	ldr	x15, [x15]
               	mov	x13, #0x7               // =7
               	udiv	x17, x15, x13
               	msub	x15, x17, x13, x15
               	sxtw	x14, w14
               	mov	x17, #0x64              // =100
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	sxtw	x15, w15
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x8
               	ldr	x14, [x13]
               	mov	x15, #0x18              // =24
               	udiv	x14, x14, x15
               	ldr	x13, [x13]
               	mov	x15, #0x7               // =7
               	udiv	x17, x13, x15
               	msub	x13, x17, x15, x13
               	sxtw	x14, w14
               	mov	x17, #0x64              // =100
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	sxtw	x13, w13
               	add	x14, x14, x13
               	sxtw	x14, w14
               	cmp	x14, #0x3ea
               	b.ne	<addr>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x18]
               	b	<addr>
               	mov	x13, #0x1               // =1
               	stur	x13, [x29, #-0x18]
               	b	<addr>
               	ldur	x0, [x29, #-0x18]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
