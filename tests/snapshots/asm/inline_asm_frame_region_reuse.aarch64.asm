
inline_asm_frame_region_reuse.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	x2, [x29, #-0x8]
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	x2, [x29, #-0x8]
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	x2, [x29, #-0x8]
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	x2, [x29, #-0x8]
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	x2, [x29, #-0x8]
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x2, [x29, #-0x8]
               	add	x2, x2, #0x1
               	stur	x2, [x29, #-0x8]
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	x0, [x16]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	cmp	x0, #0x8
               	b.ne	<addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
