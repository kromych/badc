
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
               	mov	x1, #0x3d00             // =15616
               	movk	x1, #0x6091, lsl #16
               	movk	x1, #0x58e4, lsl #32
               	movk	x1, #0x43e1, lsl #48
               	mov	x2, #0x43e0000000000000 // =4890909195324358656
               	mov	x3, #0xa100             // =41216
               	movk	x3, #0x1438, lsl #16
               	movk	x3, #0x399b, lsl #32
               	movk	x3, #0x43ef, lsl #48
               	mov	x0, #0x4059000000000000 // =4636737291354636288
               	mov	x4, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x4
               	fneg	d0, d16
               	fmov	d16, x1
               	fcvtzu	x1, d16
               	mov	x17, #0x89e80000        // =2313682944
               	movk	x17, #0x2304, lsl #32
               	movk	x17, #0x8ac7, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d16, x2
               	fcvtzu	x1, d16
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d16, x3
               	fcvtzu	x1, d16
               	mov	x17, #0xc5080000        // =3305635840
               	movk	x17, #0xd8a1, lsl #32
               	movk	x17, #0xf9cc, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d16, x0
               	fcvtzu	x1, d16
               	cmp	x1, #0x64
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fcvtzs	x1, d0
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d16, x0
               	fcvtzs	x0, d16
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
