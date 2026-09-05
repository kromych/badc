
gcc_vector_compare_ops.x64:	file format elf64-x86-64

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

<same>:
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc70, %rsp            # imm = 0xC70
               	movq	%rbx, (%rsp)
               	leaq	-0xc60(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xc50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xc40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xc30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xc20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xc10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xc00(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xbf0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xbe0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xbd0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xbc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xbb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xba0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb90(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb80(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb70(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x7b8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x7a8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x7a0(%rbp), %rcx
               	xorq	%rax, %rax
               	movabsq	$-0x1, %rdi
               	movb	%dil, (%rcx)
               	movb	%dil, 0x1(%rcx)
               	movb	%dil, 0x2(%rcx)
               	movb	%dil, 0x3(%rcx)
               	movabsq	$-0x1, %rdi
               	movb	%dil, 0x4(%rcx)
               	movb	%dil, 0x5(%rcx)
               	movb	%dil, 0x6(%rcx)
               	movb	%dil, 0x7(%rcx)
               	movabsq	$-0x1, %rdi
               	movb	%dil, 0x8(%rcx)
               	movb	%dil, 0x9(%rcx)
               	movb	%dil, 0xa(%rcx)
               	movb	%dil, 0xb(%rcx)
               	movabsq	$-0x1, %rdi
               	movb	%dil, 0xc(%rcx)
               	movb	%dil, 0xd(%rcx)
               	movb	%dil, 0xe(%rcx)
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xb60(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpl	$-0x1, %esi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	leaq	-0x7a0(%rbp), %rcx
               	movb	%al, (%rcx)
               	movabsq	$-0x1, %rdi
               	movb	%dil, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	%dil, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movabsq	$-0x1, %r8
               	movb	%r8b, 0x5(%rcx)
               	xorq	%rdi, %rdi
               	movb	%dil, 0x6(%rcx)
               	movb	%dil, 0x7(%rcx)
               	movb	%dil, 0x8(%rcx)
               	movb	%r8b, 0x9(%rcx)
               	xorq	%r8, %r8
               	movb	%r8b, 0xa(%rcx)
               	movb	%r8b, 0xb(%rcx)
               	movb	%r8b, 0xc(%rcx)
               	movabsq	$-0x1, %rdi
               	movb	%dil, 0xd(%rcx)
               	movb	%r8b, 0xe(%rcx)
               	xorq	%rdx, %rdx
               	movb	%dl, 0xf(%rcx)
               	leaq	-0xb50(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0xc60(%rbp), %rsi
               	leaq	-0xc50(%rbp), %r8
               	jmp	<addr>
               	leaq	-0x668(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %r9
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%r8,%rcx), %rbx
               	movzbq	(%rbx), %rbx
               	cmpl	%ebx, %edx
               	jne	<addr>
               	movq	%rdi, %rdx
               	movb	%dl, (%r9)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb50(%rbp), %rdi
               	leaq	-0x668(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rdx
               	leaq	-0xc50(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xb40(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x648(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movzbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	je	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb40(%rbp), %rdi
               	leaq	-0x648(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rdx
               	leaq	-0xc50(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xb30(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x628(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movzbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb30(%rbp), %rdi
               	leaq	-0x628(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rdx
               	leaq	-0xc50(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setbe	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xb20(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x608(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movzbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jg	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb20(%rbp), %rdi
               	leaq	-0x608(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rdx
               	leaq	-0xc50(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	seta	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xb10(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x5e8(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movzbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jle	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb10(%rbp), %rdi
               	leaq	-0x5e8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rdx
               	leaq	-0xc50(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xb00(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x5c8(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movzbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb00(%rbp), %rdi
               	leaq	-0x5c8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc40(%rbp), %rdx
               	leaq	-0xc30(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xaf0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x5a8(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movsbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xaf0(%rbp), %rdi
               	leaq	-0x5a8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc40(%rbp), %rdx
               	leaq	-0xc30(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xae0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x588(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movsbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	je	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xae0(%rbp), %rdi
               	leaq	-0x588(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc40(%rbp), %rdx
               	leaq	-0xc30(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setl	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xad0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x568(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movsbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xad0(%rbp), %rdi
               	leaq	-0x568(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc40(%rbp), %rdx
               	leaq	-0xc30(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setle	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xac0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x548(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movsbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jg	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xac0(%rbp), %rdi
               	leaq	-0x548(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc40(%rbp), %rdx
               	leaq	-0xc30(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xab0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x528(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movsbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jle	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xab0(%rbp), %rdi
               	leaq	-0x528(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc40(%rbp), %rdx
               	leaq	-0xc30(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setge	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0xaa0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x508(%rbp), %rcx
               	movslq	%eax, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%rdx,%rdi), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	(%rsi,%rdi), %r9
               	movsbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xaa0(%rbp), %rdi
               	leaq	-0x508(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc20(%rbp), %rdx
               	leaq	-0xc10(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, (%rcx)
               	movzwq	0x2(%rdx), %rdi
               	movzwq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x2(%rcx)
               	movzwq	0x4(%rdx), %rdi
               	movzwq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x4(%rcx)
               	movzwq	0x6(%rdx), %rdi
               	movzwq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x6(%rcx)
               	movzwq	0x8(%rdx), %rdi
               	movzwq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x8(%rcx)
               	movzwq	0xa(%rdx), %rdi
               	movzwq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xa(%rcx)
               	movzwq	0xc(%rdx), %rdi
               	movzwq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xc(%rcx)
               	movzwq	0xe(%rdx), %rdi
               	movzwq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0xa90(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x4e8(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movzwq	(%r9), %r9
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa90(%rbp), %rdi
               	leaq	-0x4e8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc20(%rbp), %rdx
               	leaq	-0xc10(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, (%rcx)
               	movzwq	0x2(%rdx), %rdi
               	movzwq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x2(%rcx)
               	movzwq	0x4(%rdx), %rdi
               	movzwq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x4(%rcx)
               	movzwq	0x6(%rdx), %rdi
               	movzwq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x6(%rcx)
               	movzwq	0x8(%rdx), %rdi
               	movzwq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x8(%rcx)
               	movzwq	0xa(%rdx), %rdi
               	movzwq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xa(%rcx)
               	movzwq	0xc(%rdx), %rdi
               	movzwq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xc(%rcx)
               	movzwq	0xe(%rdx), %rdi
               	movzwq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0xa80(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x4c8(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movzwq	(%r9), %r9
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa80(%rbp), %rdi
               	leaq	-0x4c8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc20(%rbp), %rdx
               	leaq	-0xc10(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, (%rcx)
               	movzwq	0x2(%rdx), %rdi
               	movzwq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x2(%rcx)
               	movzwq	0x4(%rdx), %rdi
               	movzwq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x4(%rcx)
               	movzwq	0x6(%rdx), %rdi
               	movzwq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x6(%rcx)
               	movzwq	0x8(%rdx), %rdi
               	movzwq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x8(%rcx)
               	movzwq	0xa(%rdx), %rdi
               	movzwq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xa(%rcx)
               	movzwq	0xc(%rdx), %rdi
               	movzwq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xc(%rcx)
               	movzwq	0xe(%rdx), %rdi
               	movzwq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0xa70(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movzwq	(%r9), %r9
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	jl	<addr>
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa70(%rbp), %rdi
               	leaq	-0x4a8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc00(%rbp), %rdx
               	leaq	-0xbf0(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, (%rcx)
               	movswq	0x2(%rdx), %rdi
               	movswq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x2(%rcx)
               	movswq	0x4(%rdx), %rdi
               	movswq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x4(%rcx)
               	movswq	0x6(%rdx), %rdi
               	movswq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x6(%rcx)
               	movswq	0x8(%rdx), %rdi
               	movswq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x8(%rcx)
               	movswq	0xa(%rdx), %rdi
               	movswq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xa(%rcx)
               	movswq	0xc(%rdx), %rdi
               	movswq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xc(%rcx)
               	movswq	0xe(%rdx), %rdi
               	movswq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0xa60(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x488(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movswq	(%r9), %r9
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa60(%rbp), %rdi
               	leaq	-0x488(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc00(%rbp), %rdx
               	leaq	-0xbf0(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setle	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, (%rcx)
               	movswq	0x2(%rdx), %rdi
               	movswq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x2(%rcx)
               	movswq	0x4(%rdx), %rdi
               	movswq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x4(%rcx)
               	movswq	0x6(%rdx), %rdi
               	movswq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x6(%rcx)
               	movswq	0x8(%rdx), %rdi
               	movswq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x8(%rcx)
               	movswq	0xa(%rdx), %rdi
               	movswq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xa(%rcx)
               	movswq	0xc(%rdx), %rdi
               	movswq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xc(%rcx)
               	movswq	0xe(%rdx), %rdi
               	movswq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0xa50(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x468(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movswq	(%r9), %r9
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	jg	<addr>
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa50(%rbp), %rdi
               	leaq	-0x468(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc00(%rbp), %rdx
               	leaq	-0xbf0(%rbp), %rsi
               	leaq	-0x7a0(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorq	%rax, %rax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, (%rcx)
               	movswq	0x2(%rdx), %rdi
               	movswq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x2(%rcx)
               	movswq	0x4(%rdx), %rdi
               	movswq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x4(%rcx)
               	movswq	0x6(%rdx), %rdi
               	movswq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x6(%rcx)
               	movswq	0x8(%rdx), %rdi
               	movswq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0x8(%rcx)
               	movswq	0xa(%rdx), %rdi
               	movswq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xa(%rcx)
               	movswq	0xc(%rdx), %rdi
               	movswq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xc(%rcx)
               	movswq	0xe(%rdx), %rdi
               	movswq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0xa40(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	jmp	<addr>
               	leaq	-0x448(%rbp), %r8
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	leaq	(%rdx,%rcx), %r9
               	movswq	(%r9), %r9
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	jle	<addr>
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa40(%rbp), %rdi
               	leaq	-0x448(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xbe0(%rbp), %rsi
               	leaq	-0xbd0(%rbp), %rdi
               	leaq	-0x7a0(%rbp), %rcx
               	movl	(%rsi), %eax
               	movl	(%rdi), %edx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rsi), %edx
               	movl	0x4(%rdi), %r8d
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rcx)
               	movl	0x8(%rsi), %edx
               	movl	0x8(%rdi), %r8d
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rcx)
               	movl	0xc(%rsi), %edx
               	movl	0xc(%rdi), %r8d
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0xa30(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x428(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %r9d
               	jae	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xa30(%rbp), %rdi
               	leaq	-0x428(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xbe0(%rbp), %rsi
               	leaq	-0xbd0(%rbp), %rdi
               	leaq	-0x7a0(%rbp), %rcx
               	movl	(%rsi), %eax
               	movl	(%rdi), %edx
               	cmpl	%edx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rsi), %edx
               	movl	0x4(%rdi), %r8d
               	cmpl	%r8d, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rcx)
               	movl	0x8(%rsi), %edx
               	movl	0x8(%rdi), %r8d
               	cmpl	%r8d, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rcx)
               	movl	0xc(%rsi), %edx
               	movl	0xc(%rdi), %r8d
               	cmpl	%r8d, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0xa20(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x408(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movl	(%r9), %r9d
               	addq	%rdi, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %r9d
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xa20(%rbp), %rdi
               	leaq	-0x408(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xbc0(%rbp), %rsi
               	leaq	-0xbb0(%rbp), %rdi
               	leaq	-0x7a0(%rbp), %rcx
               	movslq	(%rsi), %rax
               	movslq	(%rdi), %rdx
               	cmpl	%edx, %eax
               	setl	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rcx)
               	movslq	0x4(%rsi), %rdx
               	movslq	0x4(%rdi), %r8
               	cmpl	%r8d, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rcx)
               	movslq	0x8(%rsi), %rdx
               	movslq	0x8(%rdi), %r8
               	cmpl	%r8d, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rcx)
               	movslq	0xc(%rsi), %rdx
               	movslq	0xc(%rdi), %r8
               	cmpl	%r8d, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0xa10(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x3e8(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xa10(%rbp), %rdi
               	leaq	-0x3e8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xbc0(%rbp), %rsi
               	leaq	-0xbb0(%rbp), %rdi
               	leaq	-0x7a0(%rbp), %rcx
               	movslq	(%rsi), %rax
               	movslq	(%rdi), %rdx
               	cmpl	%edx, %eax
               	setge	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rcx)
               	movslq	0x4(%rsi), %rdx
               	movslq	0x4(%rdi), %r8
               	cmpl	%r8d, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rcx)
               	movslq	0x8(%rsi), %rdx
               	movslq	0x8(%rdi), %r8
               	cmpl	%r8d, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rcx)
               	movslq	0xc(%rsi), %rdx
               	movslq	0xc(%rdi), %r8
               	cmpl	%r8d, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0xa00(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x3c8(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	jl	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xa00(%rbp), %rdi
               	leaq	-0x3c8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xbc0(%rbp), %rsi
               	leaq	-0xbb0(%rbp), %rdi
               	leaq	-0x7a0(%rbp), %rcx
               	movslq	(%rsi), %rax
               	movslq	(%rdi), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rcx)
               	movslq	0x4(%rsi), %rdx
               	movslq	0x4(%rdi), %r8
               	cmpl	%r8d, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rcx)
               	movslq	0x8(%rsi), %rdx
               	movslq	0x8(%rdi), %r8
               	cmpl	%r8d, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rcx)
               	movslq	0xc(%rsi), %rdx
               	movslq	0xc(%rdi), %r8
               	cmpl	%r8d, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rcx)
               	leaq	-0x9f0(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x3a8(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movslq	(%r9), %r9
               	addq	%rdi, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x9f0(%rbp), %rdi
               	leaq	-0x3a8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xba0(%rbp), %rdi
               	leaq	-0xb90(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movq	(%rdi), %rcx
               	movq	(%r8), %rdx
               	cmpq	%rdx, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	0x8(%r8), %rsi
               	cmpq	%rsi, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9e0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x388(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rbx
               	jae	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x9e0(%rbp), %rdi
               	leaq	-0x388(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xba0(%rbp), %rdi
               	leaq	-0xb90(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movq	(%rdi), %rcx
               	movq	(%r8), %rdx
               	cmpq	%rdx, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	0x8(%r8), %rsi
               	cmpq	%rsi, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x368(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rbx
               	jbe	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x9d0(%rbp), %rdi
               	leaq	-0x368(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xb80(%rbp), %rdi
               	leaq	-0xb70(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movq	(%rdi), %rcx
               	movq	(%r8), %rdx
               	cmpq	%rdx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	0x8(%r8), %rsi
               	cmpq	%rsi, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9c0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x348(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rbx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x9c0(%rbp), %rdi
               	leaq	-0x348(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xb80(%rbp), %rdi
               	leaq	-0xb70(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movq	(%rdi), %rcx
               	movq	(%r8), %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	0x8(%r8), %rsi
               	cmpq	%rsi, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x9b0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x328(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	addq	%r8, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x9b0(%rbp), %rdi
               	leaq	-0x328(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x7b8(%rbp), %rsi
               	leaq	-0x7a8(%rbp), %rdi
               	leaq	-0x798(%rbp), %rcx
               	movzbq	(%rsi), %rax
               	movzbq	(%rdi), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rsi), %rdx
               	movzbq	0x1(%rdi), %r8
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rsi), %rdx
               	movzbq	0x2(%rdi), %r8
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rsi), %rdx
               	movzbq	0x3(%rdi), %r8
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rcx)
               	movzbq	0x4(%rsi), %rdx
               	movzbq	0x4(%rdi), %r8
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rcx)
               	movzbq	0x5(%rsi), %rdx
               	movzbq	0x5(%rdi), %r8
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rcx)
               	movzbq	0x6(%rsi), %rdx
               	movzbq	0x6(%rdi), %r8
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rcx)
               	movzbq	0x7(%rsi), %rdx
               	movzbq	0x7(%rdi), %r8
               	cmpl	%r8d, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rcx)
               	leaq	-0x318(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	-0x310(%rbp), %rcx
               	movslq	%eax, %rdx
               	leaq	(%rcx,%rdx), %r8
               	leaq	(%rsi,%rdx), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rdi,%rdx), %r9
               	movzbq	(%r9), %r9
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%r8)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x318(%rbp), %rdi
               	leaq	-0x310(%rbp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x798(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x9a0(%rbp), %rsi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0x990(%rbp), %r8
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%r8)
               	popq	%rax
               	movq	%r8, %rcx
               	movss	(%rax,%riz), %xmm0
               	movss	%xmm0, 0x8(%rsi,%riz)
               	leaq	-0x7a0(%rbp), %rax
               	movss	(%rsi,%riz), %xmm0
               	movss	(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, (%rax)
               	movss	0x4(%rsi,%riz), %xmm0
               	movss	0x4(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x4(%rax)
               	movss	0x8(%rsi,%riz), %xmm0
               	movss	0x8(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x8(%rax)
               	movss	0xc(%rsi,%riz), %xmm0
               	movss	0xc(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x980(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x2d8(%rbp), %r9
               	movslq	%eax, %rdi
               	movq	%rdi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	leaq	(%rsi,%rcx), %rbx
               	movss	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x980(%rbp), %rdi
               	leaq	-0x2d8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x20, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x9a0(%rbp), %rdi
               	leaq	-0x990(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movss	(%rdi,%riz), %xmm0
               	movss	(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, (%rax)
               	movss	0x4(%rdi,%riz), %xmm0
               	movss	0x4(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x4(%rax)
               	movss	0x8(%rdi,%riz), %xmm0
               	movss	0x8(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x8(%rax)
               	movss	0xc(%rdi,%riz), %xmm0
               	movss	0xc(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x970(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x2b8(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movss	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x970(%rbp), %rdi
               	leaq	-0x2b8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x21, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x9a0(%rbp), %rdi
               	leaq	-0x990(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movss	(%rdi,%riz), %xmm0
               	movss	(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, (%rax)
               	movss	0x4(%rdi,%riz), %xmm0
               	movss	0x4(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x4(%rax)
               	movss	0x8(%rdi,%riz), %xmm0
               	movss	0x8(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x8(%rax)
               	movss	0xc(%rdi,%riz), %xmm0
               	movss	0xc(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x960(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x298(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movss	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x960(%rbp), %rdi
               	leaq	-0x298(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x22, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x9a0(%rbp), %rdi
               	leaq	-0x990(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movss	(%rdi,%riz), %xmm0
               	movss	(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, (%rax)
               	movss	0x4(%rdi,%riz), %xmm0
               	movss	0x4(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x4(%rax)
               	movss	0x8(%rdi,%riz), %xmm0
               	movss	0x8(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x8(%rax)
               	movss	0xc(%rdi,%riz), %xmm0
               	movss	0xc(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x950(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x278(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movss	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jb	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x950(%rbp), %rdi
               	leaq	-0x278(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x23, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x9a0(%rbp), %rdi
               	leaq	-0x990(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movss	(%rdi,%riz), %xmm0
               	movss	(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, (%rax)
               	movss	0x4(%rdi,%riz), %xmm0
               	movss	0x4(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x4(%rax)
               	movss	0x8(%rdi,%riz), %xmm0
               	movss	0x8(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x8(%rax)
               	movss	0xc(%rdi,%riz), %xmm0
               	movss	0xc(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x940(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x258(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movss	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jbe	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x940(%rbp), %rdi
               	leaq	-0x258(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x24, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x9a0(%rbp), %rdi
               	leaq	-0x990(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movss	(%rdi,%riz), %xmm0
               	movss	(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, (%rax)
               	movss	0x4(%rdi,%riz), %xmm0
               	movss	0x4(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x4(%rax)
               	movss	0x8(%rdi,%riz), %xmm0
               	movss	0x8(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0x8(%rax)
               	movss	0xc(%rdi,%riz), %xmm0
               	movss	0xc(%r8,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x930(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x238(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movss	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jb	<addr>
               	movabsq	$-0x1, %rcx
               	movl	%ecx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x930(%rbp), %rdi
               	leaq	-0x238(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x25, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x9a0(%rbp), %rdi
               	movabsq	$0x4000000000000000, %r8 # imm = 0x4000000000000000
               	movq	%r8, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x7a0(%rbp), %rax
               	movss	(%rdi,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rax)
               	movss	0x4(%rdi,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rax)
               	movss	0x8(%rdi,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rax)
               	movss	0xc(%rdi,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rax)
               	leaq	-0x920(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x218(%rbp), %r9
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r9
               	addq	%rdi, %rsi
               	movss	(%rsi,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x1, %rsi
               	movl	%esi, (%r9)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x920(%rbp), %rdi
               	leaq	-0x218(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x26, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x798(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x910(%rbp), %rdi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x900(%rbp), %r8
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%r8)
               	popq	%rax
               	movq	%r8, %rcx
               	movsd	(%rax,%riz), %xmm0
               	movsd	%xmm0, 0x8(%rdi,%riz)
               	leaq	-0x7a0(%rbp), %rax
               	movsd	(%rdi,%riz), %xmm0
               	movsd	(%r8,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%rax)
               	movsd	0x8(%rdi,%riz), %xmm0
               	movsd	0x8(%r8,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x8f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x1d8(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movsd	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x8f0(%rbp), %rdi
               	leaq	-0x1d8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x27, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x910(%rbp), %rdi
               	leaq	-0x900(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movsd	(%rdi,%riz), %xmm0
               	movsd	(%r8,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%rax)
               	movsd	0x8(%rdi,%riz), %xmm0
               	movsd	0x8(%r8,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x8e0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x1b8(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movsd	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x8e0(%rbp), %rdi
               	leaq	-0x1b8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x28, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x910(%rbp), %rdi
               	leaq	-0x900(%rbp), %r8
               	leaq	-0x7a0(%rbp), %rax
               	movsd	(%rdi,%riz), %xmm0
               	movsd	(%r8,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorq	%rdx, %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, (%rax)
               	movsd	0x8(%rdi,%riz), %xmm0
               	movsd	0x8(%r8,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x8d0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x198(%rbp), %r9
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	leaq	(%rdi,%rcx), %rbx
               	movsd	(%rbx,%riz), %xmm0
               	addq	%r8, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%r9)
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x8d0(%rbp), %rdi
               	leaq	-0x198(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x29, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rcx
               	leaq	-0x7a0(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x8c0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rsi, %rax
               	jmp	<addr>
               	leaq	-0x178(%rbp), %rdx
               	movslq	%eax, %rdi
               	leaq	(%rdx,%rdi), %r8
               	leaq	(%rcx,%rdi), %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	$0x64, %edx
               	jle	<addr>
               	movabsq	$-0x1, %rdx
               	movb	%dl, (%r8)
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x8c0(%rbp), %rdi
               	leaq	-0x178(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rcx
               	leaq	-0x7a0(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x8b0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rsi, %rax
               	jmp	<addr>
               	leaq	-0x158(%rbp), %rdx
               	movslq	%eax, %rdi
               	leaq	(%rdx,%rdi), %r8
               	leaq	(%rcx,%rdi), %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movabsq	$-0x1, %rdx
               	movb	%dl, (%r8)
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x8b0(%rbp), %rdi
               	leaq	-0x158(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2b, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rcx
               	leaq	-0x7a0(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x8a0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rsi, %rax
               	jmp	<addr>
               	leaq	-0x138(%rbp), %rdx
               	movslq	%eax, %rdi
               	leaq	(%rdx,%rdi), %r8
               	leaq	(%rcx,%rdi), %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	$0xff, %edx
               	jge	<addr>
               	movabsq	$-0x1, %rdx
               	movb	%dl, (%r8)
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x8a0(%rbp), %rdi
               	leaq	-0x138(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2c, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc40(%rbp), %rcx
               	movabsq	$-0x5, %rdx
               	leaq	-0x7a0(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	cmpl	%edx, %esi
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rax)
               	movsbq	0x1(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rax)
               	movsbq	0x2(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rax)
               	movsbq	0x3(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rax)
               	movsbq	0x4(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rax)
               	movsbq	0x5(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rax)
               	movsbq	0x6(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rax)
               	movsbq	0x7(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rax)
               	movsbq	0x8(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rax)
               	movsbq	0x9(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rax)
               	movsbq	0xa(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rax)
               	movsbq	0xb(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rax)
               	movsbq	0xc(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rax)
               	movsbq	0xd(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rax)
               	movsbq	0xe(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rsi, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rax)
               	movsbq	0xf(%rcx), %rdi
               	cmpl	%edx, %edi
               	setg	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x890(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rsi, %rax
               	jmp	<addr>
               	leaq	-0x118(%rbp), %rdx
               	movslq	%eax, %rdi
               	leaq	(%rdx,%rdi), %r8
               	leaq	(%rcx,%rdi), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$-0x5, %edx
               	jle	<addr>
               	movabsq	$-0x1, %rdx
               	movb	%dl, (%r8)
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x890(%rbp), %rdi
               	leaq	-0x118(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2d, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xbc0(%rbp), %rdi
               	xorq	%rcx, %rcx
               	leaq	-0x7a0(%rbp), %rax
               	movslq	(%rdi), %rdx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rax)
               	movslq	0x4(%rdi), %rdx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rax)
               	movslq	0x8(%rdi), %rdx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rax)
               	movslq	0xc(%rdi), %rdx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rax)
               	leaq	-0x880(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0xf8(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r8
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rsi
               	testl	%esi, %esi
               	jge	<addr>
               	movabsq	$-0x1, %rsi
               	movl	%esi, (%r8)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x880(%rbp), %rdi
               	leaq	-0xf8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2e, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xba0(%rbp), %rdi
               	leaq	-0x7a0(%rbp), %rax
               	movq	(%rdi), %rcx
               	cmpq	$0x5, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rdi), %rdx
               	cmpq	$0x5, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x870(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0xd8(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r8
               	addq	%rdi, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x5, %rsi
               	je	<addr>
               	movabsq	$-0x1, %rsi
               	movq	%rsi, (%r8)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x870(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2f, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc60(%rbp), %rcx
               	leaq	-0x7a0(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorq	%rsi, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x3(%rax)
               	movzbq	0x4(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x5(%rax)
               	movzbq	0x6(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x7(%rax)
               	movzbq	0x8(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xb(%rax)
               	movzbq	0xc(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xc(%rax)
               	movzbq	0xd(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xd(%rax)
               	movzbq	0xe(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	0xf(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	-0x860(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rsi, %rax
               	jmp	<addr>
               	leaq	-0xb8(%rbp), %rdx
               	movslq	%eax, %rdi
               	leaq	(%rdx,%rdi), %r8
               	leaq	(%rcx,%rdi), %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	$0x64, %edx
               	jge	<addr>
               	movabsq	$-0x1, %rdx
               	movb	%dl, (%r8)
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	0x1(%rdi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x860(%rbp), %rdi
               	leaq	-0xb8(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x30, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rcx, %rcx
               	leaq	-0xbc0(%rbp), %rdi
               	leaq	-0x7a0(%rbp), %rax
               	movslq	(%rdi), %rdx
               	testl	%edx, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, (%rax)
               	movslq	0x4(%rdi), %rdx
               	testl	%edx, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x4(%rax)
               	movslq	0x8(%rdi), %rdx
               	testl	%edx, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0x8(%rax)
               	movslq	0xc(%rdi), %rdx
               	testl	%edx, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movl	%edx, 0xc(%rax)
               	leaq	-0x850(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x98(%rbp), %r8
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r8
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rsi
               	testl	%esi, %esi
               	jl	<addr>
               	movabsq	$-0x1, %rsi
               	movl	%esi, (%r8)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x850(%rbp), %rdi
               	leaq	-0x98(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x31, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x840(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x830(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leaq	-0x810(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x800(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x7a0(%rbp), %rax
               	movabsq	$-0x1, %rdi
               	movl	%edi, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%edi, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x7f0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rdx
               	movq	(%rcx), %rdi
               	movabsq	$0x500000001, %r9       # imm = 0x500000001
               	andq	%rdi, %r9
               	movq	0x8(%rcx), %rcx
               	movabsq	$0x900000003, %rbx      # imm = 0x900000003
               	andq	%rcx, %rbx
               	xorq	%rsi, %rsi
               	movl	%esi, (%rax)
               	movabsq	$-0x1, %rdi
               	movl	%edi, 0x4(%rax)
               	leaq	0x8(%rax), %r8
               	movl	%esi, (%r8)
               	movl	%edi, 0xc(%rax)
               	movq	(%rax), %rax
               	movabsq	$0x400000002, %r11      # imm = 0x400000002
               	andq	%r11, %rax
               	movq	(%r8), %rcx
               	movabsq	$0x800000006, %rdi      # imm = 0x800000006
               	andq	%rcx, %rdi
               	leaq	-0x7a0(%rbp), %rcx
               	orq	%r9, %rax
               	movq	%rax, (%rcx)
               	movq	%rbx, %rax
               	orq	%rdi, %rax
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x7e0(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x33, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
