
switch_multilabel.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x42
               	b.lt	<addr>
               	cmp	x0, #0x62
               	b.lt	<addr>
               	cmp	x0, #0x63
               	b.lt	<addr>
               	cmp	x0, #0x64
               	b.lt	<addr>
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	cmp	x0, #0x63
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x62
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x61
               	b.lt	<addr>
               	cmp	x0, #0x61
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x42
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x32
               	b.lt	<addr>
               	cmp	x0, #0x33
               	b.lt	<addr>
               	cmp	x0, #0x41
               	b.lt	<addr>
               	cmp	x0, #0x41
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x33
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0x32
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x31
               	b.lt	<addr>
               	cmp	x0, #0x31
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x30
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x61               // =97
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x62               // =98
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x42               // =66
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x30               // =48
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x33               // =51
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f               // =63
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
