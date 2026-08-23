
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
               	movabsq	$-0x4, %rdx
               	jmp	<addr>
               	movabsq	$-0x3, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rax), %rcx
               	movslq	%ecx, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rdi
               	shlq	%rdi
               	andq	$0x1, %rcx
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
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
               	imulq	%rax, %rcx
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
               	leaq	(%rdi,%rcx), %r8
               	movslq	%edx, %rcx
               	movslq	%eax, %rdi
               	xorq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	%rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%r8,%rcx), %rsi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	cmpl	$0x4, %edx
               	jle	<addr>
               	cmpq	$0x620, %rsi            # imm = 0x620
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
