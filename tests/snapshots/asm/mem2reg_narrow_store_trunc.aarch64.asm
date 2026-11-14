
mem2reg_narrow_store_trunc.aarch64:	file format elf64-littleaarch64

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

<check>:
               	and	x0, x0, #0xff
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cmp	w0, #0x2c
               	csel	x0, x1, x2, eq
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
