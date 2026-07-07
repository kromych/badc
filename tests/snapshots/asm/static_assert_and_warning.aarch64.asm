
static_assert_and_warning.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ne
               	ret
