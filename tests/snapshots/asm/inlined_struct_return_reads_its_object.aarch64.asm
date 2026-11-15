
inlined_struct_return_reads_its_object.aarch64:	file format elf64-littleaarch64

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

<pair>:
               	ldr	x2, [x0]
               	tbz	w2, #0x0, <addr>
               	orr	x0, x0, #0x1
               	ldr	x2, [x1]
               	tbz	w2, #0x0, <addr>
               	orr	x1, x1, #0x1
               	eor	x0, x0, x1
               	ret
               	add	x2, x2, #0x1
               	str	x2, [x1]
               	b	<addr>
               	add	x2, x2, #0x1
               	str	x2, [x0]
               	b	<addr>

<walk>:
               	mov	x4, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sub	x1, x3, x1
               	add	x2, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	add	x1, x4, x0, lsl #3
               	ldr	x3, [x1]
               	tbz	w3, #0x0, <addr>
               	orr	x3, x1, #0x1
               	b	<addr>
               	add	x3, x3, #0x1
               	str	x3, [x1]
               	mov	x3, x1
               	b	<addr>
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x1, x0, #0x8
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x20
               	orr	x2, x0, #0x1
               	add	x3, x0, #0x8
               	eor	x2, x2, x3
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x20]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x18]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
