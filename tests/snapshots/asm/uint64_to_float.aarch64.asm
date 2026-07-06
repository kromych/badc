
uint64_to_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	mov	x1, #0xad2              // =2770
               	movk	x1, #0xeb1f, lsl #16
               	movk	x1, #0xa98c, lsl #32
               	movk	x1, #0xab54, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x64               // =100
               	ucvtf	d0, x0
               	mov	x4, #0x43e0000000000000 // =4890909195324358656
               	fmov	d17, x4
               	fcmp	d0, d17
               	cset	x4, ne
               	cbz	x4, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ucvtf	d0, x1
               	mov	x1, #0x63e1             // =25569
               	movk	x1, #0x319d, lsl #16
               	movk	x1, #0x6a95, lsl #32
               	movk	x1, #0x43e5, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ucvtf	d0, x2
               	mov	x1, #0x43f0000000000000 // =4895412794951729152
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ucvtf	d0, x3
               	mov	x1, #0x4059000000000000 // =4636737291354636288
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	d0, x2
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ucvtf	d0, x0
               	fcvt	s0, d0
               	mov	x0, #0x5f000000         // =1593835520
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
