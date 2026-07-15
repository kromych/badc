
quicksort.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<swap>:
               	movslq	(%rdi), %rax
               	movslq	(%rsi), %rcx
               	movl	%ecx, (%rdi)
               	movl	%eax, (%rsi)
               	xorq	%rax, %rax
               	retq

<partition>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %r13
               	movq	%rdx, %r15
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	movslq	%r15d, %r15
               	movslq	(%r13,%r15,4), %r14
               	leaq	-0x1(%r12), %rbx
               	jmp	<addr>
               	movslq	%r12d, %rax
               	movslq	(%r13,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%rbx
               	movslq	%ebx, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rdi
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r12d, %rax
               	leaq	0x1(%rax), %r12
               	movslq	%r12d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<quicksort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %r13
               	movq	%rdx, 0x30(%rsp)
               	movq	%rsi, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x30(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %rax
               	cmpq	0x30(%rsp), %rax
               	jge	<addr>
               	movq	0x38(%rsp), %r12
               	movslq	%r12d, %r12
               	movq	0x30(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%r13,%r15,4), %r14
               	leaq	-0x1(%r12), %rbx
               	jmp	<addr>
               	movslq	%r12d, %rax
               	movslq	(%r13,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%rbx
               	movslq	%ebx, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rdi
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r12d, %rax
               	leaq	0x1(%rax), %r12
               	movslq	%r12d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rbx
               	leaq	-0x1(%rbx), %rdx
               	movq	%r13, %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%rbx), %rsi
               	movq	%r13, %rdi
               	movq	0x30(%rsp), %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x14, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0xc, %eax
               	movl	%eax, (%rbx)
               	movl	$0x7, %eax
               	movl	%eax, 0x4(%rbx)
               	movl	$0xf, %eax
               	movl	%eax, 0x8(%rbx)
               	movl	$0x5, %eax
               	movl	%eax, 0xc(%rbx)
               	movl	$0xa, %eax
               	movl	%eax, 0x10(%rbx)
               	xorq	%r13, %r13
               	movslq	0x10(%rbx), %r14
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	leaq	0x10(%rbx), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%r13, %r13
               	movq	0x58(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%r13, %r13
               	movq	0x50(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%r13, %r13
               	movq	0x48(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%r13, %r13
               	movq	0x68(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	xorq	%r10, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%r13, %r13
               	movslq	%eax, %r15
               	movslq	(%rbx,%r15,4), %r14
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x40(%rsp), %rdx
               	callq	<addr>
               	movq	0x60(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x68(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rdx
               	callq	<addr>
               	movq	0x70(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x48(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %rax
               	cmpq	0x68(%rsp), %rax
               	jge	<addr>
               	movq	0x70(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x68(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x70(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x48(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x48(%rsp), %rdx
               	callq	<addr>
               	movq	0x60(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x68(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rdx
               	callq	<addr>
               	movq	0x78(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x50(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x70(%rsp), %rax
               	cmpq	0x50(%rsp), %rax
               	jge	<addr>
               	movq	0x70(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x50(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movq	0x70(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x70(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %rax
               	cmpq	0x68(%rsp), %rax
               	jge	<addr>
               	movq	0x70(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x68(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x70(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x48(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x48(%rsp), %rdx
               	callq	<addr>
               	movq	0x60(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x68(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rdx
               	callq	<addr>
               	movq	0x78(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x50(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %rax
               	cmpq	0x70(%rsp), %rax
               	jge	<addr>
               	movq	0x78(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x70(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x60(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rdx
               	callq	<addr>
               	movq	0x68(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x70(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rdx
               	callq	<addr>
               	movq	0x80(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x58(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x78(%rsp), %rax
               	cmpq	0x58(%rsp), %rax
               	jge	<addr>
               	movq	0x78(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x58(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movq	0x78(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x70(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x70(%rsp), %rax
               	cmpq	0x50(%rsp), %rax
               	jge	<addr>
               	movq	0x70(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x50(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movq	0x70(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x70(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x70(%rsp), %rax
               	cmpq	0x68(%rsp), %rax
               	jge	<addr>
               	movq	0x70(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x68(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x70(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x48(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x48(%rsp), %rdx
               	callq	<addr>
               	movq	0x60(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x68(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rdx
               	callq	<addr>
               	movq	0x78(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x50(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %rax
               	cmpq	0x70(%rsp), %rax
               	jge	<addr>
               	movq	0x78(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x70(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x60(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rdx
               	callq	<addr>
               	movq	0x68(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x70(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rdx
               	callq	<addr>
               	movq	0x80(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x58(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x80(%rsp), %rax
               	cmpq	0x78(%rsp), %rax
               	jge	<addr>
               	movq	0x80(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x78(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x80(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x68(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x80(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rdx
               	callq	<addr>
               	movq	0x70(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x78(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x80(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rdx
               	callq	<addr>
               	movq	0x88(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r15
               	cmpq	$0x4, %r15
               	jge	<addr>
               	movslq	%r15d, %r13
               	movslq	0x10(%rbx), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	leaq	0x10(%rbx), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%r15d, %r10
               	movq	%r10, 0x78(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x78(%rsp), %rax
               	cmpq	0x60(%rsp), %rax
               	jge	<addr>
               	movq	0x78(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x60(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movq	0x78(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x78(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x78(%rsp), %rax
               	cmpq	0x70(%rsp), %rax
               	jge	<addr>
               	movq	0x78(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x70(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x58(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x58(%rsp), %rdx
               	callq	<addr>
               	movq	0x68(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x70(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x70(%rsp), %rdx
               	callq	<addr>
               	movq	0x80(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x60(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x80(%rsp), %rax
               	cmpq	0x78(%rsp), %rax
               	jge	<addr>
               	movq	0x80(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x78(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x80(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x68(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x80(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rdx
               	callq	<addr>
               	movq	0x70(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x78(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x80(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rdx
               	callq	<addr>
               	movq	0x88(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r15
               	cmpq	$0x4, %r15
               	jge	<addr>
               	movslq	%r15d, %r13
               	movslq	0x10(%rbx), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	leaq	0x10(%rbx), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%r15d, %r10
               	movq	%r10, 0x80(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x80(%rsp), %rax
               	cmpq	0x78(%rsp), %rax
               	jge	<addr>
               	movq	0x80(%rsp), %r13
               	movslq	%r13d, %r13
               	movq	0x78(%rsp), %r15
               	movslq	%r15d, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x80(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x68(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x80(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rdx
               	callq	<addr>
               	movq	0x70(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x78(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x80(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rdx
               	callq	<addr>
               	movq	0x88(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	movq	0x88(%rsp), %r13
               	movslq	%r13d, %r13
               	movslq	0x10(%rbx), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	leaq	0x10(%rbx), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x88(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x78(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	%ecx, %r15
               	movslq	(%rbx,%r15,4), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x88(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x78(%rsp), %rdx
               	callq	<addr>
               	movq	0x80(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %r15
               	movslq	%r15d, %rax
               	movl	$0x4, %r10d
               	movq	%r10, 0x88(%rsp)
               	cmpq	$0x4, %rax
               	jge	<addr>
               	movslq	%eax, %r13
               	movslq	0x10(%rbx), %r14
               	leaq	-0x1(%r13), %r12
               	jmp	<addr>
               	movslq	%r13d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%r12
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r13d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	movslq	%r13d, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	leaq	0x10(%rbx), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	0x88(%rsp), %rdx
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rbx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rbx), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rbx), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	0x10(%rbx), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
