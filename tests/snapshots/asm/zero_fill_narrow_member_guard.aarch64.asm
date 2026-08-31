
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
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w6, [x3]
               	mov	x7, #0x1                // =1
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x5, x0
               	b	<addr>
               	ldrsw	x5, [x4]
               	add	x5, x5, #0x1
               	str	w5, [x4]
               	ldrsw	x5, [x8]
               	cmp	w2, #0x2
               	b.lo	<addr>
               	ldr	w1, [x3]
               	and	x2, x1, x7
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldr	w1, [x3]
               	mov	w2, w6
               	cmp	w1, w2
               	cset	x1, ne
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x1, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	mov	x2, x0
               	b	<addr>
               	mov	w2, w1
               	cbnz	x2, <addr>
               	sxtw	x0, w5
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
