
typedef_array_outer_dim.x64:	file format elf64-x86-64

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

<fill_and_sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %r9
               	leaq	(%r9), %rbx
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	addq	$0x0, %r8
               	movslq	%r8d, %r8
               	movq	%r8, (%rbx)
               	leaq	(%rdx,%r8), %r9
               	addq	%rdi, %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x1(%rdx), %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x8(%rsi)
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rdi,%r8), %rsi
               	movq	0x8(%rsi), %rbx
               	addq	%rbx, %r9
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x10(%rsi)
               	addq	%rdx, %r9
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	addq	$0x3, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x18(%rdx)
               	addq	%r8, %r9
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	leaq	0x4(%rsi), %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x20(%rdx)
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rdi,%r8), %rdx
               	movq	0x20(%rdx), %rbx
               	addq	%rbx, %r9
               	addq	$0x5, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, 0x28(%rdx)
               	addq	%rsi, %r9
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	addq	$0x6, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x30(%rdx)
               	addq	%r8, %r9
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	leaq	0x7(%rsi), %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x38(%rdx)
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rdi,%r8), %rdx
               	movq	0x38(%rdx), %rbx
               	addq	%rbx, %r9
               	addq	$0x8, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, 0x40(%rdx)
               	addq	%rsi, %r9
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	addq	$0x9, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x48(%rdx)
               	addq	%r8, %r9
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	leaq	0xa(%rsi), %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x50(%rdx)
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rdi,%r8), %rdx
               	movq	0x50(%rdx), %rbx
               	addq	%rbx, %r9
               	addq	$0xb, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, 0x58(%rdx)
               	addq	%rsi, %r9
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	addq	$0xc, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x60(%rdx)
               	addq	%r8, %r9
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	leaq	0xd(%rsi), %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x68(%rdx)
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rdi,%r8), %rdx
               	movq	0x68(%rdx), %rbx
               	addq	%rbx, %r9
               	addq	$0xe, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, 0x70(%rdx)
               	addq	%rsi, %r9
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rdi,%r8), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	$0xf, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, 0x78(%rdx)
               	leaq	(%r9,%rsi), %rdx
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movq	(%rsp), %rbx
               	movq	%rdx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x220, %rsp            # imm = 0x220
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, %rbx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	addq	%rcx, %rbx
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	movq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	movq	0x1f8(%rax), %rcx
               	cmpq	$0x3f, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	movq	0xb8(%rax), %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
