
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
               	movq	%rdi, %rcx
               	subq	%rax, %rcx
               	imulq	$0x64, %rcx, %rax
               	addq	%rdi, %rax
               	retq

<f2>:
               	leaq	0x1(%rdi), %rax
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rax, %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	retq

<f3>:
               	leaq	0x1(%rdi), %rax
               	movq	%rax, %rcx
               	shlq	%rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpl	$0xfffffc22, %eax       # imm = 0xFFFFFC22
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpl	$0xc27, %eax            # imm = 0xC27
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpl	$0x8a3, %eax            # imm = 0x8A3
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%ecx, %ecx
               	movq	$-0x4, %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	imulq	$0xf4243, %rcx, %rcx    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rax, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	leaq	0x1(%rax), %rcx
               	leaq	-0x1(%rax), %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %r8, %r8
               	addq	%rcx, %r8
               	addq	%r8, %rdi
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	imulq	$0xf4243, %rdi, %rdi    # imm = 0xF4243
               	imulq	$0x7, %r8, %r8
               	addq	%r8, %rdx
               	addq	%rdi, %rdx
               	movq	%rsi, %rdi
               	subq	%rcx, %rdi
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%rax, %rcx
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	0x1(%rax), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rdi
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rdx
               	addq	%rdx, %rsi
               	leaq	-0x1(%rax), %rdx
               	leaq	(%rcx,%rdx), %rdi
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rcx, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rdx,%rax), %rdi
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rdx
               	addq	%rsi, %rdx
               	imulq	$0xf4243, %rdx, %rdx    # imm = 0xF4243
               	imulq	$0x7, %rcx, %rcx
               	addq	%rax, %rcx
               	addq	%rdx, %rcx
               	leaq	0x1(%rax), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	imulq	$0xf4243, %rcx, %rcx    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rdx, %rsi
               	addq	%rcx, %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	movq	%rcx, %rdi
               	shlq	%rdi
               	imulq	$0xf4243, %rsi, %rsi    # imm = 0xF4243
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rcx
               	addq	%rsi, %rcx
               	decq	%rax
               	movq	%rax, %rsi
               	shlq	%rsi
               	imulq	$0xf4243, %rcx, %rcx    # imm = 0xF4243
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rax
               	addq	%rax, %rcx
               	movq	%rdx, %rax
               	cmpl	$0x4, %eax
               	jle	<addr>
               	cmpl	$0x33f7f8d8, %ecx       # imm = 0x33F7F8D8
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
