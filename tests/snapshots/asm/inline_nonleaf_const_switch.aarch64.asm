
inline_nonleaf_const_switch.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	w1, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<put2>:
               	mov	w1, w1
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	strh	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<put4>:
               	mov	w1, w1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	sub	x0, x29, #0x8
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	bl	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	bl	<addr>
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	eor	x0, x0, x17
               	ldur	w1, [x29, #-0x10]
               	mov	x17, #0x3344            // =13124
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	ldur	w1, [x29, #-0x18]
               	mov	x17, #0x44              // =68
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	mov	w0, w0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
