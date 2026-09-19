
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
               	cmp	w0, #0x0
               	b.eq	<addr>
               	ldrsw	x5, [x4]
               	add	x5, x5, #0x1
               	str	w5, [x4]
               	ldrsw	x6, [x7]
               	cmp	w0, #0x2
               	b.lo	<addr>
               	ldr	w0, [x2]
               	and	x5, x0, #0x1
               	mov	x0, #0x1                // =1
               	cbnz	x5, <addr>
               	ldr	w0, [x2]
               	cmp	w0, w3
               	cset	x0, ne
               	cmp	w0, #0x0
               	b.ne	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	cmp	w0, #0x0
               	b.ne	<addr>
               	sxtw	x0, w6
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, #0x2                // =2
               	str	w0, [x21]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x0, #0x7                // =7
               	str	w0, [x22]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldrsw	x0, [x20]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	str	w0, [x21]
               	mov	x0, #0x9                // =9
               	str	w0, [x22]
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldrsw	x0, [x20]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
