
inline_local_array_callee.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f1>:
               	movq	%rdi, %rax
               	shlq	%rax
               	movq	%rax, %r10
               	movq	%rdi, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<f2>:
               	leaq	0x1(%rdi), %rax
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<f3>:
               	leaq	0x1(%rdi), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movabsq	$-0xa, %rax
               	movl	$0x1f, %ecx
               	movl	$0x16, %eax
               	movl	$0x2, %eax
               	movl	$0x17, %ecx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rdx, %rdx
               	movabsq	$-0x4, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	%rcx
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x1(%rax), %rcx
               	leaq	-0x1(%rax), %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	0x1(%rax), %rdx
               	leaq	-0x1(%rax), %rcx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	0x1(%rax), %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdx,%rcx), %r8
               	leaq	0x1(%rax), %rcx
               	movq	%rax, %rdx
               	shlq	%rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %r8, %rdi     # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	-0x1(%rax), %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x1(%rax), %rcx
               	leaq	(%rcx,%rax), %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdi,%rcx), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x1(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdi,%rcx), %rdx
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	$0x4, %rsi
               	jle	<addr>
               	movl	%edx, %eax
               	cmpq	$0x33f7f8d8, %rax       # imm = 0x33F7F8D8
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
