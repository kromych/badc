
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
               	xorl	%eax, %eax
               	cmpl	%edx, %eax
               	jge	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xbf8, %rsp            # imm = 0xBF8
               	pushq	%rbx
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
               	leaq	-0xb60(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb00(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x760(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x758(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x750(%rbp), %rcx
               	xorl	%eax, %eax
               	movb	$-0x1, (%rcx)
               	movb	$-0x1, 0x1(%rcx)
               	movb	$-0x1, 0x2(%rcx)
               	movb	$-0x1, 0x3(%rcx)
               	movb	$-0x1, 0x4(%rcx)
               	movb	$-0x1, 0x5(%rcx)
               	movb	$-0x1, 0x6(%rcx)
               	movb	$-0x1, 0x7(%rcx)
               	movb	$-0x1, 0x8(%rcx)
               	movb	$-0x1, 0x9(%rcx)
               	movb	$-0x1, 0xa(%rcx)
               	movb	$-0x1, 0xb(%rcx)
               	movb	$-0x1, 0xc(%rcx)
               	movb	$-0x1, 0xd(%rcx)
               	movb	$-0x1, 0xe(%rcx)
               	movb	$-0x1, 0xf(%rcx)
               	leaq	-0xaf0(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rcx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x750(%rbp), %rcx
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	movb	$-0x1, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	$-0x1, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	$-0x1, 0x5(%rcx)
               	movb	$0x0, 0x6(%rcx)
               	movb	$0x0, 0x7(%rcx)
               	movb	$0x0, 0x8(%rcx)
               	movb	$-0x1, 0x9(%rcx)
               	movb	$0x0, 0xa(%rcx)
               	movb	$0x0, 0xb(%rcx)
               	movb	$0x0, 0xc(%rcx)
               	movq	$-0x1, %r8
               	movb	%r8b, 0xd(%rcx)
               	movb	$0x0, 0xe(%rcx)
               	xorl	%r9d, %r9d
               	movb	%r9b, 0xf(%rcx)
               	leaq	-0xae0(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0xbf0(%rbp), %rdx
               	leaq	-0xbe0(%rbp), %rsi
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x620(%rbp), %rdi
               	movzbq	(%rdx,%rax), %rcx
               	movzbq	(%rsi,%rax), %rbx
               	cmpl	%ebx, %ecx
               	jne	<addr>
               	movq	%r8, %rcx
               	jmp	<addr>
               	movq	%r9, %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xae0(%rbp), %rdi
               	leaq	-0x620(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0xbe0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movzbq	(%rcx), %rax
               	movzbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xad0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x600(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	je	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xad0(%rbp), %rdi
               	leaq	-0x600(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0xbe0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movzbq	(%rcx), %rax
               	movzbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xac0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x5e0(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jge	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xac0(%rbp), %rdi
               	leaq	-0x5e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0xbe0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movzbq	(%rcx), %rax
               	movzbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setbe	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xab0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x5c0(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jg	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xab0(%rbp), %rdi
               	leaq	-0x5c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0xbe0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movzbq	(%rcx), %rax
               	movzbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	seta	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xaa0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x5a0(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jle	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xaa0(%rbp), %rdi
               	leaq	-0x5a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0xbe0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movzbq	(%rcx), %rax
               	movzbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movzbq	0x1(%rcx), %rdi
               	movzbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movzbq	0x2(%rcx), %rdi
               	movzbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movzbq	0x3(%rcx), %rdi
               	movzbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movzbq	0x4(%rcx), %rdi
               	movzbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movzbq	0x5(%rcx), %rdi
               	movzbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movzbq	0x6(%rcx), %rdi
               	movzbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movzbq	0x7(%rcx), %rdi
               	movzbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movzbq	0x8(%rcx), %rdi
               	movzbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movzbq	0x9(%rcx), %rdi
               	movzbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movzbq	0xa(%rcx), %rdi
               	movzbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movzbq	0xb(%rcx), %rdi
               	movzbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movzbq	0xc(%rcx), %rdi
               	movzbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movzbq	0xd(%rcx), %rdi
               	movzbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movzbq	0xe(%rcx), %rdi
               	movzbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movzbq	0xf(%rcx), %rdi
               	movzbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xa90(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x580(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jl	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xa90(%rbp), %rdi
               	leaq	-0x580(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbd0(%rbp), %rcx
               	leaq	-0xbc0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movsbq	0x1(%rcx), %rdi
               	movsbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movsbq	0x2(%rcx), %rdi
               	movsbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movsbq	0x3(%rcx), %rdi
               	movsbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movsbq	0x4(%rcx), %rdi
               	movsbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movsbq	0x5(%rcx), %rdi
               	movsbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movsbq	0x6(%rcx), %rdi
               	movsbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movsbq	0x7(%rcx), %rdi
               	movsbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movsbq	0x8(%rcx), %rdi
               	movsbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movsbq	0x9(%rcx), %rdi
               	movsbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movsbq	0xa(%rcx), %rdi
               	movsbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movsbq	0xb(%rcx), %rdi
               	movsbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movsbq	0xc(%rcx), %rdi
               	movsbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movsbq	0xd(%rcx), %rdi
               	movsbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movsbq	0xe(%rcx), %rdi
               	movsbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movsbq	0xf(%rcx), %rdi
               	movsbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xa80(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x560(%rbp), %rdi
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xa80(%rbp), %rdi
               	leaq	-0x560(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbd0(%rbp), %rcx
               	leaq	-0xbc0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movsbq	0x1(%rcx), %rdi
               	movsbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movsbq	0x2(%rcx), %rdi
               	movsbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movsbq	0x3(%rcx), %rdi
               	movsbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movsbq	0x4(%rcx), %rdi
               	movsbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movsbq	0x5(%rcx), %rdi
               	movsbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movsbq	0x6(%rcx), %rdi
               	movsbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movsbq	0x7(%rcx), %rdi
               	movsbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movsbq	0x8(%rcx), %rdi
               	movsbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movsbq	0x9(%rcx), %rdi
               	movsbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movsbq	0xa(%rcx), %rdi
               	movsbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movsbq	0xb(%rcx), %rdi
               	movsbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movsbq	0xc(%rcx), %rdi
               	movsbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movsbq	0xd(%rcx), %rdi
               	movsbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movsbq	0xe(%rcx), %rdi
               	movsbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movsbq	0xf(%rcx), %rdi
               	movsbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xa70(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x540(%rbp), %rdi
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	je	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xa70(%rbp), %rdi
               	leaq	-0x540(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbd0(%rbp), %rcx
               	leaq	-0xbc0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setl	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movsbq	0x1(%rcx), %rdi
               	movsbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movsbq	0x2(%rcx), %rdi
               	movsbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movsbq	0x3(%rcx), %rdi
               	movsbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movsbq	0x4(%rcx), %rdi
               	movsbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movsbq	0x5(%rcx), %rdi
               	movsbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movsbq	0x6(%rcx), %rdi
               	movsbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movsbq	0x7(%rcx), %rdi
               	movsbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movsbq	0x8(%rcx), %rdi
               	movsbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movsbq	0x9(%rcx), %rdi
               	movsbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movsbq	0xa(%rcx), %rdi
               	movsbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movsbq	0xb(%rcx), %rdi
               	movsbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movsbq	0xc(%rcx), %rdi
               	movsbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movsbq	0xd(%rcx), %rdi
               	movsbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movsbq	0xe(%rcx), %rdi
               	movsbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movsbq	0xf(%rcx), %rdi
               	movsbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xa60(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x520(%rbp), %rdi
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jge	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xa60(%rbp), %rdi
               	leaq	-0x520(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbd0(%rbp), %rcx
               	leaq	-0xbc0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setle	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movsbq	0x1(%rcx), %rdi
               	movsbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movsbq	0x2(%rcx), %rdi
               	movsbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movsbq	0x3(%rcx), %rdi
               	movsbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movsbq	0x4(%rcx), %rdi
               	movsbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movsbq	0x5(%rcx), %rdi
               	movsbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movsbq	0x6(%rcx), %rdi
               	movsbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movsbq	0x7(%rcx), %rdi
               	movsbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movsbq	0x8(%rcx), %rdi
               	movsbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movsbq	0x9(%rcx), %rdi
               	movsbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movsbq	0xa(%rcx), %rdi
               	movsbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movsbq	0xb(%rcx), %rdi
               	movsbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movsbq	0xc(%rcx), %rdi
               	movsbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movsbq	0xd(%rcx), %rdi
               	movsbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movsbq	0xe(%rcx), %rdi
               	movsbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movsbq	0xf(%rcx), %rdi
               	movsbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xa50(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x500(%rbp), %rdi
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jg	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xa50(%rbp), %rdi
               	leaq	-0x500(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbd0(%rbp), %rcx
               	leaq	-0xbc0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movsbq	0x1(%rcx), %rdi
               	movsbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movsbq	0x2(%rcx), %rdi
               	movsbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movsbq	0x3(%rcx), %rdi
               	movsbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movsbq	0x4(%rcx), %rdi
               	movsbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movsbq	0x5(%rcx), %rdi
               	movsbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movsbq	0x6(%rcx), %rdi
               	movsbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movsbq	0x7(%rcx), %rdi
               	movsbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movsbq	0x8(%rcx), %rdi
               	movsbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movsbq	0x9(%rcx), %rdi
               	movsbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movsbq	0xa(%rcx), %rdi
               	movsbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movsbq	0xb(%rcx), %rdi
               	movsbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movsbq	0xc(%rcx), %rdi
               	movsbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movsbq	0xd(%rcx), %rdi
               	movsbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movsbq	0xe(%rcx), %rdi
               	movsbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movsbq	0xf(%rcx), %rdi
               	movsbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xa40(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x4e0(%rbp), %rdi
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jle	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xa40(%rbp), %rdi
               	leaq	-0x4e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbd0(%rbp), %rcx
               	leaq	-0xbc0(%rbp), %rdx
               	leaq	-0x750(%rbp), %rsi
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rdi
               	cmpl	%edi, %eax
               	setge	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, (%rsi)
               	movsbq	0x1(%rcx), %rdi
               	movsbq	0x1(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x1(%rsi)
               	movsbq	0x2(%rcx), %rdi
               	movsbq	0x2(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x2(%rsi)
               	movsbq	0x3(%rcx), %rdi
               	movsbq	0x3(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x3(%rsi)
               	movsbq	0x4(%rcx), %rdi
               	movsbq	0x4(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x4(%rsi)
               	movsbq	0x5(%rcx), %rdi
               	movsbq	0x5(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x5(%rsi)
               	movsbq	0x6(%rcx), %rdi
               	movsbq	0x6(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x6(%rsi)
               	movsbq	0x7(%rcx), %rdi
               	movsbq	0x7(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x7(%rsi)
               	movsbq	0x8(%rcx), %rdi
               	movsbq	0x8(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x8(%rsi)
               	movsbq	0x9(%rcx), %rdi
               	movsbq	0x9(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0x9(%rsi)
               	movsbq	0xa(%rcx), %rdi
               	movsbq	0xa(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xa(%rsi)
               	movsbq	0xb(%rcx), %rdi
               	movsbq	0xb(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xb(%rsi)
               	movsbq	0xc(%rcx), %rdi
               	movsbq	0xc(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xc(%rsi)
               	movsbq	0xd(%rcx), %rdi
               	movsbq	0xd(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xd(%rsi)
               	movsbq	0xe(%rcx), %rdi
               	movsbq	0xe(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xe(%rsi)
               	movsbq	0xf(%rcx), %rdi
               	movsbq	0xf(%rdx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movb	%dil, 0xf(%rsi)
               	leaq	-0xa30(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x4c0(%rbp), %rdi
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %r8
               	cmpl	%r8d, %esi
               	jl	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	xorl	%esi, %esi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xa30(%rbp), %rdi
               	leaq	-0x4c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbb0(%rbp), %rdx
               	leaq	-0xba0(%rbp), %rsi
               	leaq	-0x750(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
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
               	leaq	-0xa20(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x4a0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzwq	(%r8), %r8
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa20(%rbp), %rdi
               	leaq	-0x4a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbb0(%rbp), %rdx
               	leaq	-0xba0(%rbp), %rsi
               	leaq	-0x750(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
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
               	leaq	-0xa10(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x480(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzwq	(%r8), %r8
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa10(%rbp), %rdi
               	leaq	-0x480(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbb0(%rbp), %rdx
               	leaq	-0xba0(%rbp), %rsi
               	leaq	-0x750(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
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
               	leaq	-0xa00(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x460(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzwq	(%r8), %r8
               	addq	%rsi, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xa00(%rbp), %rdi
               	leaq	-0x460(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb90(%rbp), %rdx
               	leaq	-0xb80(%rbp), %rsi
               	leaq	-0x750(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
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
               	leaq	-0x9f0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x440(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movswq	(%r8), %r8
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x9f0(%rbp), %rdi
               	leaq	-0x440(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb90(%rbp), %rdx
               	leaq	-0xb80(%rbp), %rsi
               	leaq	-0x750(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setle	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
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
               	leaq	-0x9e0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x420(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movswq	(%r8), %r8
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	jg	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x9e0(%rbp), %rdi
               	leaq	-0x420(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb90(%rbp), %rdx
               	leaq	-0xb80(%rbp), %rsi
               	leaq	-0x750(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
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
               	leaq	-0x9d0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movswq	(%r8), %r8
               	addq	%rsi, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x9d0(%rbp), %rdi
               	leaq	-0x400(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb70(%rbp), %rdx
               	leaq	-0xb60(%rbp), %rcx
               	movl	(%rdx), %eax
               	movl	(%rcx), %esi
               	cmpl	%esi, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movl	0x4(%rdx), %edi
               	movl	0x4(%rcx), %r8d
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movl	0x8(%rdx), %r8d
               	movl	0x8(%rcx), %r9d
               	cmpl	%r9d, %r8d
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movl	0xc(%rdx), %r9d
               	movl	0xc(%rcx), %ecx
               	cmpl	%ecx, %r9d
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	leaq	-0x9c0(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xb60(%rbp), %rsi
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x3e0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movl	(%r8), %r8d
               	addq	%rsi, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %r8d
               	jae	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x9c0(%rbp), %rdi
               	leaq	-0x3e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb70(%rbp), %rdx
               	leaq	-0xb60(%rbp), %rcx
               	movl	(%rdx), %eax
               	movl	(%rcx), %esi
               	cmpl	%esi, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movl	0x4(%rdx), %edi
               	movl	0x4(%rcx), %r8d
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movl	0x8(%rdx), %r8d
               	movl	0x8(%rcx), %r9d
               	cmpl	%r9d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movl	0xc(%rdx), %r9d
               	movl	0xc(%rcx), %ecx
               	cmpl	%ecx, %r9d
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	leaq	-0x9b0(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xb60(%rbp), %rsi
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x3c0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movl	(%r8), %r8d
               	addq	%rsi, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x9b0(%rbp), %rdi
               	leaq	-0x3c0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb50(%rbp), %rdx
               	leaq	-0xb40(%rbp), %rcx
               	movslq	(%rdx), %rax
               	movslq	(%rcx), %rsi
               	cmpl	%esi, %eax
               	setl	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	0x4(%rdx), %rdi
               	movslq	0x4(%rcx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movslq	0x8(%rdx), %r8
               	movslq	0x8(%rcx), %r9
               	cmpl	%r9d, %r8d
               	setl	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movslq	0xc(%rdx), %r9
               	movslq	0xc(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	leaq	-0x9a0(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xb40(%rbp), %rsi
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x3a0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movslq	(%r8), %r8
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x9a0(%rbp), %rdi
               	leaq	-0x3a0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb50(%rbp), %rdx
               	leaq	-0xb40(%rbp), %rcx
               	movslq	(%rdx), %rax
               	movslq	(%rcx), %rsi
               	cmpl	%esi, %eax
               	setge	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	0x4(%rdx), %rdi
               	movslq	0x4(%rcx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movslq	0x8(%rdx), %r8
               	movslq	0x8(%rcx), %r9
               	cmpl	%r9d, %r8d
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movslq	0xc(%rdx), %r9
               	movslq	0xc(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	leaq	-0x990(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xb40(%rbp), %rsi
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x380(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movslq	(%r8), %r8
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x990(%rbp), %rdi
               	leaq	-0x380(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb50(%rbp), %rdx
               	leaq	-0xb40(%rbp), %rcx
               	movslq	(%rdx), %rax
               	movslq	(%rcx), %rsi
               	cmpl	%esi, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movslq	0x4(%rdx), %rdi
               	movslq	0x4(%rcx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	movslq	0x8(%rdx), %r8
               	movslq	0x8(%rcx), %r9
               	cmpl	%r9d, %r8d
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	movslq	0xc(%rdx), %r9
               	movslq	0xc(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	leaq	-0x980(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xb40(%rbp), %rsi
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x360(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movslq	(%r8), %r8
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x980(%rbp), %rdi
               	leaq	-0x360(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb30(%rbp), %rsi
               	leaq	-0xb20(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	setb	%al
               	movzbq	%al, %rax
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	0x8(%rsi), %rax
               	movq	0x8(%rdi), %r8
               	cmpq	%r8, %rax
               	setb	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	leaq	-0x970(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x340(%rbp), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %r9
               	jae	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x970(%rbp), %rdi
               	leaq	-0x340(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb30(%rbp), %rsi
               	leaq	-0xb20(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	seta	%al
               	movzbq	%al, %rax
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	0x8(%rsi), %rax
               	movq	0x8(%rdi), %r8
               	cmpq	%r8, %rax
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	leaq	-0x960(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x320(%rbp), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %r9
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x960(%rbp), %rdi
               	leaq	-0x320(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb10(%rbp), %rsi
               	leaq	-0xb00(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	0x8(%rsi), %rax
               	movq	0x8(%rdi), %r8
               	cmpq	%r8, %rax
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	leaq	-0x950(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x300(%rbp), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %r9
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x950(%rbp), %rdi
               	leaq	-0x300(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb10(%rbp), %rsi
               	leaq	-0xb00(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	0x8(%rsi), %rax
               	movq	0x8(%rdi), %r8
               	cmpq	%r8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	leaq	-0x940(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x2e0(%rbp), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %r9
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x940(%rbp), %rdi
               	leaq	-0x2e0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x760(%rbp), %rdx
               	leaq	-0x758(%rbp), %rsi
               	leaq	-0x748(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
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
               	leaq	-0x2d0(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	popq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x2c8(%rbp), %rdi
               	movzbq	(%rdx,%rax), %rcx
               	movzbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x2d0(%rbp), %rdi
               	leaq	-0x2c8(%rbp), %rsi
               	movl	$0x8, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x748(%rbp), %rax
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
               	leaq	-0x930(%rbp), %rdx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	leaq	-0x920(%rbp), %rsi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movss	(%rax,%riz), %xmm0
               	movss	%xmm0, 0x8(%rdx,%riz)
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	-0x910(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x290(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8,%riz), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x910(%rbp), %rdi
               	leaq	-0x290(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x930(%rbp), %rdx
               	leaq	-0x920(%rbp), %rsi
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	-0x900(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x270(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8,%riz), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x900(%rbp), %rdi
               	leaq	-0x270(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x930(%rbp), %rdx
               	leaq	-0x920(%rbp), %rsi
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	-0x8f0(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x250(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8,%riz), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x8f0(%rbp), %rdi
               	leaq	-0x250(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x930(%rbp), %rdx
               	leaq	-0x920(%rbp), %rsi
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	-0x8e0(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x230(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8,%riz), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jb	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x8e0(%rbp), %rdi
               	leaq	-0x230(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x930(%rbp), %rdx
               	leaq	-0x920(%rbp), %rsi
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	-0x8d0(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8,%riz), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x8d0(%rbp), %rdi
               	leaq	-0x210(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x24, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x930(%rbp), %rdx
               	leaq	-0x920(%rbp), %rsi
               	movss	(%rdx,%riz), %xmm0
               	movss	(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movss	0x4(%rdx,%riz), %xmm0
               	movss	0x4(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	movss	0x8(%rdx,%riz), %xmm0
               	movss	0x8(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movss	0xc(%rdx,%riz), %xmm0
               	movss	0xc(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	-0x8c0(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x1f0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8,%riz), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jb	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x8c0(%rbp), %rdi
               	leaq	-0x1f0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x25, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x930(%rbp), %rdx
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movss	(%rdx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	subq	%rcx, %rdi
               	movss	0x4(%rdx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	movss	0x8(%rdx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movss	0xc(%rdx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	leaq	-0x8b0(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x1d0(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	addq	%rdx, %rcx
               	movss	(%rcx,%riz), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x8b0(%rbp), %rdi
               	leaq	-0x1d0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x26, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x748(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x8a0(%rbp), %rsi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	-0x890(%rbp), %rdi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movsd	(%rax,%riz), %xmm0
               	movsd	%xmm0, 0x8(%rsi,%riz)
               	movsd	(%rsi,%riz), %xmm0
               	movsd	(%rdi,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movsd	0x8(%rsi,%riz), %xmm0
               	movsd	0x8(%rdi,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	leaq	-0x880(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x190(%rbp), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movsd	(%r9,%riz), %xmm0
               	addq	%rdi, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x880(%rbp), %rdi
               	leaq	-0x190(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x27, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x8a0(%rbp), %rsi
               	leaq	-0x890(%rbp), %rdi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	(%rdi,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movsd	0x8(%rsi,%riz), %xmm0
               	movsd	0x8(%rdi,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	leaq	-0x870(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x170(%rbp), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movsd	(%r9,%riz), %xmm0
               	addq	%rdi, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x870(%rbp), %rdi
               	leaq	-0x170(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x8a0(%rbp), %rsi
               	leaq	-0x890(%rbp), %rdi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	(%rdi,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movsd	0x8(%rsi,%riz), %xmm0
               	movsd	0x8(%rdi,%riz), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movq	%rdx, %r8
               	subq	%rax, %r8
               	leaq	-0x860(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	%rdx, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x150(%rbp), %r8
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	leaq	(%rsi,%rcx), %r9
               	movsd	(%r9,%riz), %xmm0
               	addq	%rdi, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x860(%rbp), %rdi
               	leaq	-0x150(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0x750(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	cmpl	$0x64, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%esi, %esi
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
               	leaq	-0x850(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rsi, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x130(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0x64, %edx
               	jle	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	movb	%dl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x850(%rbp), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0x750(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	cmpl	$0x3, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%esi, %esi
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
               	leaq	-0x840(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rsi, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x110(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	movb	%dl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x840(%rbp), %rdi
               	leaq	-0x110(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2b, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0x750(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	cmpl	$0xff, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%esi, %esi
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
               	leaq	-0x830(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rsi, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0xff, %edx
               	jge	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	movb	%dl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x830(%rbp), %rdi
               	leaq	-0xf0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2c, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbd0(%rbp), %rcx
               	movq	$-0x5, %rdx
               	leaq	-0x750(%rbp), %rax
               	movsbq	(%rcx), %rsi
               	cmpl	%edx, %esi
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%esi, %esi
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
               	leaq	-0x820(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rsi, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$-0x5, %edx
               	jle	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	movb	%dl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x820(%rbp), %rdi
               	leaq	-0xd0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb50(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movslq	(%rsi), %rax
               	testl	%eax, %eax
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	0x4(%rsi), %rax
               	testl	%eax, %eax
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movslq	0x8(%rsi), %rax
               	testl	%eax, %eax
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movslq	0xc(%rsi), %rax
               	testl	%eax, %eax
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rcx, %r9
               	subq	%rax, %r9
               	leaq	-0x810(%rbp), %rax
               	movl	%edx, (%rax)
               	movl	%edi, 0x4(%rax)
               	movl	%r8d, 0x8(%rax)
               	movl	%r9d, 0xc(%rax)
               	movq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	testl	%edx, %edx
               	jge	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movl	%edx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x810(%rbp), %rdi
               	leaq	-0xb0(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2e, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xb30(%rbp), %rsi
               	movq	(%rsi), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movq	0x8(%rsi), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	leaq	-0x800(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x90(%rbp), %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movq	%rdx, (%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x800(%rbp), %rdi
               	leaq	-0x90(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2f, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xbf0(%rbp), %rcx
               	leaq	-0x750(%rbp), %rax
               	movzbq	(%rcx), %rdx
               	cmpl	$0x64, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%esi, %esi
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
               	leaq	-0x7f0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rsi, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	-0x70(%rbp), %rdi
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0x64, %edx
               	jge	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	movb	%dl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x7f0(%rbp), %rdi
               	leaq	-0x70(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x30, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ecx, %ecx
               	leaq	-0xb50(%rbp), %rsi
               	movslq	(%rsi), %rax
               	testl	%eax, %eax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	movslq	0x4(%rsi), %rax
               	testl	%eax, %eax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movslq	0x8(%rsi), %rax
               	testl	%eax, %eax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rcx, %r8
               	subq	%rax, %r8
               	movslq	0xc(%rsi), %rax
               	testl	%eax, %eax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rcx, %r9
               	subq	%rax, %r9
               	leaq	-0x7e0(%rbp), %rax
               	movl	%edx, (%rax)
               	movl	%edi, 0x4(%rax)
               	movl	%r8d, 0x8(%rax)
               	movl	%r9d, 0xc(%rax)
               	movq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movl	%edx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x7e0(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x31, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x7d0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x7c0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x7a0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x790(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x750(%rbp), %rax
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0x0, 0x4(%rax)
               	movl	$0xffffffff, 0x8(%rax)  # imm = 0xFFFFFFFF
               	movl	$0x0, 0xc(%rax)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movabsq	$0x500000001, %r8       # imm = 0x500000001
               	andq	%rcx, %r8
               	movabsq	$0x900000003, %rdi      # imm = 0x900000003
               	andq	%rdx, %rdi
               	movl	$0x0, (%rax)
               	movl	$0xffffffff, 0x4(%rax)  # imm = 0xFFFFFFFF
               	xorl	%edx, %edx
               	leaq	0x8(%rax), %rsi
               	movl	%edx, (%rsi)
               	movl	$0xffffffff, 0xc(%rax)  # imm = 0xFFFFFFFF
               	movq	(%rax), %rax
               	movabsq	$0x400000002, %r9       # imm = 0x400000002
               	andq	%rax, %r9
               	movq	(%rsi), %rax
               	movabsq	$0x800000006, %rcx      # imm = 0x800000006
               	andq	%rax, %rcx
               	leaq	-0x750(%rbp), %rax
               	movq	%r8, %rsi
               	orq	%r9, %rsi
               	movq	%rsi, (%rax)
               	orq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %esi
               	movl	0x8(%rax), %edi
               	movl	0xc(%rax), %eax
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpl	$0x4, %esi
               	jne	<addr>
               	cmpl	$0x3, %edi
               	jne	<addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x33, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdx, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
