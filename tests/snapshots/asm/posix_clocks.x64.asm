
posix_clocks.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc8, %rsp
               	pushq	%rbx
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx       # <addr>
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x8(%rbp)
               	leaq	<rip>, %rax       # <addr>
               	movl	(%rax,%rbx,4), %edi
               	leaq	-0xb0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0xb0(%rbp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	-0xa8(%rbp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	-0xa8(%rbp), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jge	<addr>
               	leaq	<rip>, %rax       # <addr>
               	movl	(%rax,%rbx,4), %edi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x90(%rbp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	-0x88(%rbp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	-0x88(%rbp), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jge	<addr>
               	cmpq	$0x0, -0x90(%rbp)
               	jne	<addr>
               	cmpq	$0x0, -0x88(%rbp)
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	xorl	%edi, %edi
               	leaq	-0xb0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0xb0(%rbp), %rax
               	leaq	-0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movq	-0xb0(%rbp), %rax
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jle	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x70(%rbp), %rax
               	leaq	-0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movq	-0x70(%rbp), %rax
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jle	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x68(%rbp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	-0x68(%rbp), %rax
               	cmpq	$0xf4240, %rax          # imm = 0xF4240
               	jl	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0xb0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0xa0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	movq	-0xa0(%rbp), %rax
               	imulq	$0x3e8, %rax, %rdi      # imm = 0x3E8
               	movq	-0x98(%rbp), %rax
               	movabsq	$0x431bde82d7b634db, %rcx # imm = 0x431BDE82D7B634DB
               	imulq	%rcx
               	movq	%rdx, %rax
               	sarq	$0x12, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rdi
               	leaq	-0xb0(%rbp), %r8
               	movq	-0xb0(%rbp), %rax
               	imulq	$0x3e8, %rax, %r9       # imm = 0x3E8
               	movq	-0xa8(%rbp), %rax
               	imulq	%rcx
               	movq	%rdx, %rax
               	sarq	$0x12, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	movq	%rdi, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x14, %rcx
               	jge	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdx
               	movq	-0x98(%rbp), %rax
               	addq	$0x1c9c380, %rax        # imm = 0x1C9C380
               	movq	%rax, -0x98(%rbp)
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	movq	-0x98(%rbp), %rax
               	subq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	movq	%rax, -0x98(%rbp)
               	movq	-0xa0(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0xa0(%rbp)
               	movl	$0x1, %edi
               	xorl	%ecx, %ecx
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0xb0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0xb0(%rbp), %rax
               	imulq	$0x3e8, %rax, %rsi      # imm = 0x3E8
               	movq	-0xa8(%rbp), %rax
               	movabsq	$0x431bde82d7b634db, %rcx # imm = 0x431BDE82D7B634DB
               	imulq	%rcx
               	movq	%rdx, %rax
               	sarq	$0x12, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	movq	-0xa0(%rbp), %rax
               	imulq	$0x3e8, %rax, %rdi      # imm = 0x3E8
               	movq	-0x98(%rbp), %rax
               	imulq	%rcx
               	movq	%rdx, %rax
               	sarq	$0x12, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	cmpq	%rax, %rsi
               	jge	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rdi
               	xorl	%esi, %esi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	-0xb0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, %edi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	-0x8(%rbp), %ecx
               	incq	%rcx
               	movl	%ecx, -0x8(%rbp)
               	incq	%rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	movl	$0x2, %edi
               	leaq	-0xa0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0xa0(%rbp), %rax
               	movq	-0xb0(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x98(%rbp), %rax
               	movq	-0xa8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x90(%rbp), %rax
               	imulq	$0x3e8, %rax, %rsi      # imm = 0x3E8
               	movq	-0x88(%rbp), %rax
               	movabsq	$0x431bde82d7b634db, %rcx # imm = 0x431BDE82D7B634DB
               	imulq	%rcx
               	movq	%rdx, %rax
               	sarq	$0x12, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	movq	-0x80(%rbp), %rax
               	imulq	$0x3e8, %rax, %rdi      # imm = 0x3E8
               	movq	-0x78(%rbp), %rax
               	imulq	%rcx
               	movq	%rdx, %rax
               	sarq	$0x12, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x1388, %rcx           # imm = 0x1388
               	jle	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	movq	$-0x1, %rdi
               	leaq	-0xb0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	movq	$0x3b9aca00, -0x78(%rbp) # imm = 0x3B9ACA00
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	-0x80(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x1e13380, -0xb8(%rbp) # imm = 0x1E13380
               	leaq	-0xb8(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x47, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x30(%rbp)
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x32, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpl	$0x0, -0x38(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x24(%rbp)
               	je	<addr>
               	movl	$0x33, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0xb8(%rbp)
               	leaq	-0xb8(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	0x8(%rax), %esi
               	movl	0xc(%rax), %edi
               	movl	0x14(%rax), %r8d
               	movl	0x20(%rax), %eax
               	movl	-0x40(%rbp), %r9d
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	movl	-0x3c(%rbp), %ecx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movl	-0x38(%rbp), %ecx
               	cmpl	%esi, %ecx
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0x34(%rbp), %ecx
               	cmpl	%edi, %ecx
               	jne	<addr>
               	movl	-0x2c(%rbp), %ecx
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	movl	-0x20(%rbp), %ecx
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x36, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb8(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xb8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x37, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x1e(%rbx), %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x14(%rbx), %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	0xa(%rbx), %rax
               	popq	%rbx
               	leave
               	retq
