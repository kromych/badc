
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdx, %rbx
               	movslq	%esi, %rsi
               	movslq	%ebx, %rbx
               	movslq	(%rdi,%rbx,4), %r8
               	leaq	-0x1(%rsi), %rax
               	jmp	<addr>
               	movslq	(%rdi,%rcx,4), %rdx
               	cmpq	%r8, %rdx
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rdx
               	movslq	(%rdi,%rdx,4), %r9
               	movslq	(%rdi,%rcx,4), %r12
               	movl	%r12d, (%rdi,%rdx,4)
               	movl	%r9d, (%rdi,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rdi,%rcx,4), %rdx
               	movslq	(%rdi,%rbx,4), %rsi
               	movl	%esi, (%rdi,%rcx,4)
               	movl	%edx, (%rdi,%rbx,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<quicksort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r14
               	movq	%rsi, %r13
               	movslq	%r13d, %r13
               	movslq	%r14d, %r14
               	cmpq	%r14, %r13
               	jge	<addr>
               	movslq	%r13d, %rdx
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
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
               	xorq	%rdx, %rdx
               	movslq	0x10(%rbx), %rdi
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r9
               	movl	%r9d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	0x10(%rbx), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, 0x10(%rbx)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r15
               	leaq	-0x1(%r15), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%rdx, %rdx
               	movq	0x50(%rsp), %r9
               	movslq	%r9d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%rdx, %rdx
               	movq	0x48(%rsp), %r9
               	movslq	%r9d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	xorq	%rdx, %rdx
               	movq	0x40(%rsp), %r9
               	movslq	%r9d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r14
               	leaq	-0x1(%r14), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r13
               	testq	%r13, %r13
               	jle	<addr>
               	xorq	%rdx, %rdx
               	movslq	%r13d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x38(%rsp)
               	xorq	%r10, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jle	<addr>
               	movq	%rbx, %rdi
               	movq	0x30(%rsp), %rsi
               	movq	0x38(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x58(%rsp)
               	movq	0x58(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	movq	0x58(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x38(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %rax
               	movslq	%eax, %rax
               	movslq	%r13d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	0x58(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x58(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	callq	<addr>
               	leaq	0x1(%r14), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r13
               	movq	0x40(%rsp), %r14
               	movslq	%r14d, %r14
               	cmpq	%r14, %r13
               	jge	<addr>
               	movslq	%r13d, %rdx
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	movslq	%r13d, %rax
               	movq	0x40(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	movq	0x40(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x58(%rsp)
               	movq	0x58(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	0x58(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x40(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r13
               	movslq	%r13d, %rax
               	movslq	%r14d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	movq	0x60(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x48(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rsp), %rax
               	cmpq	0x48(%rsp), %rax
               	jge	<addr>
               	movq	0x60(%rsp), %r12
               	movslq	%r12d, %r12
               	movq	0x48(%rsp), %r9
               	movslq	%r9d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%r12), %rax
               	movq	%r12, %rdx
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r13
               	movl	%r13d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r14
               	leaq	-0x1(%r14), %rax
               	movslq	%eax, %rax
               	movq	0x60(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x60(%rsp)
               	movslq	%eax, %r13
               	cmpq	%r13, %r12
               	jge	<addr>
               	movq	0x60(%rsp), %rdx
               	movslq	%edx, %rdx
               	movslq	%r13d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x40(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rsi
               	movq	0x40(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x58(%rsp)
               	movq	0x58(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rsi
               	callq	<addr>
               	movq	0x58(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x40(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	movslq	%r13d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	0x60(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	callq	<addr>
               	leaq	0x1(%r14), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r13
               	movq	0x48(%rsp), %r14
               	movslq	%r14d, %r14
               	cmpq	%r14, %r13
               	jge	<addr>
               	movslq	%r13d, %rdx
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x58(%rsp)
               	movslq	%r13d, %rax
               	movq	0x58(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	movq	0x58(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x60(%rsp)
               	movq	0x60(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	0x60(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x58(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r13
               	movslq	%r13d, %rax
               	movslq	%r14d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	movq	0x68(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r14
               	movq	0x50(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x50(%rsp)
               	cmpq	0x50(%rsp), %r14
               	jge	<addr>
               	movslq	%r14d, %r12
               	movq	0x50(%rsp), %r9
               	movslq	%r9d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%r12), %rax
               	movq	%r12, %rdx
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r13
               	movl	%r13d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movslq	%r14d, %r10
               	movq	%r10, 0x60(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	cmpq	0x48(%rsp), %r12
               	jge	<addr>
               	movq	0x60(%rsp), %r12
               	movslq	%r12d, %r12
               	movq	0x48(%rsp), %r9
               	movslq	%r9d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%r12), %rax
               	movq	%r12, %rdx
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r13
               	movl	%r13d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r14
               	leaq	-0x1(%r14), %rax
               	movslq	%eax, %rax
               	movq	0x60(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x60(%rsp)
               	movslq	%eax, %r13
               	cmpq	%r13, %r12
               	jge	<addr>
               	movq	0x60(%rsp), %rdx
               	movslq	%edx, %rdx
               	movslq	%r13d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x40(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rsi
               	movq	0x40(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x58(%rsp)
               	movq	0x58(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rsi
               	callq	<addr>
               	movq	0x58(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x40(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	movslq	%r13d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	0x60(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	callq	<addr>
               	leaq	0x1(%r14), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r13
               	movq	0x48(%rsp), %r14
               	movslq	%r14d, %r14
               	cmpq	%r14, %r13
               	jge	<addr>
               	movslq	%r13d, %rdx
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x58(%rsp)
               	movslq	%r13d, %rax
               	movq	0x58(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	movq	0x58(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x60(%rsp)
               	movq	0x60(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	0x60(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x58(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r13
               	movslq	%r13d, %rax
               	movslq	%r14d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	movq	0x68(%rsp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %r13
               	movq	0x50(%rsp), %r14
               	movslq	%r14d, %r14
               	cmpq	%r14, %r13
               	jge	<addr>
               	movslq	%r13d, %rdx
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movslq	%r13d, %rax
               	movq	0x60(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	movq	0x60(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x68(%rsp)
               	movq	0x68(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	0x68(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r13
               	movslq	%r13d, %rax
               	movslq	%r14d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	leaq	0x1(%r15), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r13
               	cmpq	$0x4, %r13
               	jge	<addr>
               	movslq	%r13d, %r9
               	movslq	0x10(%rbx), %rdi
               	leaq	-0x1(%r9), %rax
               	movq	%r9, %rdx
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	0x10(%rbx), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, 0x10(%rbx)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r15
               	leaq	-0x1(%r15), %rax
               	movslq	%eax, %rax
               	movslq	%r13d, %r10
               	movq	%r10, 0x68(%rsp)
               	movslq	%eax, %r10
               	movq	%r10, 0x58(%rsp)
               	cmpq	0x58(%rsp), %r9
               	jge	<addr>
               	movq	0x68(%rsp), %r12
               	movslq	%r12d, %r12
               	movq	0x58(%rsp), %r9
               	movslq	%r9d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%r12), %rax
               	movq	%r12, %rdx
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r13
               	movl	%r13d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r14
               	leaq	-0x1(%r14), %rax
               	movslq	%eax, %rax
               	movq	0x68(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x68(%rsp)
               	movslq	%eax, %r13
               	cmpq	%r13, %r12
               	jge	<addr>
               	movq	0x68(%rsp), %rdx
               	movslq	%edx, %rdx
               	movslq	%r13d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x50(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rsi
               	movq	0x50(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x60(%rsp)
               	movq	0x60(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rsi
               	callq	<addr>
               	movq	0x60(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x50(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %rax
               	movslq	%eax, %rax
               	movslq	%r13d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	0x68(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	0x68(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	callq	<addr>
               	leaq	0x1(%r14), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r13
               	movq	0x58(%rsp), %r14
               	movslq	%r14d, %r14
               	cmpq	%r14, %r13
               	jge	<addr>
               	movslq	%r13d, %rdx
               	movslq	%r14d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movslq	%r13d, %rax
               	movq	0x60(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	movq	0x60(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x68(%rsp)
               	movq	0x68(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	0x68(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r13
               	movslq	%r13d, %rax
               	movslq	%r14d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	leaq	0x1(%r15), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r13
               	cmpq	$0x4, %r13
               	jge	<addr>
               	movslq	%r13d, %r9
               	movslq	0x10(%rbx), %rdi
               	leaq	-0x1(%r9), %rax
               	movq	%r9, %rdx
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	0x10(%rbx), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, 0x10(%rbx)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r14
               	leaq	-0x1(%r14), %rax
               	movslq	%eax, %rax
               	movslq	%r13d, %r15
               	movslq	%eax, %r13
               	cmpq	%r13, %r9
               	jge	<addr>
               	movslq	%r15d, %rdx
               	movslq	%r13d, %r9
               	movslq	(%rbx,%r9,4), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r12
               	movl	%r12d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	%r9, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	(%rbx,%r9,4), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, (%rbx,%r9,4)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r12
               	leaq	-0x1(%r12), %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x60(%rsp)
               	movslq	%r15d, %rax
               	movq	0x60(%rsp), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movq	0x60(%rsp), %rdx
               	callq	<addr>
               	movq	%rax, 0x68(%rsp)
               	movq	0x68(%rsp), %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	movq	0x68(%rsp), %rsi
               	incq	%rsi
               	movq	%rbx, %rdi
               	movq	0x60(%rsp), %rdx
               	callq	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r15
               	movslq	%r15d, %rax
               	movslq	%r13d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	%r15, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	callq	<addr>
               	leaq	0x1(%r14), %rax
               	movslq	%eax, %rax
               	movslq	%eax, %r12
               	cmpq	$0x4, %r12
               	jge	<addr>
               	movslq	%r12d, %rdx
               	movslq	0x10(%rbx), %rdi
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	movslq	(%rbx,%rcx,4), %rsi
               	cmpq	%rdi, %rsi
               	jg	<addr>
               	incq	%rax
               	movslq	%eax, %rsi
               	movslq	(%rbx,%rsi,4), %r8
               	movslq	(%rbx,%rcx,4), %r9
               	movl	%r9d, (%rbx,%rsi,4)
               	movl	%r8d, (%rbx,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rcx,4), %rdx
               	movslq	0x10(%rbx), %rsi
               	movl	%esi, (%rbx,%rcx,4)
               	movl	%edx, 0x10(%rbx)
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %r13
               	leaq	-0x1(%r13), %rax
               	movslq	%eax, %r15
               	movslq	%r12d, %rax
               	movslq	%r15d, %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x1(%r14), %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	0x1(%r14), %rsi
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	callq	<addr>
               	leaq	0x1(%r13), %rax
               	movslq	%eax, %r13
               	movslq	%r13d, %rax
               	movl	$0x4, %r14d
               	cmpq	$0x4, %rax
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x1(%r12), %rdx
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%r12), %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
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
               	addq	$0x70, %rsp
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
               	addq	$0x70, %rsp
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
               	addq	$0x70, %rsp
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
               	addq	$0x70, %rsp
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
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x70, %rsp
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
