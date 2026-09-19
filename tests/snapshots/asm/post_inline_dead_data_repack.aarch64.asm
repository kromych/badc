
post_inline_dead_data_repack.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x0, x2, #0x18
               	cmp	x0, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x0, x1, #0x3f
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	ldr	x0, [x1, #0x8]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x3, #0x19               // =25
               	str	x3, [x0, #0x10]
               	ldr	x3, [x0]
               	cbnz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	cmp	x3, #0x19
               	b.ne	<addr>
               	ldr	x3, [x0, #0x18]
               	cbz	x3, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	cmp	x3, x2
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x28               // =40
               	ldr	x1, [x1, #0x8]
               	ldr	x0, [x0, #0x10]
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x1
               	mov	x1, x4
               	mov	x4, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
