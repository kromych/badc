
zero_literal_assign.aarch64:	file format elf64-littleaarch64

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

<zero_pointer>:
               	stp	xzr, xzr, [x0]
               	mov	x0, #0x0                // =0
               	ret

<zero_designated>:
               	stp	xzr, xzr, [x0]
               	mov	x0, #0x0                // =0
               	ret

<zero_bytes>:
               	strh	wzr, [x0]
               	strb	wzr, [x0, #0x2]
               	mov	x0, #0x0                // =0
               	ret

<zero_mixed>:
               	str	xzr, [x0]
               	mov	x0, #0x0                // =0
               	ret

<zero_tail>:
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	strb	wzr, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	ret

<zero_union>:
               	stp	xzr, xzr, [x0]
               	mov	x0, #0x0                // =0
               	ret

<zero_chained>:
               	stp	xzr, xzr, [x0]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	ret

<zero_above_bound>:
               	mov	x16, x0
               	add	x17, x16, #0x240
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	stp	xzr, xzr, [x16]
               	str	xzr, [x16, #0x10]
               	mov	x0, #0x0                // =0
               	ret

<copy_nonzero>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<zero_local>:
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
