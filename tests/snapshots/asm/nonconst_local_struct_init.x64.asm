
nonconst_local_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400414 <.text+0x154>
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
               	callq	0x400f17 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x2a, %r10d
               	movq	%r10, 0x20(%rsp)
               	movl	$0x63, %r10d
               	movq	%r10, 0x28(%rsp)
               	leaq	-0x18(%rbp), %r8
               	leaq	0xfcfd(%rip), %rdi      # 0x410150
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	popq	%rax
               	movq	%r8, %rsi
               	movq	0x20(%rsp), %rsi
               	movslq	%esi, %rsi
               	leaq	-0x18(%rbp), %rdi
               	movl	%esi, (%rdi)
               	movq	0x28(%rsp), %r8
               	movslq	%r8d, %r8
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x4, %rsi
               	movl	%r8d, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %rsi
               	cmpq	$0x2a, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	cmpq	$0x0, %rdi
               	jne	0x4004db <.text+0x21b>
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rsi
               	cmpq	$0x63, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	jmp	0x4004db <.text+0x21b>
               	movq	-0xa0(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	0x40054b <.text+0x28b>
               	leaq	0xfc62(%rip), %r14      # 0x410158
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %r15
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400f1d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	leaq	0xfc12(%rip), %rdx      # 0x410168
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%r12)
               	popq	%rax
               	movq	%r12, %r15
               	movl	$0x7, %r15d
               	leaq	-0x20(%rbp), %rdx
               	movl	%r15d, (%rdx)
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x20(%rbp), %rdx
               	movq	%rdx, %r15
               	addq	$0x4, %r15
               	movl	%r12d, (%r15)
               	leaq	-0x20(%rbp), %rdx
               	movslq	(%rdx), %r15
               	cmpq	$0x7, %r15
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xa8(%rbp)
               	cmpq	$0x0, %rdx
               	jne	0x4005de <.text+0x31e>
               	leaq	-0x20(%rbp), %r15
               	movq	%r15, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %r15
               	cmpq	$0x63, %r15
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xa8(%rbp)
               	jmp	0x4005de <.text+0x31e>
               	movq	-0xa8(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	0x400650 <.text+0x390>
               	leaq	0xfb77(%rip), %r14      # 0x410170
               	leaq	-0x20(%rbp), %rdx
               	movslq	(%rdx), %r15
               	leaq	-0x20(%rbp), %rdx
               	movq	%rdx, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400f1d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rbx
               	leaq	0xfb25(%rip), %r12      # 0x410180
               	pushq	%rax
               	movq	(%r12), %rax
               	movq	%rax, (%rbx)
               	popq	%rax
               	movq	%rbx, %r15
               	movl	$0xb, %r14d
               	movq	%r14, %rdi
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %r12
               	leaq	-0x28(%rbp), %r14
               	movl	%r12d, (%r14)
               	movl	$0x16, %r15d
               	movq	%r15, %rdi
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %r14
               	leaq	-0x28(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x4, %r12
               	movl	%r14d, (%r12)
               	leaq	-0x28(%rbp), %r15
               	movslq	(%r15), %r12
               	cmpq	$0xb, %r12
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4006f8 <.text+0x438>
               	leaq	-0x28(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %r12
               	cmpq	$0x16, %r12
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	jmp	0x4006f8 <.text+0x438>
               	movq	-0xb0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400769 <.text+0x4a9>
               	leaq	0xfa75(%rip), %rbx      # 0x410188
               	leaq	-0x28(%rbp), %r15
               	movslq	(%r15), %r12
               	leaq	-0x28(%rbp), %r15
               	movq	%r15, %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f1d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r15
               	leaq	0xfa24(%rip), %r14      # 0x410198
               	pushq	%rax
               	movq	(%r14), %rax
               	movq	%rax, (%r15)
               	movzbq	0x8(%r14), %rax
               	movb	%al, 0x8(%r15)
               	movzbq	0x9(%r14), %rax
               	movb	%al, 0x9(%r15)
               	movzbq	0xa(%r14), %rax
               	movb	%al, 0xa(%r15)
               	movzbq	0xb(%r14), %rax
               	movb	%al, 0xb(%r15)
               	popq	%rax
               	movq	%r15, %r12
               	movq	0x20(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x38(%rbp), %r14
               	movl	%r12d, (%r14)
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	leaq	-0x38(%rbp), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movl	%r15d, (%r12)
               	leaq	-0x38(%rbp), %r14
               	movslq	(%r14), %r12
               	cmpq	$0x2a, %r12
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc0(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400822 <.text+0x562>
               	leaq	-0x38(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %r12
               	cmpq	$0x0, %r12
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc0(%rbp)
               	jmp	0x400822 <.text+0x562>
               	movq	-0xc0(%rbp), %r14
               	movq	%r14, -0xb8(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400869 <.text+0x5a9>
               	leaq	-0x38(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movslq	(%r14), %r12
               	cmpq	$0x63, %r12
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xb8(%rbp)
               	jmp	0x400869 <.text+0x5a9>
               	movq	-0xb8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4008ed <.text+0x62d>
               	leaq	0xf920(%rip), %rbx      # 0x4101a4
               	leaq	-0x38(%rbp), %r14
               	movslq	(%r14), %r12
               	leaq	-0x38(%rbp), %r14
               	movq	%r14, %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %r14
               	leaq	-0x38(%rbp), %r15
               	movq	%r15, %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f1d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %r15
               	leaq	0xf8bf(%rip), %rdx      # 0x4101b7
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%r15)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%r15)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%r15)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%r15)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%r15)
               	popq	%rax
               	movq	%r15, %r14
               	movq	0x28(%rsp), %r14
               	movslq	%r14d, %r14
               	leaq	-0x48(%rbp), %rdx
               	movq	%rdx, %r15
               	addq	$0x8, %r15
               	movl	%r14d, (%r15)
               	movq	0x20(%rsp), %rdx
               	movslq	%edx, %rdx
               	leaq	-0x48(%rbp), %r15
               	movl	%edx, (%r15)
               	leaq	-0x48(%rbp), %r14
               	movslq	(%r14), %r15
               	cmpq	$0x2a, %r15
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xd0(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x4009a5 <.text+0x6e5>
               	leaq	-0x48(%rbp), %r15
               	movq	%r15, %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %r15
               	cmpq	$0x0, %r15
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xd0(%rbp)
               	jmp	0x4009a5 <.text+0x6e5>
               	movq	-0xd0(%rbp), %r14
               	movq	%r14, -0xc8(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x4009ec <.text+0x72c>
               	leaq	-0x48(%rbp), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movslq	(%r14), %r15
               	cmpq	$0x63, %r15
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc8(%rbp)
               	jmp	0x4009ec <.text+0x72c>
               	movq	-0xc8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x400a71 <.text+0x7b1>
               	leaq	0xf7bc(%rip), %rbx      # 0x4101c3
               	leaq	-0x48(%rbp), %r14
               	movslq	(%r14), %r15
               	leaq	-0x48(%rbp), %r14
               	movq	%r14, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %r14
               	leaq	-0x48(%rbp), %r12
               	movq	%r12, %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400f1d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movl	$0x5, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r12
               	leaq	0xf75a(%rip), %rdx      # 0x4101d6
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%r12)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%r12)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%r12)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%r12)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%r12)
               	popq	%rax
               	movq	%r12, %r14
               	movq	0x20(%rsp), %r14
               	movslq	%r14d, %r14
               	leaq	-0x58(%rbp), %rdx
               	movl	%r14d, (%rdx)
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x58(%rbp), %rdx
               	movq	%rdx, %r14
               	addq	$0x8, %r14
               	movl	%r12d, (%r14)
               	leaq	-0x58(%rbp), %rdx
               	movslq	(%rdx), %r14
               	cmpq	$0x2a, %r14
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xe0(%rbp)
               	cmpq	$0x0, %rdx
               	jne	0x400b2e <.text+0x86e>
               	leaq	-0x58(%rbp), %r14
               	movq	%r14, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %r14
               	cmpq	$0x0, %r14
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xe0(%rbp)
               	jmp	0x400b2e <.text+0x86e>
               	movq	-0xe0(%rbp), %rdx
               	movq	%rdx, -0xd8(%rbp)
               	cmpq	$0x0, %rdx
               	jne	0x400b75 <.text+0x8b5>
               	leaq	-0x58(%rbp), %r14
               	movq	%r14, %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %r14
               	cmpq	$0x63, %r14
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xd8(%rbp)
               	jmp	0x400b75 <.text+0x8b5>
               	movq	-0xd8(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	0x400bf9 <.text+0x939>
               	leaq	0xf652(%rip), %rbx      # 0x4101e2
               	leaq	-0x58(%rbp), %rdx
               	movslq	(%rdx), %r14
               	leaq	-0x58(%rbp), %rdx
               	movq	%rdx, %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %r12
               	leaq	-0x58(%rbp), %r15
               	movq	%r15, %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400f1d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movl	$0x6, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %r15
               	leaq	0xf5f1(%rip), %rdx      # 0x4101f5
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%r15)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%r15)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%r15)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%r15)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%r15)
               	popq	%rax
               	movq	%r15, %r12
               	leaq	-0x78(%rbp), %rdx
               	leaq	0xf5c3(%rip), %r12      # 0x410201
               	pushq	%rax
               	movq	(%r12), %rax
               	movq	%rax, (%rdx)
               	movzbq	0x8(%r12), %rax
               	movb	%al, 0x8(%rdx)
               	movzbq	0x9(%r12), %rax
               	movb	%al, 0x9(%rdx)
               	movzbq	0xa(%r12), %rax
               	movb	%al, 0xa(%rdx)
               	movzbq	0xb(%r12), %rax
               	movb	%al, 0xb(%rdx)
               	popq	%rax
               	movq	%rdx, %r15
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	leaq	-0x78(%rbp), %r12
               	movq	%r12, %rdx
               	addq	$0x4, %rdx
               	movl	%r15d, (%rdx)
               	leaq	-0x78(%rbp), %r12
               	movslq	(%r12), %rdx
               	cmpq	$0x0, %rdx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x400ce3 <.text+0xa23>
               	leaq	-0x78(%rbp), %rdx
               	movq	%rdx, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rdx
               	cmpq	$0x63, %rdx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf0(%rbp)
               	jmp	0x400ce3 <.text+0xa23>
               	movq	-0xf0(%rbp), %r12
               	movq	%r12, -0xe8(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x400d2b <.text+0xa6b>
               	leaq	-0x78(%rbp), %rdx
               	movq	%rdx, %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %rdx
               	cmpq	$0x0, %rdx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe8(%rbp)
               	jmp	0x400d2b <.text+0xa6b>
               	movq	-0xe8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400db0 <.text+0xaf0>
               	leaq	0xf4c7(%rip), %rbx      # 0x41020d
               	leaq	-0x78(%rbp), %r12
               	movslq	(%r12), %r14
               	leaq	-0x78(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %r12
               	leaq	-0x78(%rbp), %r15
               	movq	%r15, %rdx
               	addq	$0x8, %rdx
               	movslq	(%rdx), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400f1d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movl	$0x7, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x400e0f <.text+0xb4f>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400e96 <.text+0xbd6>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400e8d <.text+0xbcd>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400e91 <.text+0xbd1>
               	andb	%ch, 0x74(%rax)
               	je	0x400ea1 <.text+0xbe1>
               	jae	0x400e6d <.text+0xbad>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400ea9 <.text+0xbe9>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400f23 <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400ecb <.text+0xc0b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400f52 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400f49 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400f4d <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x400f5d <exit+0x3a>
               	jae	0x400f29 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400f65 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf1c3(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf1c5(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf1c7(%rip)           # 0x4100f0
