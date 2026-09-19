
zero_fill_narrow_member_guard.aarch64:	file format elf64-littleaarch64

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

<reader>:
               	mov	x1, #0x0                // =0
               	mov	x0, #0x2                // =2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w3, [x2]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x6, x1
               	ldrsw	x5, [x4]
               	add	x5, x5, #0x1
               	str	w5, [x4]
               	ldrsw	x6, [x7]
               	cmp	w0, #0x2
               	b.lo	<addr>
               	ldr	w0, [x2]
               	and	x5, x0, #0x1
               	mov	x0, #0x1                // =1
               	cbnz	w5, <addr>
               	ldr	w0, [x2]
               	cmp	w0, w3
               	cset	x0, ne
               	cbnz	w0, <addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	cbnz	w0, <addr>
               	mov	x0, x6
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x9                // =9
               	str	w2, [x1]
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
