
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
               	ldr	w5, [x2]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, x1
               	ldrsw	x4, [x3]
               	add	x4, x4, #0x1
               	str	w4, [x3]
               	ldrsw	x4, [x6]
               	cmp	w0, #0x2
               	b.lo	<addr>
               	ldr	w0, [x2]
               	tbnz	w0, #0x0, <addr>
               	ldr	w0, [x2]
               	cmp	w0, w5
               	b.ne	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	cbnz	w0, <addr>
               	mov	x0, x4
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
