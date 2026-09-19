
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
               	movq	$-0x1, %rax
               	retq
               	leaq	0x2(%rsi), %rax
               	movq	(%rdx), %rcx
               	movl	%eax, %eax
               	addq	%rcx, %rax
               	movq	%rax, (%rdx)
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x4, %edi
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	movl	%eax, %eax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rax, (%rdx)
               	xorl	%eax, %eax
               	retq
               	cmpl	$0x1, %edi
               	jl	<addr>
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movq	(%rdx), %rax
               	movl	%esi, %ecx
               	addq	%rcx, %rax
               	movq	%rax, (%rdx)
               	movl	$0x2, %eax
               	retq
               	movl	%esi, %eax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rax, (%rdx)
               	xorl	%eax, %eax
               	retq

<by_computed_goto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	%edi, -0x40(%rbp)
               	movl	%esi, -0x30(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	xorl	%eax, %eax
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
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, (%rdx)
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq
               	movl	-0x30(%rbp), %eax
               	movq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	%rax, (%rcx)
               	movl	$0x4, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	-0x30(%rbp), %ecx
               	incq	%rcx
               	movq	-0x20(%rbp), %rdx
               	movl	%ecx, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%rcx, (%rdx)
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movl	$0xf, %eax
               	movq	%rax, (%rdx)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x5, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
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
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %edi
               	movl	$0x5, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
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
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2, %edi
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	leaq	(%rax), %rbx
               	xorl	%edi, %edi
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
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
