
fn_ptr_typedef_multi_declarator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x6789             // =26505
               	movk	x0, #0x2345, lsl #16
               	movk	x0, #0x1, lsl #32
               	ret

<ident>:
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x80]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x9, x20
               	blr	x9
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x9, x21
               	blr	x9
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	sub	x0, x29, #0x28
               	mov	x9, x21
               	blr	x9
               	sub	x1, x29, #0x28
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x28
               	mov	x9, x21
               	blr	x9
               	sub	x1, x29, #0x28
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x38
               	str	x20, [x0]
               	sub	x0, x29, #0x38
               	str	x20, [x0, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x0, [x0]
               	mov	x9, x0
               	blr	x9
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x38
               	ldr	x0, [x0, #0x8]
               	mov	x9, x0
               	blr	x9
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
