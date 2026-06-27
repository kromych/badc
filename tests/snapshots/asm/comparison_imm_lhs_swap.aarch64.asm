
comparison_imm_lhs_swap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x5               // =5
               	mov	x21, #0x0               // =0
               	cmp	x20, #0x0
               	b.le	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	x20, #0x0
               	b.lt	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	x20, #0xa
               	b.ge	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	x20, #0xa
               	b.gt	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	x20, #0x0
               	b.ls	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	x20, #0x0
               	b.lo	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	x20, #0xa
               	b.hs	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	x20, #0xa
               	b.hi	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	x20, #0xa
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w21
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w21
               	cmp	x0, #0x8
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
