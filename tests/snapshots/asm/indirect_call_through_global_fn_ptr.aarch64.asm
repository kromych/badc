
indirect_call_through_global_fn_ptr.aarch64:	file format elf64-littleaarch64

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

<do_add>:
               	add	x1, x1, x2
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<driver>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x23               // =35
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	mov	x9, x3
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	blr	x9
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x23               // =35
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	mov	x9, x3
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	blr	x9
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret
