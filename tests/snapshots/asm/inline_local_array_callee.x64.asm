
inline_local_array_callee.x64:	file format elf64-x86-64

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
               	movabsq	$-0xa, %rax
               	movl	$0x1f, %ecx
               	movl	$0x16, %eax
               	movl	$0x2, %eax
               	movl	$0x17, %ecx
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	movq	%rsi, %rax
               	movabsq	$-0x4, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	%rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, %edx
               	leaq	(%rsi,%rdx), %r8
               	leaq	0x1(%rax), %rdx
               	leaq	-0x1(%rax), %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movslq	%esi, %rsi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, %edx
               	leaq	(%r8,%rdx), %rsi
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rsi,%rcx), %r8
               	leaq	0x1(%rax), %rcx
               	leaq	-0x1(%rax), %rdx
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	movslq	%esi, %rsi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, %edx
               	leaq	(%r8,%rdx), %rsi
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rsi, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdx,%rcx), %r8
               	leaq	0x1(%rax), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	movslq	%esi, %rsi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, %edx
               	addq	%rdx, %r8
               	leaq	-0x1(%rax), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movslq	%esi, %rsi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%r8,%rcx), %rsi
               	leaq	(%rdx,%rax), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, %edx
               	leaq	(%rsi,%rdx), %r8
               	leaq	0x1(%rax), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, %edx
               	leaq	(%r8,%rdx), %rsi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rsi
               	leaq	-0x1(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rsi
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rdi
               	cmpq	$0x4, %rdi
               	jle	<addr>
               	movl	%esi, %eax
               	cmpq	$0x33f7f8d8, %rax       # imm = 0x33F7F8D8
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
