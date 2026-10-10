
local_struct_array_brace_init.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x70
               	sub	x2, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	lsl	x3, x0, #4
               	add	x3, x2, x3
               	ldr	x3, [x3, #0x8]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	x1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x30
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	stp	xzr, xzr, [x2, #0x20]
               	sub	x0, x29, #0x60
               	stur	x0, [x29, #-0x30]
               	mov	x0, #0x10               // =16
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x50
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x20               // =32
               	stur	x0, [x29, #-0x18]
               	sub	x0, x29, #0x68
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	lsl	x3, x0, #4
               	add	x3, x2, x3
               	ldr	x3, [x3, #0x8]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	x1, #0x38
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x30]
               	sub	x1, x29, #0x60
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	sub	x1, x29, #0x50
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x68
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
