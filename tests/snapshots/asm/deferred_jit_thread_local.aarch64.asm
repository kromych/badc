
deferred_jit_thread_local.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x15, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x14, x19
               	lsl	x13, x15, #2
               	add	x13, x14, x13
               	str	w15, [x13]
               	lsl	x15, x15, #2
               	add	x14, x14, x15
               	ldrsw	x0, [x14]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x20, [x0]
               	cmp	x20, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x20, TPIDR_EL0
               	add	x20, x20, #0x18
               	ldrsw	x0, [x20]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	mrs	x20, TPIDR_EL0
               	add	x20, x20, #0x10
               	ldrsw	x13, [x20]
               	mrs	x20, TPIDR_EL0
               	add	x20, x20, #0x18
               	ldrsw	x12, [x20]
               	add	x13, x13, x12
               	sxtw	x13, w13
               	str	w13, [x0]
               	mrs	x12, TPIDR_EL0
               	add	x12, x12, #0x10
               	ldrsw	x13, [x12]
               	cmp	x13, #0x4
               	b.eq	<addr>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
