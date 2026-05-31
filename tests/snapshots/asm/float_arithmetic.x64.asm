
float_arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, -0x8(%rbp)
               	movabsq	$0x4004000000000000, %r9 # imm = 0x4004000000000000
               	movq	-0x8(%rbp), %r11
               	movq	%r11, %xmm7
               	movq	%r9, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x4010000000000000, %r8 # imm = 0x4010000000000000
               	movq	%r11, %xmm14
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4002c1 <.text+0xa1>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%r9, %xmm7
               	movq	%rdi, %xmm15
               	subsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdi
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rdi, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400328 <.text+0x108>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r11
               	movq	%r11, %xmm7
               	movq	%r9, %xmm15
               	mulsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x400e000000000000, %rax # imm = 0x400E000000000000
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40038f <.text+0x16f>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%r9, %xmm7
               	movq	%rdi, %xmm15
               	divsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdi
               	movabsq	$0x3ff999999999999a, %rax # imm = 0x3FF999999999999A
               	movq	%rdi, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%r11b
               	movzbq	%r11b, %r11
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4003f6 <.text+0x1d6>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x18(%rbp), %r11
               	movabsq	$0x3ffb333333333333, %rax # imm = 0x3FFB333333333333
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400436 <.text+0x216>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x18(%rbp)
               	movq	-0x18(%rbp), %rdi
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%rdi, %xmm14
               	ucomisd	%xmm7, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4004be <.text+0x29e>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x18(%rbp), %rax
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40051d <.text+0x2fd>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	0x40055e <.text+0x33e>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	0x400594 <.text+0x374>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	0x4005d5 <.text+0x3b5>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	0x400616 <.text+0x3f6>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	0x400657 <.text+0x437>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	%rdi, %xmm14
               	movq	%r9, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	0x40068d <.text+0x46d>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movslq	%edi, %rax
               	cvtsi2sd	%rax, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x401c000000000000, %rdi # imm = 0x401C000000000000
               	movq	%rax, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4006ee <.text+0x4ce>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r9
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%r9, %xmm7
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %r9
               	movslq	%r9d, %rax
               	cmpq	$0x7, %rax
               	je	0x400740 <.text+0x520>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %r9
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%r9, %xmm7
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm7
               	cvttsd2si	%xmm7, %rax
               	movslq	%eax, %r9
               	cmpq	$0x8, %r9
               	je	0x400784 <.text+0x564>
               	movl	$0x10, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ffb333333333333, %rax # imm = 0x3FFB333333333333
               	movq	%rax, %xmm7
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm15
               	xorpd	%xmm15, %xmm7
               	movq	%xmm7, %r11
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %r9
               	movslq	%r9d, %rax
               	cmpq	$-0x1, %rax
               	je	0x4007dc <.text+0x5bc>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
