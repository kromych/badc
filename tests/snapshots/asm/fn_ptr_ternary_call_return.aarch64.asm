
fn_ptr_ternary_call_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, #0x6789            // =26505
               	movk	x21, #0x2345, lsl #16
               	movk	x21, #0x1, lsl #32
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x9, x0
               	mov	x0, x21
               	blr	x9
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7890             // =30864
               	movk	x1, #0x3456, lsl #16
               	movk	x1, #0x12, lsl #32
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	mov	x2, x0
               	cmp	x20, x21
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x17, #0x7891            // =30865
               	movk	x17, #0x3456, lsl #16
               	movk	x17, #0x12, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
