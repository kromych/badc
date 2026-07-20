
inline_asm_const_modifier.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0x2a               // =42
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	b	<addr>
               	udf	#0x2a
               	adr	x0, <addr>
               	ldr	w1, [x0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	w1, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<address_modifier>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ret

<call_modifier>:
               	mov	x0, #0x7                // =7
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
