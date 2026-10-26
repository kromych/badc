
setjmp_posix_forms_return_twice.aarch64:	file format elf64-littleaarch64

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

<jump_plain>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	brk	#0x1

<jump_sig>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	wzr, [sp, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	str	w0, [sp, #0x8]
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x3
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x8]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	bl	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	str	w0, [sp, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x100
               	mov	x2, x0
               	bl	<addr>
               	bl	<addr>
               	brk	#0x1
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x8]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
