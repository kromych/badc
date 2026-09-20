
double_to_uint64.aarch64:	file format elf64-littleaarch64

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
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	mov	x16, #0x43e0000000000000 // =4890909195324358656
               	fmov	d2, x16
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x8]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d0, x16
               	fmov	d4, #-5.00000000
               	fcvtzu	x0, d1
               	mov	x17, #0x89e80000        // =2313682944
               	movk	x17, #0x2304, lsl #32
               	movk	x17, #0x8ac7, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fcvtzu	x0, d2
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcvtzu	x0, d3
               	mov	x17, #0xc5080000        // =3305635840
               	movk	x17, #0xd8a1, lsl #32
               	movk	x17, #0xf9cc, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcvtzu	x0, d0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fcvtzs	x0, d4
               	mov	x17, #-0x5              // =-5
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fcvtzs	x0, d0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x89e80000         // =2313682944
               	movk	x0, #0x2304, lsl #32
               	movk	x0, #0x8ac7, lsl #48
               	ucvtf	d0, x0
               	fcvtzu	x1, d0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
