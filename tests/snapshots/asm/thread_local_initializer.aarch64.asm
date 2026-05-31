
thread_local_initializer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400288 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x10
               	ldrsw	x14, [x15]
               	cmp	x14, #0x7
               	b.eq	0x4002c0 <.text+0x50>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x18
               	ldrsw	x0, [x15]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x4002f8 <.text+0x88>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x20
               	ldrsw	x0, [x15]
               	cmp	x0, #0x0
               	b.eq	0x400320 <.text+0xb0>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x10
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x13, [x0]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x18
               	ldrsw	x12, [x0]
               	add	x0, x13, x12
               	sxtw	x0, w0
               	str	w0, [x15]
               	mrs	x12, TPIDR_EL0
               	add	x12, x12, #0x10
               	ldrsw	x0, [x12]
               	cmp	x0, #0x4
               	b.eq	0x400374 <.text+0x104>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
