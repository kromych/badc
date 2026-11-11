
inline_multiblock_phi_callee.x64:	file format elf64-x86-64

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
               	xorl	%ecx, %ecx
               	movq	$-0x4, %rax
               	leaq	-0x3(%rax), %rdx
               	movq	%rdx, %rsi
               	negq	%rsi
               	testl	%edx, %edx
               	cmovlq	%rsi, %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rdx
               	addq	%rsi, %rdx
               	addq	%rcx, %rdx
               	leaq	0x3(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	imulq	$-0x3, %rax, %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$-0x3, %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x2(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	leaq	0x2(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	imulq	$-0x2, %rax, %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$-0x2, %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x1(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movq	%rax, %rcx
               	negq	%rcx
               	testl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmovlq	%rax, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, %rdi
               	negq	%rdi
               	testl	%edx, %edx
               	cmovlq	%rdi, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	testl	%eax, %eax
               	movq	%rax, %rdx
               	cmovlq	%rcx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rsi
               	testl	%eax, %eax
               	movq	%rax, %rdx
               	cmovlq	%rcx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rsi
               	imulq	$0x0, %rax, %rdx
               	movq	%rdx, %rdi
               	negq	%rdi
               	testl	%edx, %edx
               	cmovlq	%rdi, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	testl	%eax, %eax
               	movq	%rax, %rdx
               	cmovlq	%rcx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rsi
               	leaq	0x1(%rax), %rdx
               	movq	%rdx, %rdi
               	negq	%rdi
               	testl	%edx, %edx
               	cmovlq	%rdi, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	addq	%rdx, %rsi
               	leaq	-0x1(%rax), %rdx
               	movq	%rdx, %rdi
               	negq	%rdi
               	testl	%edx, %edx
               	cmovlq	%rdi, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	addq	%rsi, %rdx
               	testl	%eax, %eax
               	cmovgeq	%rax, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$0x1, %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	0x2(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x2(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$0x2, %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	0x3(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x3(%rax), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rax,%rax,2), %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$0x3, %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jle	<addr>
               	cmpq	$0x620, %rcx            # imm = 0x620
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
