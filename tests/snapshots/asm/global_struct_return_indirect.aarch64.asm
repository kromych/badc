
global_struct_return_indirect.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<get_global>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x8, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x16, x0
               	sub	x17, x29, #0x8
               	ldr	x17, [x17]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldr	w0, [x16, #0x10]
               	str	w0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x8, x29, #0x18
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	ldr	w0, [x0, #0x10]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	sub	x8, x29, #0x18
               	bl	<addr>
               	ldur	w20, [x29, #-0x18]
               	sub	x8, x29, #0x18
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x10]
               	add	x0, x20, x0
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
