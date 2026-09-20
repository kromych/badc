
inline_nonleaf_const_switch.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	stur	wzr, [x29, #-0x18]
               	stur	wzr, [x29, #-0x10]
               	stur	wzr, [x29, #-0x8]
               	mov	x0, #0x3344             // =13124
               	movk	x0, #0x1122, lsl #16
               	stur	w0, [x29, #-0x18]
               	mov	x0, #0x3344             // =13124
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x44               // =68
               	sturb	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	eor	x0, x0, x17
               	ldur	w1, [x29, #-0x10]
               	mov	x17, #0x3344            // =13124
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0x44              // =68
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
