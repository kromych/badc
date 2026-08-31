
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
               	movl	$0x7, %eax
               	movabsq	$-0xc, %rax
               	movl	$0xc, %eax
               	movabsq	$-0x1, %rax
               	movl	$0x1, %eax
               	movl	$0x3, %eax
               	movabsq	$-0xf, %rax
               	movl	$0xf, %eax
               	xorq	%rsi, %rsi
               	movabsq	$-0x4, %rax
               	jmp	<addr>
               	leaq	-0x3(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	0x3(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	imulq	$-0x3, %rax, %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	xorq	$-0x3, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	-0x2(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	0x2(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	imulq	$-0x2, %rax, %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	movq	%rdx, %rcx
               	xorq	$-0x2, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	imulq	$-0x1, %rax, %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	imulq	$0x0, %rax, %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	movq	%rdx, %rcx
               	xorq	$0x0, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	movq	%rax, %rcx
               	shlq	$0x0, %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	movq	%rdx, %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	0x2(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	-0x2(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	movq	%rdx, %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	0x3(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	-0x3(%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rax,%rax,2), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdi
               	movq	%rdx, %rcx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jle	<addr>
               	cmpq	$0x620, %rsi            # imm = 0x620
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
