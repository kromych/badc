
two_d_float_array_partial_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003f6 <.text+0x136>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400345 <.text+0x85>
               	leaq	0xfde5(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdc5(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdb6(%rip), %rdi      # 0x41011e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfda8(%rip), %rdi      # 0x410125
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4008a7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003c7 <.text+0x107>
               	leaq	0xfd4e(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x4003c7 <.text+0x107>
               	leaq	0xfd32(%rip), %r12      # 0x410100
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
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
               	jmp	0x400420 <.text+0x160>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0xc, %r11
               	jge	0x400458 <.text+0x198>
               	jmp	0x40044c <.text+0x18c>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x400420 <.text+0x160>
               	xorq	%r11, %r11
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x40047c <.text+0x1bc>
               	xorq	%r15, %r15
               	leaq	-0x18(%rbp), %rax
               	movq	%r15, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x4005e9 <.text+0x329>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	0x400517 <.text+0x257>
               	jmp	0x4004a8 <.text+0x1e8>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x40047c <.text+0x1bc>
               	leaq	0xfca1(%rip), %r11      # 0x410150
               	movslq	-0x8(%rbp), %r9
               	shlq	$0x4, %r9
               	addq	%r9, %r11
               	movslq	-0x10(%rbp), %r8
               	shlq	$0x2, %r8
               	addq	%r8, %r11
               	movss	(%r11,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	leaq	0xfd36(%rip), %r11      # 0x410210
               	addq	%r9, %r11
               	addq	%r8, %r11
               	movss	(%r11,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	ucomisd	%xmm6, %xmm7
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4005e4 <.text+0x324>
               	jmp	0x40051c <.text+0x25c>
               	jmp	0x400436 <.text+0x176>
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x4002d7 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xfd9d(%rip), %r14      # 0x4102d0
               	movslq	-0x8(%rbp), %rbx
               	movslq	-0x10(%rbp), %r15
               	leaq	0xfc0e(%rip), %rsi      # 0x410150
               	movq	%rbx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rsi
               	movq	%r15, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rsi
               	movss	(%rsi,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	leaq	0xfc9a(%rip), %rsi      # 0x410210
               	addq	%rdx, %rsi
               	addq	%rcx, %rsi
               	movss	(%rsi,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	movsd	0x38(%rsp), %xmm0
               	movsd	0x30(%rsp), %xmm1
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x2, %al
               	callq	0x4008ad <fprintf>
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
               	jmp	0x400492 <.text+0x1d2>
               	movslq	-0x8(%rbp), %r15
               	cmpq	$0xc, %r15
               	jge	0x400691 <.text+0x3d1>
               	jmp	0x400615 <.text+0x355>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r15
               	addq	$0x1, %r15
               	movl	%r15d, (%rax)
               	jmp	0x4005e9 <.text+0x329>
               	leaq	-0x18(%rbp), %r15
               	movss	(%r15,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	leaq	0xfb22(%rip), %rbx      # 0x410150
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x4, %rax
               	addq	%rax, %rbx
               	movss	(%rbx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%rbx, %rax
               	addq	$0x4, %rax
               	movss	(%rax,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	addsd	%xmm5, %xmm7
               	addq	$0x8, %rbx
               	movss	(%rbx,%riz), %xmm5
               	cvtss2sd	%xmm5, %xmm5
               	addsd	%xmm5, %xmm7
               	addsd	%xmm7, %xmm6
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%r15,%riz)
               	jmp	0x4005ff <.text+0x33f>
               	movss	-0x18(%rbp,%riz), %xmm6
               	cvtss2sd	%xmm6, %xmm6
               	xorq	%r15, %r15
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm6
               	setne	%bl
               	movzbq	%bl, %rbx
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400737 <.text+0x477>
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x4002d7 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfc0b(%rip), %rbx      # 0x4102ee
               	movss	-0x18(%rbp,%riz), %xmm14
               	cvtss2sd	%xmm14, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movsd	0x28(%rsp), %xmm0
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x1, %al
               	callq	0x4008ad <fprintf>
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
               	addb	%al, 0x41(%rdx)
