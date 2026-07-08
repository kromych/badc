
comma_operator_in_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x240              // =576
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, x0
               	sxtw	x1, w1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x0, x1
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	add	x20, x20, #0xa
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	add	x20, x20, #0x64
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	add	x20, x20, #0x3e8
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	add	x20, x20, #0x1
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	add	x20, x20, #0x1
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	add	x20, x20, #0x1
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sub	x0, x20, #0x456
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
