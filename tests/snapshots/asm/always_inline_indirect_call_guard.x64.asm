
always_inline_indirect_call_guard.x64:	file format elf64-x86-64

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

<by_switch>:
               	cmpl	$0x4, %edi
               	jl	<addr>
               	cmpl	$0x9, %edi
               	jl	<addr>
               	cmpl	$0x9, %edi
               	je	<addr>
               	movabsq	$-0x1, %rax
               	retq
               	movl	%esi, %eax
               	addq	$0x2, %rax
               	movl	%eax, %ecx
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	movl	%ecx, %ecx
               	movq	(%rdx), %rsi
               	movl	%ecx, %ecx
               	addq	%rsi, %rcx
               	movq	%rcx, (%rdx)
               	movl	$0x2, %eax
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x4, %edi
               	jne	<addr>
               	movl	%esi, %eax
               	incq	%rax
               	movl	%eax, %eax
               	movl	%eax, %eax
               	movl	%eax, %eax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rax, (%rdx)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
               	cmpl	$0x1, %edi
               	jl	<addr>
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	%esi, %ecx
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	movl	%ecx, %ecx
               	movq	(%rdx), %rsi
               	movl	%ecx, %ecx
               	addq	%rsi, %rcx
               	movq	%rcx, (%rdx)
               	movl	$0x2, %eax
               	movl	$0x2, %eax
               	retq
               	movl	%esi, %eax
               	movl	%eax, %eax
               	movl	%eax, %eax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rax, (%rdx)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq

<by_computed_goto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movl	%edi, -0x40(%rbp)
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movslq	%edi, %rdx
               	imulq	$0x55555556, %rdx, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	subq	%rsi, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	jmpq	*%rcx
               	movl	-0x30(%rbp), %ecx
               	movq	-0x20(%rbp), %rdx
               	jmp	<addr>
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq
               	movl	-0x30(%rbp), %edx
               	movq	-0x20(%rbp), %rcx
               	jmp	<addr>
               	movl	$0x4, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	-0x30(%rbp), %ecx
               	incq	%rcx
               	movl	%ecx, %ecx
               	movq	-0x20(%rbp), %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	%ecx, %ecx
               	movl	%ecx, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, (%rdx)
               	jmp	<addr>
               	movq	%rax, %rsi
               	movl	%edx, %edx
               	movq	(%rcx), %rsi
               	movl	%edx, %edx
               	addq	%rsi, %rdx
               	movq	%rdx, (%rcx)
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	%ecx, %ecx
               	movl	%ecx, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, (%rdx)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0xf, %edx
               	movq	%rdx, (%rcx)
               	movq	%rax, %rdx
               	movq	-0x8(%rbp), %rdx
               	cmpq	$0xf, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	movl	$0x5, %esi
               	movq	%rax, %rdi
               	movq	%rcx, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x1, %edi
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x12, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x7, %edi
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2, %edi
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	(%rax), %rbx
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x1, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x1, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x2, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x2, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x3, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x3, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x5, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x5, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x6, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x6, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x7, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x7, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x8, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x8, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x9, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0x9, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0xa, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0xa, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0xb, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rax, %rbx
               	movl	$0xb, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	shlq	%rax
               	movslq	%eax, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	cmpq	$0x131, %rax            # imm = 0x131
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
