
post_inline_dead_data_repack.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x1, x0, #0x3f
               	cbz	w1, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0]
               	cmp	x1, #0x7
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x19               // =25
               	str	x4, [x1, #0x10]
               	ldr	x2, [x1]
               	cbnz	x2, <addr>
               	ldr	x1, [x1, #0x18]
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	cmp	x2, x3
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x0, #0x8]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x28               // =40
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
