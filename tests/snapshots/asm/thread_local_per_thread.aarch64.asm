
thread_local_per_thread.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x10
               	ldrsw	x1, [x0]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xbad1             // =47825
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x63               // =99
               	str	w1, [x0]
               	sxtw	x1, w1
               	cmp	x1, #0x63
               	b.eq	<addr>
               	mov	x0, #0xbad2             // =47826
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mrs	x20, TPIDR_EL0
               	add	x20, x20, #0x10
               	mov	x0, #0x1                // =1
               	str	w0, [x20]
               	mov	x21, #0x0               // =0
               	mov	x1, #0x2                // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x108
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	adrp	x1, <page>
               	add	x1, x1, #0x117
               	mov	x0, x22
               	bl	<addr>
               	mov	x22, x0
               	sub	x0, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, #0x308
               	mov	x9, x23
               	str	x21, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	ldur	x0, [x29, #-0x20]
               	sub	x1, x29, #0x28
               	mov	x9, x22
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x20]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
