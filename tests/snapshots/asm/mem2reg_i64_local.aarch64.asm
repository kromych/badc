
mem2reg_i64_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, x0
               	mov	x17, #0x3               // =3
               	mul	x15, x15, x17
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x10]
               	stur	x14, [x29, #-0x18]
               	b	<addr>
               	ldur	x14, [x29, #-0x18]
               	cmp	x14, #0x4
               	b.ge	<addr>
               	ldur	x13, [x29, #-0x10]
               	add	x13, x13, x15
               	stur	x13, [x29, #-0x10]
               	ldur	x14, [x29, #-0x18]
               	add	x14, x14, #0x1
               	stur	x14, [x29, #-0x18]
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x14, x0
               	sxtw	x14, w14
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
