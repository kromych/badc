
zero_length_local_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sub	x0, x0, #0x3
               	add	x0, x0, #0x0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x6                // =6
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x10
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
