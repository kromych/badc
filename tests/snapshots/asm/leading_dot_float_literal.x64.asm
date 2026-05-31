
leading_dot_float_literal.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003b6 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
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
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4006a7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
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
               	subq	$0x30, %rsp
               	movabsq	$0x3fe0000000000000, %r11 # imm = 0x3FE0000000000000
               	leaq	-0x8(%rbp), %r9
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%r9,%riz)
               	movabsq	$0x3fd0000000000000, %r9 # imm = 0x3FD0000000000000
               	movabsq	$0x4039000000000000, %r8 # imm = 0x4039000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	%r11, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	movl	$0x1, %edi
               	movl	%edi, -0x28(%rbp)
               	movss	-0x8(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40045a <.text+0x1da>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x40045a <.text+0x1da>
               	movabsq	$0x3fd0000000000000, %r11 # imm = 0x3FD0000000000000
               	movq	%r9, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x40049f <.text+0x21f>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x40049f <.text+0x21f>
               	movabsq	$0x4039000000000000, %r11 # imm = 0x4039000000000000
               	movq	%r8, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%r8b
               	movzbq	%r8b, %r8
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4004e4 <.text+0x264>
               	xorq	%r11, %r11
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x4004e4 <.text+0x264>
               	movss	-0x20(%rbp,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x3fe0000000000000, %r8 # imm = 0x3FE0000000000000
               	movq	%r8, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%r11b
               	movzbq	%r11b, %r11
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x400531 <.text+0x2b1>
               	xorq	%r8, %r8
               	movl	%r8d, -0x28(%rbp)
               	jmp	0x400531 <.text+0x2b1>
               	movslq	-0x28(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x400551 <.text+0x2d1>
               	movl	$0x7, %r11d
               	movq	%r11, -0x30(%rbp)
               	jmp	0x40055d <.text+0x2dd>
               	xorq	%r11, %r11
               	movq	%r11, -0x30(%rbp)
               	jmp	0x40055d <.text+0x2dd>
               	movq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
