
two_d_stride_no_leak_across_exprs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d5 <.text+0x155>
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
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
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
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
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
               	callq	0x400737 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400399 <.text+0x119>
               	leaq	0xfd77(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400399 <.text+0x119>
               	leaq	0xfd58(%rip), %r12      # 0x4100f8
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
               	movq	%rdi, %r11
               	movzwq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x530, %rsp            # imm = 0x530
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x400(%rbp), %r11
               	movl	$0x7, %r9d
               	movw	%r9w, (%r11)
               	leaq	-0x400(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x2, %r9
               	movl	$0xb, %r8d
               	movw	%r8w, (%r9)
               	leaq	-0x400(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x4003cd <.text+0x14d>
               	movslq	%eax, %rbx
               	cmpq	$0x7, %rbx
               	je	0x400451 <.text+0x1d1>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x530, %rsp            # imm = 0x530
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x510(%rbp)
               	jmp	0x40045f <.text+0x1df>
               	movslq	-0x510(%rbp), %rax
               	cmpq	$0x40, %rax
               	jge	0x4004e0 <.text+0x260>
               	jmp	0x400494 <.text+0x214>
               	leaq	-0x510(%rbp), %rax
               	movslq	(%rax), %rbx
               	movq	%rbx, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rax)
               	jmp	0x40045f <.text+0x1df>
               	leaq	-0x508(%rbp), %r9
               	movslq	-0x510(%rbp), %rbx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	movq	%r9, %rdi
               	addq	%rax, %rdi
               	cvtsi2sd	%rbx, %xmm7
               	movabsq	$0x3fd0000000000000, %rbx # imm = 0x3FD0000000000000
               	movapd	%xmm7, %xmm6
               	movq	%rbx, %xmm15
               	mulsd	%xmm15, %xmm6
               	cvtsd2ss	%xmm6, %xmm15
               	movss	%xmm15, (%rdi,%riz)
               	jmp	0x400478 <.text+0x1f8>
               	leaq	-0x508(%rbp), %rdi
               	movq	%rdi, %rbx
               	addq	$0x20, %rbx
               	movss	(%rbx,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movabsq	$0x4000000000000000, %rbx # imm = 0x4000000000000000
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40054f <.text+0x2cf>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x530, %rsp            # imm = 0x530
               	popq	%rbp
               	retq
               	leaq	-0x400(%rbp), %r12
               	movq	%r12, %rdi
               	callq	0x4003cd <.text+0x14d>
               	leaq	-0x508(%rbp), %rax
               	movabsq	$0x4058c00000000000, %r12 # imm = 0x4058C00000000000
               	movq	%r12, %xmm14
               	cvtsd2ss	%xmm14, %xmm15
               	movss	%xmm15, (%rax,%riz)
               	leaq	-0x508(%rbp), %rax
               	movss	(%rax,%riz), %xmm7
               	cvtss2sd	%xmm7, %xmm7
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm7
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4005df <.text+0x35f>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x530, %rsp            # imm = 0x530
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x530, %rsp            # imm = 0x530
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
