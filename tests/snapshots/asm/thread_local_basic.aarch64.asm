
thread_local_basic.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x14, [x15]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x14, TPIDR_EL0
               	add	x14, x14, #0x18
               	ldrsw	x0, [x14]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	mov	x14, #0x7               // =7
               	str	w14, [x0]
               	mrs	x13, TPIDR_EL0
               	add	x13, x13, #0x18
               	mov	x14, #0x2a              // =42
               	str	w14, [x13]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x14, [x0]
               	cmp	x14, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x14, TPIDR_EL0
               	add	x14, x14, #0x18
               	ldrsw	x0, [x14]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	mrs	x14, TPIDR_EL0
               	add	x14, x14, #0x10
               	ldrsw	x13, [x14]
               	mrs	x14, TPIDR_EL0
               	add	x14, x14, #0x18
               	ldrsw	x12, [x14]
               	add	x13, x13, x12
               	sxtw	x13, w13
               	str	w13, [x0]
               	mrs	x12, TPIDR_EL0
               	add	x12, x12, #0x10
               	ldrsw	x13, [x12]
               	cmp	x13, #0x31
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
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
