
scanf_fscanf_binding.aarch64:	file format elf64-littleaarch64

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

<__c5_lazy_stream>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cbz	x1, <addr>
               	ldr	x0, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x10]
               	stur	w1, [x29, #-0x8]
               	mov	x17, #0x869f            // =34463
               	movk	x17, #0x1, lsl #16
               	cmp	w0, w17
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x8
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
