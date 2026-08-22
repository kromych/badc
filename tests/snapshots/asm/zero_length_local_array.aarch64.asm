
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x1, #0x4                // =4
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x4]
               	mov	x3, #0x7                // =7
               	str	w3, [x0, #0x8]
               	sub	x3, x29, #0x8
               	cmp	x3, x0
               	b.ne	<addr>
               	b	<addr>
               	ldrsw	x1, [x0]
               	ldrsw	x3, [x0, #0x4]
               	add	x1, x1, x3
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
