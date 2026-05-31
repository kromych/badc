
thread_local_initializer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x10
               	ldrsw	x15, [x15]
               	cmp	x15, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x18
               	ldrsw	x15, [x15]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x20
               	ldrsw	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x15, TPIDR_EL0
               	add	x15, x15, #0x10
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	mrs	x13, TPIDR_EL0
               	add	x13, x13, #0x18
               	ldrsw	x13, [x13]
               	add	x0, x0, x13
               	sxtw	x0, w0
               	str	w0, [x15]
               	mrs	x13, TPIDR_EL0
               	add	x13, x13, #0x10
               	ldrsw	x13, [x13]
               	cmp	x13, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
