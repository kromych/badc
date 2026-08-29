
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
               	sub	x4, x29, #0x68
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x4, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x4, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x4, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x4, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x3, x2, #4
               	add	x3, x4, x3
               	ldr	x3, [x3, #0x8]
               	add	x1, x1, x3
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	x1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x68
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	str	x0, [x1, #0x20]
               	str	x0, [x1, #0x28]
               	sub	x2, x29, #0x38
               	str	x2, [x1]
               	mov	x2, #0x10               // =16
               	str	x2, [x1, #0x8]
               	sub	x2, x29, #0x28
               	str	x2, [x1, #0x10]
               	mov	x2, #0x20               // =32
               	str	x2, [x1, #0x18]
               	sub	x2, x29, #0x8
               	str	x2, [x1, #0x20]
               	mov	x2, #0x8                // =8
               	str	x2, [x1, #0x28]
               	mov	x2, x0
               	b	<addr>
               	sxtw	x3, w0
               	lsl	x4, x3, #4
               	add	x4, x1, x4
               	ldr	x4, [x4, #0x8]
               	add	x2, x2, x4
               	add	x0, x3, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	x2, #0x38
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	ldr	x1, [x0]
               	sub	x2, x29, #0x38
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x10]
               	sub	x2, x29, #0x28
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x20]
               	sub	x2, x29, #0x8
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0x28]
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
