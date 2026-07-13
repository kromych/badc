
inline_asm_extended_operands.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x2, w2
               	lsl	x3, x0, x2
               	mov	x0, #0x40               // =64
               	sub	x0, x0, x2
               	sxtw	x0, w0
               	lsr	x0, x1, x0
               	orr	x0, x3, x0
               	ret

<shr_double>:
               	mov	x3, x0
               	sxtw	x2, w2
               	lsr	x1, x1, x2
               	mov	x0, #0x40               // =64
               	sub	x0, x0, x2
               	sxtw	x0, w0
               	lsl	x0, x3, x0
               	orr	x0, x1, x0
               	ret

<bswap32>:
               	mov	w0, w0
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #24
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	w0, w0
               	ret

<bswap64>:
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #56
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #48
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #40
               	orr	x1, x1, x2
               	lsr	x2, x0, #24
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	lsr	x2, x0, #32
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #24
               	orr	x1, x1, x2
               	lsr	x2, x0, #40
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #48
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #56
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	ret

<tsc_read>:
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ret
