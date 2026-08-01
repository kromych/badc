
post_inline_dead_data_repack.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2d0              // =720
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	add	x2, x1, #0x18
               	cmp	x0, x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x19               // =25
               	str	x2, [x0, #0x10]
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x19
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x2, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x4, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
