
aggregate_built_in_place.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x7                // =7
               	mov	x2, #0x8                // =8
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	x1, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x1, [x2]
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
