
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
               	leaq	0x1(%rdi), %rcx
               	movq	%rdi, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<f3>:
               	leaq	0x1(%rdi), %rcx
               	movq	%rcx, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
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
               	leaq	0x1(%rax), %rdx
               	leaq	-0x1(%rax), %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	movq	%rax, %rdx
               	shlq	%rdx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	0x1(%rax), %rcx
               	leaq	-0x1(%rax), %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdi,%rcx), %rdx
               	leaq	0x1(%rax), %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x1(%rax), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	movq	%rax, %rdx
               	shlq	%rdx
               	leaq	-0x1(%rax), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x1(%rax), %rdx
               	leaq	(%rdx,%rax), %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
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
               	leaq	0x1(%rax), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	movq	%rax, %rdx
               	shlq	%rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdi
               	leaq	-0x1(%rax), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
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
               	retq
               	xorq	%rax, %rax
               	retq
