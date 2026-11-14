
mixed_struct_gpr_abi.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fmov	d1, #3.00000000
               	ldr	d0, [x0, #0x8]
               	fmov	d2, #2.00000000
               	fmadd	d1, d0, d2, d1
               	fcvtzs	x0, d1
               	add	x0, x0, #0x2
               	cmp	x0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fcvtzs	x0, d0
               	add	x0, x0, #0x18
               	cmp	x0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
