
switch_nested_case_in_compound.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x7
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	add	x0, x0, #0x2
               	add	x1, x0, #0x4
               	b	<addr>
               	mov	x1, #0x4000             // =16384
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x1064             // =4196
               	b	<addr>
               	mov	x1, #0x2064             // =8292
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x106b            // =4203
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	add	x0, x0, #0x2
               	add	x1, x0, #0x4
               	b	<addr>
               	mov	x1, #0x4000             // =16384
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x1064             // =4196
               	b	<addr>
               	mov	x1, #0x2064             // =8292
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
