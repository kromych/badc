
do_while_zero_returns.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<classify>:
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	cmp	x0, #0x0
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>

<main>:
               	mov	x0, #0x2a               // =42
               	mov	x0, #0x5                // =5
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	ret
