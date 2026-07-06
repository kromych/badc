
store_forward_local_slot.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #0x10]
               	adr	x1, <addr>
               	stur	x1, [x29, #-0x8]
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	stur	w0, [x29, #-0x10]
               	sxtw	x0, w0
               	add	x0, x0, x0
               	stur	w0, [x29, #-0x18]
               	br	x1
               	ldursw	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<volatile_kept>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #0x10]
               	adr	x1, <addr>
               	stur	x1, [x29, #-0x8]
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	br	x1
               	ldursw	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<aliased_kept>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #0x10]
               	adr	x1, <addr>
               	stur	x1, [x29, #-0x8]
               	sub	x2, x29, #0x10
               	stur	x2, [x29, #-0x18]
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	ldursw	x0, [x29, #-0x10]
               	stur	w0, [x29, #-0x20]
               	br	x1
               	ldursw	x0, [x29, #-0x20]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<cross_block>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #0x10]
               	adr	x1, <addr>
               	stur	x1, [x29, #-0x8]
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	stur	w0, [x29, #-0x10]
               	br	x1
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
