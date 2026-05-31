
ternary_middle_comma.x64:	file format elf64-x86-64

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
               	callq	0x400c47 <dlsym>
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
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfd31(%rip), %r9       # 0x410150
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r11)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r11)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	movl	$0x2a, %r10d
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r9
               	movslq	%r9d, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x80, %r9
               	jae	0x400496 <.text+0x1d6>
               	leaq	-0x8(%rbp), %r11
               	movq	0x28(%rsp), %r9
               	movslq	%r9d, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r11)
               	movl	$0x1, %edi
               	movq	%rdi, -0x88(%rbp)
               	jmp	0x4004a7 <.text+0x1e7>
               	movl	$0x63, %edi
               	movq	%rdi, -0x88(%rbp)
               	jmp	0x4004a7 <.text+0x1e7>
               	movq	-0x88(%rbp), %rdi
               	movslq	%edi, %r9
               	cmpq	$0x1, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x90(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x400507 <.text+0x247>
               	leaq	-0x8(%rbp), %r11
               	movzbq	(%r11), %r9
               	xorq	$0x2a, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x90(%rbp)
               	jmp	0x400507 <.text+0x247>
               	movq	-0x90(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x400567 <.text+0x2a7>
               	leaq	0xfc32(%rip), %r12      # 0x410154
               	movslq	%edi, %r14
               	leaq	-0x8(%rbp), %rdi
               	movzbq	(%rdi), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c4d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r15
               	leaq	0xfbf8(%rip), %rax      # 0x41016a
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r15)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%r15)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%r15)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%r15)
               	popq	%r11
               	movq	%r15, %r14
               	movq	0x28(%rsp), %r14
               	movslq	%r14d, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x80, %r14
               	jae	0x4005e1 <.text+0x321>
               	leaq	-0x20(%rbp), %rax
               	movq	0x28(%rsp), %r14
               	movslq	%r14d, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, -0x98(%rbp)
               	jmp	0x4005f3 <.text+0x333>
               	movl	$0x63, %r15d
               	movq	%r15, -0x98(%rbp)
               	jmp	0x4005f3 <.text+0x333>
               	movq	-0x98(%rbp), %r15
               	movslq	%r15d, %r14
               	cmpq	$0x1, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xa0(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400653 <.text+0x393>
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %r14
               	xorq	$0x2a, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xa0(%rbp)
               	jmp	0x400653 <.text+0x393>
               	movq	-0xa0(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4006b3 <.text+0x3f3>
               	leaq	0xfb00(%rip), %r12      # 0x41016e
               	movslq	%r15d, %r15
               	leaq	-0x20(%rbp), %r14
               	movzbq	(%r14), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400c4d <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rbx
               	leaq	0xfac6(%rip), %rax      # 0x410184
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%rbx)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%rbx)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%rbx)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%rbx)
               	popq	%r11
               	movq	%rbx, %r15
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x80, %r15
               	jae	0x40072c <.text+0x46c>
               	leaq	-0x30(%rbp), %rax
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	andq	$0xff, %r15
               	movb	%r15b, (%rax)
               	movl	$0x1, %ebx
               	movq	%rbx, -0xa8(%rbp)
               	jmp	0x40073d <.text+0x47d>
               	movl	$0x63, %ebx
               	movq	%rbx, -0xa8(%rbp)
               	jmp	0x40073d <.text+0x47d>
               	movq	-0xa8(%rbp), %rbx
               	movslq	%ebx, %r15
               	cmpq	$0x1, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x40079d <.text+0x4dd>
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %r15
               	xorq	$0x2a, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	jmp	0x40079d <.text+0x4dd>
               	movq	-0xb0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x4007fd <.text+0x53d>
               	leaq	0xf9d0(%rip), %r14      # 0x410188
               	movslq	%ebx, %rbx
               	leaq	-0x30(%rbp), %r15
               	movzbq	(%r15), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x400c4d <printf>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x40(%rbp)
               	movl	%r12d, -0x48(%rbp)
               	movl	%r12d, -0x50(%rbp)
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	0x400861 <.text+0x5a1>
               	movl	$0x1, %r12d
               	movl	%r12d, -0x40(%rbp)
               	movl	$0x2, %eax
               	movl	%eax, -0x48(%rbp)
               	movl	$0x3, %r12d
               	movl	%r12d, -0x50(%rbp)
               	movslq	-0x40(%rbp), %rax
               	movslq	-0x48(%rbp), %r12
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movslq	-0x50(%rbp), %r12
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x400877 <.text+0x5b7>
               	movabsq	$-0x1, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x400877 <.text+0x5b7>
               	movq	-0xb8(%rbp), %rax
               	movslq	%eax, %r12
               	cmpq	$0x6, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xd0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4008c3 <.text+0x603>
               	movslq	-0x40(%rbp), %rbx
               	cmpq	$0x1, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xd0(%rbp)
               	jmp	0x4008c3 <.text+0x603>
               	movq	-0xd0(%rbp), %rbx
               	movq	%rbx, -0xc8(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x4008fd <.text+0x63d>
               	movslq	-0x48(%rbp), %r12
               	cmpq	$0x2, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x4008fd <.text+0x63d>
               	movq	-0xc8(%rbp), %r12
               	movq	%r12, -0xc0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x400937 <.text+0x677>
               	movslq	-0x50(%rbp), %rbx
               	cmpq	$0x3, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xc0(%rbp)
               	jmp	0x400937 <.text+0x677>
               	movq	-0xc0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x4009a8 <.text+0x6e8>
               	leaq	0xf84c(%rip), %r15      # 0x41019e
               	movslq	%eax, %r12
               	movslq	-0x40(%rbp), %rbx
               	movslq	-0x48(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movslq	-0x50(%rbp), %r14
               	movq	%r15, %rdi
               	movq	%r14, %r8
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movq	0x20(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x400c4d <printf>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %r14
               	leaq	0xf808(%rip), %rax      # 0x4101bb
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r14)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%r14)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%r14)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%r14)
               	popq	%r11
               	movq	%r14, %rbx
               	movl	$0xc8, %ebx
               	movslq	%ebx, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x80, %rax
               	jae	0x400a1c <.text+0x75c>
               	leaq	-0x60(%rbp), %r14
               	movslq	%ebx, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%r14)
               	movl	$0x1, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	0x400a2d <.text+0x76d>
               	movl	$0x63, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	0x400a2d <.text+0x76d>
               	movq	-0xd8(%rbp), %rax
               	movslq	%eax, %rbx
               	cmpq	$0x63, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe0(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400a86 <.text+0x7c6>
               	leaq	-0x60(%rbp), %r14
               	movzbq	(%r14), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe0(%rbp)
               	jmp	0x400a86 <.text+0x7c6>
               	movq	-0xe0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400ae6 <.text+0x826>
               	leaq	0xf71e(%rip), %r15      # 0x4101bf
               	movslq	%eax, %r14
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c4d <printf>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
