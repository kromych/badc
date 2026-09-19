
uint64_to_float.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	mov	x2, #0xad2              // =2770
               	movk	x2, #0xeb1f, lsl #16
               	movk	x2, #0xa98c, lsl #32
               	movk	x2, #0xab54, lsl #48
               	mov	x1, #-0x1               // =-1
               	mov	x3, #0x64               // =100
               	ucvtf	d0, x0
               	mov	x16, #0x43e0000000000000 // =4890909195324358656
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ucvtf	d0, x2
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ucvtf	d0, x1
               	mov	x16, #0x43f0000000000000 // =4895412794951729152
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ucvtf	d0, x3
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	scvtf	d0, x1
               	fmov	d1, #1.00000000
               	fneg	d1, d1
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ucvtf	s0, x0
               	mov	x16, #0x5f000000        // =1593835520
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
