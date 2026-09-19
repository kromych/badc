
fn_type_typedef_ptr.aarch64:	file format elf64-littleaarch64

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

<cr_init>:
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	str	x2, [x0, #0x8]
               	ret

<my_realloc>:
               	mov	x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x2, [x1]
               	ret

<inc>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<apply>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<apply2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<deref_call>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<grouped>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<via_alias>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x8
               	mov	x2, #0x2a               // =42
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x2a
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x10
               	mov	x0, #0x3                // =3
               	ldr	x1, [x1]
               	blr	x1
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x10]
               	mov	x0, #0x4                // =4
               	blr	x1
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x10]
               	mov	x0, #0x5                // =5
               	blr	x1
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
