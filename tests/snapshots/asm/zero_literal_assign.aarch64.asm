
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
               	ret

<zero_designated>:
               	stp	xzr, xzr, [x0]
               	ret

<zero_bytes>:
               	strh	wzr, [x0]
               	strb	wzr, [x0, #0x2]
               	ret

<zero_mixed>:
               	str	xzr, [x0]
               	ret

<zero_tail>:
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	strb	wzr, [x0, #0xc]
               	ret

<zero_union>:
               	stp	xzr, xzr, [x0]
               	ret

<zero_chained>:
               	stp	xzr, xzr, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
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
               	ret

<copy_nonzero>:
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	ret

<zero_local>:
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
