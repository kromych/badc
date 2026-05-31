
sqlite_min.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003c7 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfd39(%rip)           # 0x410100
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x170, %rsp            # imm = 0x170
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfd2c(%rip), %r11      # 0x410118
               	movq	(%r11), %rbx
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r11, %r8
               	addq	$0x10, %r8
               	movq	(%r8), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r11, %rdx
               	addq	$0x20, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r11, %rdx
               	addq	$0x28, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, 0x30(%rsp)
               	leaq	0xfd0a(%rip), %r14      # 0x410148
               	movl	$0x42, %r15d
               	movl	$0x1a4, %r10d           # imm = 0x1A4
               	movq	%r10, 0x28(%rsp)
               	movq	%rbx, %r11
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movq	0x28(%rsp), %rdx
               	callq	*%r11
               	movq	%rax, %r12
               	movslq	%r12d, %r15
               	cmpq	$0x0, %r15
               	jge	0x40049b <.text+0xeb>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movslq	%r12d, %rbx
               	movl	$0x400, %r14d           # imm = 0x400
               	movq	0x30(%rsp), %r11
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x4004ea <.text+0x13a>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movslq	%r12d, %rbx
               	leaq	-0x108(%rbp), %r14
               	movq	0x38(%rsp), %r11
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x40053a <.text+0x18a>
               	movl	$0x3, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movslq	%r12d, %rbx
               	movl	$0x2, %r14d
               	movl	$0x1, %r15d
               	movq	0x40(%rsp), %r11
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %rdx
               	cmpq	$0x0, %rdx
               	je	0x400591 <.text+0x1e1>
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movslq	%r12d, %rbx
               	movq	0x48(%rsp), %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %rdx
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	0x10(%rbp), %rbx
               	movq	0x20(%rbp), %r12
               	movq	0x30(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4009a7 <open>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	0x10(%rbp), %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4009ad <close>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	0x10(%rbp), %rbx
               	movq	0x20(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4009b3 <ftruncate>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	0x10(%rbp), %rbx
               	movq	0x20(%rbp), %r12
               	movq	0x30(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4009b9 <fcntl>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	0x10(%rbp), %rbx
               	movq	0x20(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4009bf <stat>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	0x10(%rbp), %rbx
               	movq	0x20(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4009c5 <fstat>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
