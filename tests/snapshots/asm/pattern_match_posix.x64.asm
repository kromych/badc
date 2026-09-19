
pattern_match_posix.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %r12
               	cmpl	$0x37, %ebx
               	jge	<addr>
               	imulq	$0x18, %rbx, %r13
               	leaq	(%r12,%r13), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	movslq	0x10(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	(%r12,%r13), %rcx
               	movslq	0x14(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x37, %ebx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	leaq	<rip>, %r12
               	cmpl	$0x2f, %ebx
               	jge	<addr>
               	leaq	-0x50(%rbp), %rdi
               	imulq	$0x30, %rbx, %r13
               	leaq	(%r12,%r13), %rax
               	movq	(%rax), %rsi
               	movslq	0x8(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movl	$0xfffffffe, (%rcx)     # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0x4(%rcx)  # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0x8(%rcx)  # imm = 0xFFFFFFFE
               	movl	$0xfffffffe, 0xc(%rcx)  # imm = 0xFFFFFFFE
               	leaq	-0x50(%rbp), %rdi
               	leaq	(%r12,%r13), %rax
               	movq	0x10(%rax), %rsi
               	movl	$0x2, %edx
               	movslq	0x18(%rax), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	imulq	$0x30, %rbx, %rcx
               	leaq	(%r12,%rcx), %rdx
               	movslq	0x1c(%rdx), %rsi
               	cmpl	%esi, %eax
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rsi
               	movslq	0x20(%rdx), %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	leaq	(%r12,%rcx), %rdx
               	movslq	0x24(%rdx), %rsi
               	cmpl	%esi, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rsi
               	movslq	0x28(%rdx), %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	movslq	0xc(%rax), %rdx
               	leaq	(%r12,%rcx), %rax
               	movslq	0x2c(%rax), %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x2f, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x38(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x38(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x38(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
