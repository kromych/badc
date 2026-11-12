
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
               	ldr	w5, [x2, #0x34]
               	adrp	x6, <page>
               	adrp	x3, <page>
               	mov	x4, x1
               	ldrsw	x4, [x3, #0x40]
               	add	x4, x4, #0x1
               	str	w4, [x3, #0x40]
               	ldrsw	x4, [x6, #0x38]
               	cmp	w0, #0x2
               	b.lo	<addr>
               	ldr	w0, [x2, #0x34]
               	tbnz	w0, #0x0, <addr>
               	ldr	w0, [x2, #0x34]
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
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0x34]
               	adrp	x0, <page>
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x38]
               	adrp	x0, <page>
               	str	wzr, [x0, #0x40]
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x40]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	mov	x2, #0x3                // =3
               	str	w2, [x1, #0x34]
               	adrp	x1, <page>
               	mov	x2, #0x9                // =9
               	str	w2, [x1, #0x38]
               	str	wzr, [x0, #0x40]
               	bl	<addr>
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x40]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x3c]
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
