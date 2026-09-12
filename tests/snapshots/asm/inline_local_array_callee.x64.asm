
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$-0x3de, %rax           # imm = 0xFC22
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0xc27, %rax            # imm = 0xC27
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x8a3, %rax            # imm = 0x8A3
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
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
               	movl	%edx, %edx
               	leaq	(%rsi,%rdx), %r8
               	leaq	0x1(%rax), %rdx
               	leaq	-0x1(%rax), %rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdx, %rdi
               	movl	%edi, %edi
               	addq	%rdi, %r8
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movslq	%edi, %rdi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rcx
               	movl	%ecx, %ecx
               	leaq	(%r8,%rcx), %rdi
               	movq	%rsi, %rcx
               	subq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rdi, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, %ecx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x1(%rax), %rcx
               	leaq	(%rax,%rcx), %rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rax, %rdx
               	movl	%edx, %edx
               	leaq	(%rsi,%rdx), %rdi
               	movq	%rax, %rdx
               	shlq	%rdx
               	leaq	(%rcx,%rdx), %rsi
               	movslq	%esi, %rsi
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rcx, %rsi
               	movl	%esi, %esi
               	leaq	(%rdi,%rsi), %r8
               	leaq	-0x1(%rax), %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movslq	%edi, %rdi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdx, %rdi
               	movl	%edi, %edi
               	addq	%rdi, %r8
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rsi
               	movl	%esi, %esi
               	addq	%r8, %rsi
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rax, %rdx
               	movl	%edx, %edx
               	addq	%rdx, %rsi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rsi
               	movq	%rax, %rdx
               	shlq	%rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rsi
               	leaq	-0x1(%rax), %rdx
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rsi
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x4, %eax
               	jle	<addr>
               	movl	%esi, %eax
               	cmpl	$0x33f7f8d8, %eax       # imm = 0x33F7F8D8
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
