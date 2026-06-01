
mem2reg_value_across_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	add	x0, x15, #0x7
               	ret
               	mov	x15, x0
               	lsl	x15, x15, #1
               	add	x0, x15, #0x1
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x238
               	mov	x21, x19
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x10]
               	stur	x13, [x29, #-0x18]
               	b	<addr>
               	ldur	x13, [x29, #-0x18]
               	cmp	x13, x20
               	b.ge	<addr>
               	ldur	x12, [x29, #-0x10]
               	ldur	x13, [x29, #-0x18]
               	lsl	x13, x13, #1
               	add	x13, x13, #0x1
               	add	x12, x12, x13
               	stur	x12, [x29, #-0x10]
               	ldur	x22, [x29, #-0x10]
               	ldur	x0, [x29, #-0x18]
               	mov	x9, x21
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x11, x0
               	add	x22, x22, x11
               	stur	x22, [x29, #-0x10]
               	ldur	x11, [x29, #-0x18]
               	add	x11, x11, #0x1
               	stur	x11, [x29, #-0x18]
               	b	<addr>
               	ldur	x11, [x29, #-0x10]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x14, x0
               	mov	x17, #0x7f              // =127
               	and	x14, x14, x17
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
