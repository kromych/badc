
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
               	movq	%rdi, %rcx
               	shlq	%rcx
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<f2>:
               	leaq	0x1(%rdi), %rax
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rax, %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<f3>:
               	leaq	0x1(%rdi), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	imulq	$0x64, %rcx, %rcx
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
               	xorl	%esi, %esi
               	movq	$-0x4, %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	leaq	(%rsi,%rcx), %r8
               	leaq	0x1(%rax), %rcx
               	leaq	-0x1(%rax), %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rcx, %rdi
               	addq	%rdi, %r8
               	movq	%rdx, %rdi
               	subq	%rax, %rdi
               	imulq	$0xf4243, %r8, %r8      # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rdx
               	leaq	(%r8,%rdx), %rdi
               	movq	%rsi, %rdx
               	subq	%rcx, %rdx
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rsi, %rdx
               	addq	%rdi, %rdx
               	addq	%rax, %rcx
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x1(%rax), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rdi
               	leaq	-0x1(%rax), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rcx, %rsi
               	addq	%rsi, %rdi
               	leaq	(%rdx,%rax), %rsi
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	addq	%rdi, %rdx
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdx, %rdx
               	addq	%rcx, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movq	%rax, %rdx
               	shlq	%rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rdi
               	leaq	-0x1(%rax), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jle	<addr>
               	cmpl	$0x33f7f8d8, %esi       # imm = 0x33F7F8D8
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
