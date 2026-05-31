
mem2reg_value_across_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40032c <.text+0x10c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	add	x0, x15, #0x7
               	ret
               	mov	x15, x0
               	lsl	x14, x15, #1
               	add	x0, x14, #0x1
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x20, x0
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x21, x19
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x10]
               	stur	x13, [x29, #-0x18]
               	b	0x40029c <.text+0x7c>
               	ldur	x13, [x29, #-0x18]
               	cmp	x13, x20
               	b.ge	0x4002fc <.text+0xdc>
               	ldur	x22, [x29, #-0x10]
               	ldur	x23, [x29, #-0x18]
               	mov	x0, x23
               	bl	0x400244 <.text+0x24>
               	mov	x11, x0
               	add	x23, x22, x11
               	stur	x23, [x29, #-0x10]
               	ldur	x24, [x29, #-0x10]
               	ldur	x25, [x29, #-0x18]
               	mov	x9, x21
               	str	x25, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x22, x0
               	add	x25, x24, x22
               	stur	x25, [x29, #-0x10]
               	ldur	x22, [x29, #-0x18]
               	add	x25, x22, #0x1
               	stur	x25, [x29, #-0x18]
               	b	0x40029c <.text+0x7c>
               	ldur	x25, [x29, #-0x10]
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	0x400254 <.text+0x34>
               	mov	x14, x0
               	mov	x17, #0x7f              // =127
               	and	x20, x14, x17
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
