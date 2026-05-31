
float_long_double_suffix.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	0x400289 <.text+0x69>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	0x4002c6 <.text+0xa6>
               	movl	$0xc, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	0x400303 <.text+0xe3>
               	movl	$0xd, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %r9 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x40034a <.text+0x12a>
               	movl	$0xe, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x420bf08eb0000000, %r11 # imm = 0x420BF08EB0000000
               	movq	%r11, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400391 <.text+0x171>
               	movl	$0xf, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r11d
               	cmpq	$0x7, %r11
               	je	0x4003b2 <.text+0x192>
               	movl	$0x10, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
