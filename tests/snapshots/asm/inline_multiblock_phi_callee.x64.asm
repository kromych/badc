
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
               	xorq	%rdx, %rdx
               	movabsq	$-0x4, %rax
               	jmp	<addr>
               	leaq	-0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	imulq	$-0x3, %rax, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	xorq	$-0x3, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	-0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	imulq	$-0x2, %rax, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	xorq	$-0x2, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	-0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	imulq	$-0x1, %rax, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	imulq	$0x0, %rax, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	xorq	$0x0, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	-0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	shlq	$0x0, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	-0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	-0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rax,%rax,2), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	andq	$0x1, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jle	<addr>
               	cmpq	$0x620, %rdx            # imm = 0x620
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
