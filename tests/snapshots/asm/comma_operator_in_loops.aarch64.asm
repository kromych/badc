
comma_operator_in_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x240              // =576
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	add	x20, x20, #0xa
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	add	x20, x20, #0x64
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	b	<addr>
               	add	x20, x20, #0x3e8
               	b	<addr>
               	mov	x17, #0x869f            // =34463
               	movk	x17, #0x1, lsl #16
               	add	x20, x20, x17
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w21
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	b	<addr>
               	add	x20, x20, #0x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sub	x0, x20, #0x456
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
