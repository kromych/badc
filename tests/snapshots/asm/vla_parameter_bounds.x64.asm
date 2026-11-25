
vla_parameter_bounds.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<pointer>:
               	pushq	%rbx
               	movslq	%edi, %rdi
               	movq	%rdx, %r10
               	movslq	%esi, %rsi
               	movq	%rsi, %rbx
               	shlq	$0x2, %rbx
               	movq	%rdi, %r11
               	imulq	%rbx, %r11
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	cmpl	%edi, %edx
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%rdx, %r8
               	imulq	%rbx, %r8
               	addq	%r10, %r8
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movl	(%r8,%rcx,4), %r9d
               	addq	%r9, %rax
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	%esi, %ecx
               	jl	<addr>
               	incq	%rdx
               	cmpl	%edi, %edx
               	jl	<addr>
               	movq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	shlq	$0x2, %rcx
               	cmpq	%rcx, %r11
               	jne	<addr>
               	shlq	$0x2, %rsi
               	cmpq	%rsi, %rbx
               	jne	<addr>
               	popq	%rbx
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>

<rows>:
               	movslq	%edi, %rdi
               	movslq	%ecx, %rcx
               	movslq	%esi, %rsi
               	movq	%rsi, %r9
               	shlq	$0x2, %r9
               	movq	%rdi, %rax
               	imulq	%r9, %rax
               	movq	%rdi, %r8
               	imulq	%rsi, %r8
               	movslq	%r8d, %r8
               	shlq	$0x2, %r8
               	cmpq	%r8, %rax
               	jne	<addr>
               	imulq	%rax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	-0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	imulq	%r9, %rcx
               	addq	%r8, %rcx
               	decq	%rsi
               	movslq	%esi, %rsi
               	movl	(%rcx,%rsi,4), %esi
               	addq	%rdx, %rax
               	subq	%rdx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	addq	%rsi, %rax
               	retq
               	movq	$-0x1, %rax
               	retq

<mixed>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	leaq	(%rax,%rax,2), %rdx
               	leaq	(%rdi,%rdi,2), %rcx
               	movslq	%ecx, %rcx
               	shlq	$0x2, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	(%rsi,%rdx), %rcx
               	shlq	%rax
               	addq	%rcx, %rax
               	leaq	-0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>

<unnamed>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	movq	%rdi, %r8
               	imulq	%rcx, %r8
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	imulq	%rcx, %rax
               	addq	%rdx, %rax
               	leaq	-0x1(%rsi), %rcx
               	movslq	%ecx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>

<main>:
               	subq	$0x118, %rsp            # imm = 0x118
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0x300000002, %rax      # imm = 0x300000002
               	movq	%rax, 0x10(%rsp)
               	movabsq	$0xb0000000a, %rax      # imm = 0xB0000000A
               	movq	%rax, 0x18(%rsp)
               	movabsq	$0xd0000000c, %rax      # imm = 0xD0000000C
               	movq	%rax, 0x20(%rsp)
               	movabsq	$0x1500000014, %rax     # imm = 0x1500000014
               	movq	%rax, 0x28(%rsp)
               	movabsq	$0x1700000016, %rax     # imm = 0x1700000016
               	movq	%rax, 0x30(%rsp)
               	xorl	%eax, %eax
               	leaq	0x38(%rsp), %rcx
               	imulq	$0x30, %rax, %rsi
               	leaq	(%rcx,%rsi), %rdx
               	imulq	$0x64, %rax, %rcx
               	movl	%ecx, (%rdx)
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, 0x4(%rdx)
               	leaq	0x2(%rcx), %rdi
               	movl	%edi, 0x8(%rdx)
               	leaq	0x38(%rsp), %rdx
               	addq	%rdx, %rsi
               	addq	$0x3, %rcx
               	movl	%ecx, 0xc(%rsi)
               	imulq	$0x30, %rax, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	imulq	$0x64, %rax, %rdx
               	leaq	0xa(%rdx), %rdi
               	movl	%edi, 0x10(%rcx)
               	incq	%rdi
               	movl	%edi, 0x14(%rcx)
               	addq	$0xa, %rdx
               	addq	$0x2, %rdx
               	movl	%edx, 0x18(%rcx)
               	leaq	0x38(%rsp), %rdx
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rcx
               	leaq	0xa(%rcx), %rdi
               	addq	$0x3, %rdi
               	movl	%edi, 0x1c(%rsi)
               	imulq	$0x30, %rax, %rsi
               	addq	%rsi, %rdx
               	leaq	0x14(%rcx), %rdi
               	movl	%edi, 0x20(%rdx)
               	incq	%rdi
               	movl	%edi, 0x24(%rdx)
               	addq	$0x14, %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, 0x28(%rdx)
               	leaq	0x38(%rsp), %rcx
               	addq	%rsi, %rcx
               	imulq	$0x64, %rax, %rdx
               	addq	$0x14, %rdx
               	addq	$0x3, %rdx
               	movl	%edx, 0x2c(%rcx)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	0x98(%rsp), %rcx
               	imulq	$0x3c, %rax, %rsi
               	leaq	(%rcx,%rsi), %rdx
               	imulq	$0x64, %rax, %rcx
               	movl	%ecx, (%rdx)
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, 0x4(%rdx)
               	leaq	0x2(%rcx), %rdi
               	movl	%edi, 0x8(%rdx)
               	leaq	0x98(%rsp), %rdx
               	addq	%rdx, %rsi
               	addq	$0x3, %rcx
               	movl	%ecx, 0xc(%rsi)
               	imulq	$0x3c, %rax, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	imulq	$0x64, %rax, %rdx
               	leaq	0x4(%rdx), %rdi
               	movl	%edi, 0x10(%rcx)
               	addq	$0xa, %rdx
               	movl	%edx, 0x14(%rcx)
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, 0x18(%rcx)
               	leaq	0x98(%rsp), %rcx
               	addq	%rcx, %rsi
               	addq	$0x2, %rdx
               	movl	%edx, 0x1c(%rsi)
               	imulq	$0x3c, %rax, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rsi
               	leaq	0xa(%rsi), %rdi
               	leaq	0x3(%rdi), %r8
               	movl	%r8d, 0x20(%rcx)
               	addq	$0x4, %rdi
               	movl	%edi, 0x24(%rcx)
               	addq	$0x14, %rsi
               	movl	%esi, 0x28(%rcx)
               	leaq	0x98(%rsp), %rsi
               	leaq	(%rsi,%rdx), %rdi
               	imulq	$0x64, %rax, %rdx
               	leaq	0x14(%rdx), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, 0x2c(%rdi)
               	imulq	$0x3c, %rax, %rdi
               	addq	%rdi, %rsi
               	leaq	0x2(%rcx), %r8
               	movl	%r8d, 0x30(%rsi)
               	addq	$0x3, %rcx
               	movl	%ecx, 0x34(%rsi)
               	leaq	0x98(%rsp), %rcx
               	addq	%rdi, %rcx
               	addq	$0x14, %rdx
               	addq	$0x4, %rdx
               	movl	%edx, 0x38(%rcx)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x8(%rsp), %r8
               	xorl	%edi, %edi
               	movq	%rdi, %rcx
               	movq	%rdi, %rax
               	shlq	$0x4, %rax
               	leaq	(%r8,%rax), %rdx
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%rdi
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x8a, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	leaq	0x38(%rsp), %rcx
               	movl	0x94(%rsp), %edx
               	leaq	0x30(%rcx), %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	addq	%rdx, %rax
               	cmpl	$0x87, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	0x10c(%rsp), %eax
               	cmpl	$0x7c, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	0x64(%rsp), %eax
               	cmpl	$0x17, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	xorl	%eax, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
