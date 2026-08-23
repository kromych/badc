
unsigned_div_in_assign.aarch64:	file format elf64-littleaarch64

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

<outer>:
               	mov	x2, x0
               	ldr	x0, [x2]
               	lsr	x1, x0, #3
               	mov	x3, #0x5556             // =21846
               	movk	x3, #0x5555, lsl #16
               	movk	x3, #0x5555, lsl #32
               	movk	x3, #0x5555, lsl #48
               	umulh	x1, x1, x3
               	mov	x2, #0x2493             // =9363
               	movk	x2, #0x9249, lsl #16
               	movk	x2, #0x4924, lsl #32
               	movk	x2, #0x2492, lsl #48
               	umulh	x2, x0, x2
               	sub	x3, x0, x2
               	lsr	x3, x3, #1
               	add	x2, x3, x2
               	lsr	x2, x2, #2
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ret
