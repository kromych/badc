
zero_length_array_typedef.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x18
               	mov	x1, #0x7788             // =30600
               	movk	x1, #0x5566, lsl #16
               	movk	x1, #0x3344, lsl #32
               	movk	x1, #0x1122, lsl #48
               	str	x1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x9                // =9
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	sub	x1, x29, #0x18
               	sub	x0, x0, x1
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
