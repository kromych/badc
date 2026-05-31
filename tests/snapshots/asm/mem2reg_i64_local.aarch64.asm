
mem2reg_i64_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400298 <.text+0x78>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, x0
               	mov	x17, #0x3               // =3
               	mul	x14, x15, x17
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x10]
               	stur	x15, [x29, #-0x18]
               	b	0x400260 <.text+0x40>
               	ldur	x15, [x29, #-0x18]
               	cmp	x15, #0x4
               	b.ge	0x400288 <.text+0x68>
               	ldur	x15, [x29, #-0x10]
               	add	x13, x15, x14
               	stur	x13, [x29, #-0x10]
               	ldur	x15, [x29, #-0x18]
               	add	x13, x15, #0x1
               	stur	x13, [x29, #-0x18]
               	b	0x400260 <.text+0x40>
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
