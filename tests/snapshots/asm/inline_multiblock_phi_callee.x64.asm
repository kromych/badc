
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
               	xorl	%edx, %edx
               	movq	$-0x4, %rax
               	leaq	-0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	imulq	$-0x3, %rax, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$-0x3, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	imulq	$-0x2, %rax, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$-0x2, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	0x1(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	imulq	$-0x1, %rax, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	imulq	$-0x1, %rdx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	imulq	$0x0, %rax, %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	imulq	$-0x1, %rdx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	leaq	0x1(%rax), %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	imulq	$-0x1, %rdx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rsi
               	leaq	-0x1(%rax), %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	imulq	$-0x1, %rdx, %rdx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rdx
               	addq	%rdi, %rdx
               	movslq	%edx, %rdx
               	addq	%rsi, %rdx
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x2(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	-0x3(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rax,%rax,2), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jle	<addr>
               	cmpq	$0x620, %rdx            # imm = 0x620
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
