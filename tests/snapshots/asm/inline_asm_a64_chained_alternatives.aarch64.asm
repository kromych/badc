
inline_asm_a64_chained_alternatives.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x8]
               	sub	x16, x29, #0x10
               	nop
               	ldr	x0, [x16]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	nop
               	ldr	x0, [x16]
               	sub	x16, x29, #0x10
               	nop
               	ldr	x1, [x16]
               	add	x0, x0, x1
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	dmb	osh
               	ldar	x0, [x16]
               	dmb	osh
               	ldar	x0, [x16]
               	dmb	osh
               	ldar	x1, [x16]
