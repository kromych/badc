
fn_ptr_ternary_call_return.aarch64:	file format elf64-littleaarch64

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

<fa>:
               	ret

<ga>:
               	add	x0, x0, #0x1
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x6789             // =26505
               	movk	x0, #0x2345, lsl #16
               	movk	x0, #0x1, lsl #32
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x7890             // =30864
               	movk	x0, #0x3456, lsl #16
               	movk	x0, #0x12, lsl #32
               	bl	<addr>
               	mov	x2, x0
               	mov	x0, #0x6789             // =26505
               	movk	x0, #0x2345, lsl #16
               	movk	x0, #0x1, lsl #32
               	cmp	x20, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
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
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
