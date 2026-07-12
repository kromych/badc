
function_type_typedef_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<sub>:
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	ret

<apply>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x1, w1
               	sxtw	x2, w2
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x5                // =5
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9                // =9
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	mov	x2, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
