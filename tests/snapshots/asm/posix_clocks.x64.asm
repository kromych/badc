
posix_clocks.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0xd0, %rsp
               	pushq	%rbx
               	leaq	0x50(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ebx, %ebx
               	movl	%ebx, 0xc8(%rsp)
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jge	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	nopl	(%rax,%rax)
               	testq	%rax, %rax
               	jl	<addr>
               	movq	0x28(%rsp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	nopw	(%rax,%rax)
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jge	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	leaq	0x40(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	0x48(%rsp), %rax
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jge	<addr>
               	cmpq	$0x0, 0x40(%rsp)
               	jne	<addr>
               	nopl	(%rax)
               	cmpq	$0x0, 0x48(%rsp)
               	jne	<addr>
               	leaq	0x1e(%rbx), %rax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	leaq	0x14(%rbx), %rax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	leaq	0xa(%rbx), %rax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, 0x18(%rsp)
               	xorl	%edi, %edi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	leaq	-0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jle	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	leaq	0x60(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x60(%rsp), %rax
               	leaq	-0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jle	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movq	0x68(%rsp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0xf4240, %rax          # imm = 0xF4240
               	jl	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movl	$0x1, %edi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	leaq	0x50(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movl	$0x1, %edi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	leaq	0x30(%rsp), %rsi
               	movq	0x30(%rsp), %rax
               	imulq	$0x3e8, %rax, %rdi      # imm = 0x3E8
               	movq	0x38(%rsp), %rax
               	movabsq	$0x431bde82d7b634db, %rcx # imm = 0x431BDE82D7B634DB
               	imulq	%rcx
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rax, %rdi
               	leaq	0x20(%rsp), %r8
               	movq	0x20(%rsp), %rax
               	imulq	$0x3e8, %rax, %r9       # imm = 0x3E8
               	movq	0x28(%rsp), %rax
               	imulq	%rcx
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%r9, %rax
               	subq	%rax, %rdi
               	cmpq	$0x14, %rdi
               	jge	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%r8)
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	leaq	0x50(%rsp), %rdx
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	leaq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rax
               	addq	$0x1c9c380, %rax        # imm = 0x1C9C380
               	movq	%rax, 0x38(%rsp)
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	subq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	movq	%rax, 0x38(%rsp)
               	addq	$0x1, 0x30(%rsp)
               	movl	$0x1, %edi
               	xorl	%ecx, %ecx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movl	$0x1, %edi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movq	0x20(%rsp), %rax
               	imulq	$0x3e8, %rax, %rsi      # imm = 0x3E8
               	movq	0x28(%rsp), %rax
               	movabsq	$0x431bde82d7b634db, %rcx # imm = 0x431BDE82D7B634DB
               	imulq	%rcx
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	movq	0x30(%rsp), %rax
               	imulq	$0x3e8, %rax, %rdi      # imm = 0x3E8
               	movq	0x38(%rsp), %rax
               	imulq	%rcx
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rdi, %rax
               	cmpq	%rax, %rsi
               	jge	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movq	$-0x1, %rdi
               	xorl	%esi, %esi
               	leaq	0x50(%rsp), %rdx
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movl	$0x2, %edi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movl	$0x1, %edi
               	leaq	0x50(%rsp), %rsi
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	0xc8(%rsp), %ecx
               	incq	%rcx
               	movl	%ecx, 0xc8(%rsp)
               	incq	%rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	movl	$0x2, %edi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	nopl	(%rax,%rax)
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %rsi
               	callq	<addr>
               	movq	0x40(%rsp), %rax
               	imulq	$0x3e8, %rax, %rsi      # imm = 0x3E8
               	movq	0x48(%rsp), %rax
               	movabsq	$0x431bde82d7b634db, %rcx # imm = 0x431BDE82D7B634DB
               	imulq	%rcx
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rax, %rsi
               	movq	0x50(%rsp), %rax
               	imulq	$0x3e8, %rax, %rdi      # imm = 0x3E8
               	movq	0x58(%rsp), %rax
               	imulq	%rcx
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rdi, %rax
               	subq	%rax, %rsi
               	cmpq	$0x1388, %rsi           # imm = 0x1388
               	jle	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	callq	<addr>
               	movl	$0x0, (%rax)
               	movq	$-0x1, %rdi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movq	$0x0, 0x50(%rsp)
               	movq	$0x3b9aca00, 0x58(%rsp) # imm = 0x3B9ACA00
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	0x50(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movq	$0x1e13380, 0x18(%rsp)  # imm = 0x1E13380
               	leaq	0x18(%rsp), %rdi
               	leaq	0x90(%rsp), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	0xa4(%rsp), %eax
               	cmpl	$0x47, %eax
               	jne	<addr>
               	cmpl	$0x0, 0xa0(%rsp)
               	jne	<addr>
               	movl	0x9c(%rsp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x32, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	cmpl	$0x0, 0x98(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0xac(%rsp)
               	je	<addr>
               	movl	$0x33, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	leaq	0x18(%rsp), %rdi
               	leaq	0x90(%rsp), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	0x8(%rax), %esi
               	movl	0xc(%rax), %edi
               	movl	0x14(%rax), %r8d
               	movl	0x20(%rax), %eax
               	movl	0x90(%rsp), %r9d
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	movl	0x94(%rsp), %ecx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movl	0x98(%rsp), %ecx
               	cmpl	%esi, %ecx
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	movl	0x9c(%rsp), %ecx
               	cmpl	%edi, %ecx
               	jne	<addr>
               	movl	0xa4(%rsp), %ecx
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	movl	0xb0(%rsp), %ecx
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x36, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	leaq	0x70(%rsp), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	0x70(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x37, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xd0, %rsp
               	retq
