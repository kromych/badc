
optimize_keeps_assert.aarch64:	file format elf64-littleaarch64

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

<__c5_assert_fail>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x3, #0x7                // =7
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	brk	#0x1
