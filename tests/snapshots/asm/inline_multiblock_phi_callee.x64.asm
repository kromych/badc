
inline_multiblock_phi_callee.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
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
               	movslq	%ecx, %r8
               	testq	%r8, %r8
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %r8
               	shlq	$0x1, %r8
               	andq	$0x1, %rcx
               	addq	%r8, %rcx
               	movslq	%ecx, %r8
               	movslq	%r8d, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %r8
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x1, %rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rsi
               	movslq	%esi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %r8
               	movq	%rdx, %rcx
               	imulq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x1, %rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rsi
               	movslq	%esi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %r8
               	movq	%r9, %rcx
               	xorq	%rdi, %rcx
               	movslq	%ecx, %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x1, %rsi
               	andq	$0x1, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rsi
               	movslq	%esi, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%r8,%rcx), %rsi
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rdi
               	cmpq	$0x3, %rdi
               	jle	<addr>
               	leaq	0x1(%r9), %rdx
               	movslq	%edx, %r9
               	cmpq	$0x4, %r9
               	jle	<addr>
               	cmpq	$0x620, %rsi            # imm = 0x620
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
