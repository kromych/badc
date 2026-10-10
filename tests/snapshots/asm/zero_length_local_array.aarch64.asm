
zero_length_local_array.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1]
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x10
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x10]
               	mov	x2, #0x6                // =6
               	stur	w2, [x29, #-0xc]
               	mov	x4, #0x7                // =7
               	stur	w4, [x29, #-0x8]
               	sub	x4, x29, #0x18
               	cmp	x4, x3
               	b.eq	<addr>
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x3, [x29, #-0xc]
               	add	x0, x0, x3
               	ldursw	x3, [x29, #-0x8]
               	add	x0, x0, x3
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
