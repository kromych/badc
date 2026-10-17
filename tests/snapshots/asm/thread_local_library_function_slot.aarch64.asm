
thread_local_library_function_slot.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	ldr	x0, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	cmp	x0, x3
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldr	x3, [x1]
               	cmp	x3, x2
               	cset	x2, eq
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	cmp	x0, #0x3
               	cset	x0, eq
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	cmp	x0, #0x2
               	cset	x1, eq
               	cmp	w1, #0x0
               	cset	x0, eq
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>

<__c5_sys_strlen>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
