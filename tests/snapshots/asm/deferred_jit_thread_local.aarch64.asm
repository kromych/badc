
deferred_jit_thread_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	sxtw	x15, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xe0
               	lsl	x13, x15, #2
               	add	x13, x14, x13
               	str	w15, [x13]
               	lsl	x15, x15, #2
               	add	x14, x14, x15
               	ldrsw	x0, [x14]
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x18
               	ldrsw	x0, [x0]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	mrs	x14, TPIDR_EL0
               	add	x14, x14, #0x10
               	ldrsw	x14, [x14]
               	mrs	x13, TPIDR_EL0
               	add	x13, x13, #0x18
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	str	w14, [x0]
               	mrs	x13, TPIDR_EL0
               	add	x13, x13, #0x10
               	ldrsw	x13, [x13]
               	cmp	x13, #0x4
               	b.eq	<addr>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
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
