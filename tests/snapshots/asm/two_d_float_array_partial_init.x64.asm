
two_d_float_array_partial_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40040d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4008f7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003d9 <.text+0x119>
               	leaq	0xfd3f(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003d9 <.text+0x119>
               	leaq	0xfd20(%rip), %r12      # 0x410100
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	jmp	0x400437 <.text+0x177>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0xc, %r11
               	jge	0x400472 <.text+0x1b2>
               	jmp	0x400466 <.text+0x1a6>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400437 <.text+0x177>
               	xorq	%r8, %r8
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x400496 <.text+0x1d6>
               	xorq	%r15, %r15
               	leaq	-0x18(%rbp), %rax
               	movq	%r15, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x400624 <.text+0x364>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	0x400546 <.text+0x286>
               	jmp	0x4004c5 <.text+0x205>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x400496 <.text+0x1d6>
               	leaq	0xfc84(%rip), %r11      # 0x410150
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %r8
               	shlq	$0x4, %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movslq	-0x10(%rbp), %r11
               	movq	%r11, %rdi
               	shlq	$0x2, %rdi
               	movq	%r9, %r11
               	addq	%rdi, %r11
               	movss	(%r11,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	0xfd0d(%rip), %r11      # 0x410210
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movq	%r9, %r11
               	addq	%rdi, %r11
               	movss	(%r11,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	ucomisd	%xmm6, %xmm7
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x40061f <.text+0x35f>
               	jmp	0x40054b <.text+0x28b>
               	jmp	0x40044d <.text+0x18d>
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x4002d7 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xfd6e(%rip), %r14      # 0x4102d0
               	movslq	-0x8(%rbp), %rbx
               	movslq	-0x10(%rbp), %r15
               	leaq	0xfbdf(%rip), %rsi      # 0x410150
               	movq	%rbx, %rdx
               	shlq	$0x4, %rdx
               	movq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%r15, %rsi
               	shlq	$0x2, %rsi
               	movq	%rcx, %rax
               	addq	%rsi, %rax
               	movss	(%rax,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	leaq	0xfc65(%rip), %rax      # 0x410210
               	movq	%rax, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	%rsi, %rax
               	movss	(%rax,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x2, %al
               	callq	0x4008fd <fprintf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4004ac <.text+0x1ec>
               	movslq	-0x8(%rbp), %r15
               	cmpq	$0xc, %r15
               	jge	0x4006e6 <.text+0x426>
               	jmp	0x400653 <.text+0x393>
               	leaq	-0x8(%rbp), %r15
               	movslq	(%r15), %rax
               	movq	%rax, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%r15)
               	jmp	0x400624 <.text+0x364>
               	leaq	-0x18(%rbp), %rbx
               	movss	(%rbx,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	0xfae5(%rip), %rax      # 0x410150
               	movslq	-0x8(%rbp), %r15
               	movq	%r15, %r14
               	shlq	$0x4, %r14
               	movq	%rax, %r15
               	addq	%r14, %r15
               	movss	(%r15,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r15, %r14
               	addq	$0x4, %r14
               	movss	(%r14,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movapd	%xmm7, %xmm4
               	addsd	%xmm5, %xmm4
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movss	(%r14,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	movapd	%xmm4, %xmm7
               	addsd	%xmm5, %xmm7
               	movapd	%xmm6, %xmm5
               	addsd	%xmm7, %xmm5
               	cvtsd2ss	%xmm5, %xmm15
               	movss	%xmm15, (%rbx,%riz)
               	jmp	0x40063a <.text+0x37a>
               	movss	-0x18(%rbp,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	xorq	%rbx, %rbx
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm5
               	setne	%r14b
               	movzbq	%r14b, %r14
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x40078c <.text+0x4cc>
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x4002d7 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfbb6(%rip), %r14      # 0x4102ee
               	movss	-0x18(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x1, %al
               	callq	0x4008fd <fprintf>
               	movslq	%eax, %rax
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
