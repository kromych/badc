
ternary_middle_comma.x64:	file format elf64-x86-64

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
               	callq	0x400c77 <dlsym>
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
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfd1a(%rip), %r9       # 0x410150
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
               	andq	%r9, %r11
               	cmpq	$0x80, %r11
               	jae	0x4004b1 <.text+0x1f1>
               	leaq	-0x8(%rbp), %r11
               	movq	0x28(%rsp), %r9
               	movslq	%r9d, %r9
               	movq	%r9, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r11)
               	movl	$0x1, %r9d
               	movq	%r9, -0x88(%rbp)
               	jmp	0x4004c3 <.text+0x203>
               	movl	$0x63, %r9d
               	movq	%r9, -0x88(%rbp)
               	jmp	0x4004c3 <.text+0x203>
               	movq	-0x88(%rbp), %r9
               	movslq	%r9d, %rdi
               	cmpq	$0x1, %rdi
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x90(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x400526 <.text+0x266>
               	leaq	-0x8(%rbp), %rdi
               	movzbq	(%rdi), %r11
               	movq	%r11, %rdi
               	xorq	$0x2a, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r11
               	cmpq	$0x0, %r11
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x90(%rbp)
               	jmp	0x400526 <.text+0x266>
               	movq	-0x90(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	0x400586 <.text+0x2c6>
               	leaq	0xfc13(%rip), %r12      # 0x410154
               	movslq	%r9d, %r14
               	leaq	-0x8(%rbp), %r9
               	movzbq	(%r9), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c7d <printf>
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
               	leaq	0xfbd9(%rip), %rax      # 0x41016a
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
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r14, %rax
               	cmpq	$0x80, %rax
               	jae	0x400602 <.text+0x342>
               	leaq	-0x20(%rbp), %rax
               	movq	0x28(%rsp), %r14
               	movslq	%r14d, %r14
               	movq	%r14, %r15
               	andq	$0xff, %r15
               	movb	%r15b, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, -0x98(%rbp)
               	jmp	0x400614 <.text+0x354>
               	movl	$0x63, %r14d
               	movq	%r14, -0x98(%rbp)
               	jmp	0x400614 <.text+0x354>
               	movq	-0x98(%rbp), %r14
               	movslq	%r14d, %r15
               	cmpq	$0x1, %r15
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400676 <.text+0x3b6>
               	leaq	-0x20(%rbp), %r15
               	movzbq	(%r15), %rax
               	movq	%rax, %r15
               	xorq	$0x2a, %r15
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x0, %rax
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xa0(%rbp)
               	jmp	0x400676 <.text+0x3b6>
               	movq	-0xa0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x4006d6 <.text+0x416>
               	leaq	0xfadd(%rip), %r12      # 0x41016e
               	movslq	%r14d, %r15
               	leaq	-0x20(%rbp), %r14
               	movzbq	(%r14), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400c7d <printf>
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
               	leaq	0xfaa3(%rip), %rax      # 0x410184
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
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x80, %rax
               	jae	0x400752 <.text+0x492>
               	leaq	-0x30(%rbp), %rax
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	movq	%r15, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x400764 <.text+0x4a4>
               	movl	$0x63, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x400764 <.text+0x4a4>
               	movq	-0xa8(%rbp), %r15
               	movslq	%r15d, %rbx
               	cmpq	$0x1, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4007c6 <.text+0x506>
               	leaq	-0x30(%rbp), %rbx
               	movzbq	(%rbx), %rax
               	movq	%rax, %rbx
               	xorq	$0x2a, %rbx
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	$0x0, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xb0(%rbp)
               	jmp	0x4007c6 <.text+0x506>
               	movq	-0xb0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400826 <.text+0x566>
               	leaq	0xf9a7(%rip), %r14      # 0x410188
               	movslq	%r15d, %r12
               	leaq	-0x30(%rbp), %r15
               	movzbq	(%r15), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400c7d <printf>
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
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x40(%rbp)
               	movl	%ebx, -0x48(%rbp)
               	movl	%ebx, -0x50(%rbp)
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jle	0x400889 <.text+0x5c9>
               	movl	$0x1, %eax
               	movl	%eax, -0x40(%rbp)
               	movl	$0x2, %ebx
               	movl	%ebx, -0x48(%rbp)
               	movl	$0x3, %eax
               	movl	%eax, -0x50(%rbp)
               	movslq	-0x40(%rbp), %rbx
               	movslq	-0x48(%rbp), %rax
               	movq	%rbx, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movslq	-0x50(%rbp), %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	0x40089f <.text+0x5df>
               	movabsq	$-0x1, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	0x40089f <.text+0x5df>
               	movq	-0xb8(%rbp), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x6, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xd0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4008eb <.text+0x62b>
               	movslq	-0x40(%rbp), %rax
               	cmpq	$0x1, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xd0(%rbp)
               	jmp	0x4008eb <.text+0x62b>
               	movq	-0xd0(%rbp), %r12
               	movq	%r12, -0xc8(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x400925 <.text+0x665>
               	movslq	-0x48(%rbp), %rax
               	cmpq	$0x2, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x400925 <.text+0x665>
               	movq	-0xc8(%rbp), %r12
               	movq	%r12, -0xc0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x40095f <.text+0x69f>
               	movslq	-0x50(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc0(%rbp)
               	jmp	0x40095f <.text+0x69f>
               	movq	-0xc0(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x4009d0 <.text+0x710>
               	leaq	0xf824(%rip), %r15      # 0x41019e
               	movslq	%ebx, %r14
               	movslq	-0x40(%rbp), %r12
               	movslq	-0x48(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movslq	-0x50(%rbp), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %r8
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movq	0x20(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x400c7d <printf>
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
               	leaq	-0x60(%rbp), %rbx
               	leaq	0xf7e0(%rip), %rax      # 0x4101bb
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
               	movq	%rbx, %r12
               	movl	$0xc8, %r12d
               	movslq	%r12d, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	cmpq	$0x80, %rbx
               	jae	0x400a47 <.text+0x787>
               	leaq	-0x60(%rbp), %rbx
               	movslq	%r12d, %rax
               	movq	%rax, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rbx)
               	movl	$0x1, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	0x400a58 <.text+0x798>
               	movl	$0x63, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	0x400a58 <.text+0x798>
               	movq	-0xd8(%rbp), %rax
               	movslq	%eax, %r12
               	cmpq	$0x63, %r12
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe0(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400ab2 <.text+0x7f2>
               	leaq	-0x60(%rbp), %r12
               	movzbq	(%r12), %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe0(%rbp)
               	jmp	0x400ab2 <.text+0x7f2>
               	movq	-0xe0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400b12 <.text+0x852>
               	leaq	0xf6f2(%rip), %r15      # 0x4101bf
               	movslq	%eax, %r12
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400c7d <printf>
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
