
do_while_zero_returns.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<from_value>:
               	cmp	w0, #0x0
               	b.ge	<addr>
               	neg	x0, x0
               	ret
               	add	x0, x0, #0x1
               	ret

<classify>:
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ret
               	cmp	w0, #0x0
               	mov	x16, #0x1               // =1
               	mov	x17, #-0x1              // =-1
               	csel	x0, x16, x17, gt
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
