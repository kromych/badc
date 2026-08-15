
inline_asm_a64_bl_here.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	mov	x0, x30
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	mov	x30, x0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	mov	x0, #0x29               // =41
               	sub	x1, x29, #0x10
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	mov	x0, x1
               	b	<addr>
               	mov	x0, #0x63               // =99
               	add	x0, x0, #0x1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x8
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	str	x0, [sp, #0x10]
               	ldr	x2, [sp, #0x10]
               	mov	x1, x30
               	mov	x0, x2
               	bl	<addr>
               	b	<addr>
               	add	x0, x0, #0x1
               	ret
               	mov	x30, x1
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x16, [sp, #0x8]
               	str	x1, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
