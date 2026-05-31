
warn_dead_store.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x5               // =5
               	sxtw	x15, w15
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x15, w0
               	mov	x14, #0x1               // =1
               	stur	w14, [x29, #-0x8]
               	cbz	x15, <addr>
               	mov	x13, #0x2               // =2
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x1               // =1
               	stur	w15, [x29, #-0x8]
               	sub	x14, x29, #0x8
               	ldrsw	x0, [x14]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	add	x20, x20, x0
               	sxtw	x20, w20
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	bl	<addr>
               	add	x20, x20, x0
               	sxtw	x20, w20
               	bl	<addr>
               	add	x20, x20, x0
               	sxtw	x20, w20
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
