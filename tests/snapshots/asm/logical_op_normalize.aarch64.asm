
logical_op_normalize.aarch64:	file format elf64-littleaarch64

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

<or_ll>:
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	b	<addr>

<or_rr>:
               	cmp	x1, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	ret

<and_ll>:
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ret

<and_rr>:
               	cmp	w1, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x20, [x0]
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	sub	x21, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [sp], #0x10
               	mov	x0, x21
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	ldrsw	x0, [x21, x0, lsl #2]
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	sub	x21, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	ldrsw	x0, [x21, x0, lsl #2]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	cbnz	x20, <addr>
               	mov	x1, #0x0                // =0
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
