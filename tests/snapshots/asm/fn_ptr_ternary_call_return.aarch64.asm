
fn_ptr_ternary_call_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ret

<fb>:
               	ret

<ga>:
               	add	x0, x0, #0x1
               	ret

<gb>:
               	add	x0, x0, #0x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x6789            // =26505
               	movk	x20, #0x2345, lsl #16
               	movk	x20, #0x1, lsl #32
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x20, [sp, #-0x10]!
               	mov	x9, x1
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x22, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x7890             // =30864
               	movk	x0, #0x3456, lsl #16
               	movk	x0, #0x12, lsl #32
               	str	x0, [sp, #-0x10]!
               	mov	x9, x1
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x21, x0
               	cmp	x22, x20
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x7891            // =30865
               	movk	x17, #0x3456, lsl #16
               	movk	x17, #0x12, lsl #32
               	cmp	x21, x17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x22
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
