
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
               	subq	$0x50, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x18, %rbx, %r12
               	addq	%r12, %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	movl	0x10(%rax), %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	%r12, %rcx
               	movl	0x14(%rcx), %ecx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x37, %ebx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x2f, %ebx
               	jge	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x30, %rbx, %r12
               	addq	%r12, %rax
               	movq	(%rax), %rsi
               	movl	0x8(%rax), %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movabsq	$-0x100000002, %rax     # imm = 0xFFFFFFFEFFFFFFFE
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax # <addr>
               	addq	%r12, %rax
               	movq	0x10(%rax), %rsi
               	movl	$0x2, %edx
               	movl	0x18(%rax), %r8d
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	cmovneq	%rdx, %rcx
               	leaq	<rip>, %rdx # <addr>
               	imulq	$0x30, %rbx, %rax
               	addq	%rax, %rdx
               	movl	0x1c(%rdx), %esi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	-0x50(%rbp), %ecx
               	movl	0x20(%rdx), %edx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movl	-0x4c(%rbp), %edx
               	leaq	<rip>, %rcx # <addr>
               	addq	%rax, %rcx
               	movl	0x24(%rcx), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	-0x48(%rbp), %edx
               	movl	0x28(%rcx), %ecx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movl	-0x44(%rbp), %ecx
               	leaq	<rip>, %rdx # <addr>
               	addq	%rdx, %rax
               	movl	0x2c(%rax), %eax
               	cmpl	%eax, %ecx
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x38(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x38(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x38(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
