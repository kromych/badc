
ternary_arith_common_type.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	b	<addr>
               	mov	x2, #0x1                // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
