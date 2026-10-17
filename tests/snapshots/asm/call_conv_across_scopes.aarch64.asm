
call_conv_across_scopes.aarch64:	file format elf64-littleaarch64

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

<block_first>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0xe
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<block_plain>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<hidden_by_local>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<names_foreign>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<keeps_values>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	ldr	x21, [x0, #0x8]
               	ldr	x22, [x0, #0x10]
               	ldr	x23, [x0, #0x18]
               	ldr	x24, [x0, #0x20]
               	ldr	x25, [x0, #0x28]
               	ldr	x26, [x0, #0x30]
               	ldr	x27, [x0, #0x38]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	bl	<addr>
               	sxtw	x0, w0
               	add	x0, x0, x20
               	add	x0, x0, x21, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x1, x22, x17
               	add	x0, x0, x1
               	add	x0, x0, x23, lsl #2
               	mov	x17, #0x5               // =5
               	mul	x1, x24, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x25, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x26, x17
               	add	x0, x0, x1
               	add	x0, x0, x27, lsl #3
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<add100>:
               	add	x0, x0, #0x64
               	ret

<twice>:
               	lsl	x0, x0, #1
               	ret

<times3>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	ret

<fcl>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	ldrsw	x0, [x0]
               	add	x0, x2, x0
               	str	w0, [x1]
               	ret

<cleanup_hidden>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0xe                // =14
               	bl	<addr>
               	cmp	w0, #0x79
               	cset	x20, ne
               	bl	<addr>
               	cmp	w0, #0x66
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #1
               	bl	<addr>
               	cmp	w0, #0xa
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #2
               	bl	<addr>
               	cmp	w0, #0x3
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #5
               	bl	<addr>
               	cmp	x0, #0x247
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #3
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x65
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #4
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x9
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	cset	x0, ne
               	orr	x0, x20, x0, lsl #6
               	cmp	w0, #0x0
               	cset	x0, ne
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
