
local_array_runtime_nested_init.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x6                // =6
               	stur	w0, [x29, #-0x18]
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x8                // =8
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
