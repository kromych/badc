
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
               	movl	%eax, %ecx
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	movl	%ecx, %ecx
               	movl	%ecx, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, (%rdx)
               	movq	%rax, %rcx
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
               	movl	%esi, %ecx
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	movl	%ecx, %ecx
               	movl	%ecx, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, (%rdx)
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	retq

<by_computed_goto>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	movq	%rdx, 0x30(%rbp)
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
               	movl	0x20(%rbp), %ecx
               	movq	0x30(%rbp), %rdx
               	jmp	<addr>
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	movl	0x20(%rbp), %edx
               	movq	0x30(%rbp), %rcx
               	jmp	<addr>
               	movl	$0x4, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	0x20(%rbp), %eax
               	incq	%rax
               	movl	%eax, %ecx
               	movq	0x30(%rbp), %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movq	%rax, %rsi
               	movl	%ecx, %ecx
               	movl	%ecx, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, (%rdx)
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	%edx, %eax
               	movq	(%rcx), %rdx
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	movq	%rax, (%rcx)
               	xorq	%rax, %rax
               	movl	$0x2, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	movl	%ecx, %ecx
               	movl	%ecx, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, (%rdx)
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, %rdx
               	movl	$0xf, %edx
               	movq	%rdx, (%rcx)
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	-0x8(%rbp), %rdx
               	cmpq	$0xf, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, -0x8(%rbp)
               	movl	$0x5, %esi
               	movq	%rax, %rdi
               	movq	%rcx, %rdx
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x1, %edi
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x12, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2, %edi
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
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
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
