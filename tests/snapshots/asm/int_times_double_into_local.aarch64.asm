
int_times_double_into_local.aarch64:	file format elf64-littleaarch64

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

<compute>:
               	sxtw	x1, w1
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	scvtf	d1, x1
               	fmul	d0, d0, d1
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
