
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x158, %rsp            # imm = 0x158
               	pushq	%rbx
               	leaq	-0x150(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x140(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x120(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x110(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x100(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xf0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rcx
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
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsbq	(%rdx,%rax), %rcx
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	movb	$-0x1, 0x1(%rcx)
               	movb	%al, 0x2(%rcx)
               	movb	$-0x1, 0x3(%rcx)
               	movb	%al, 0x4(%rcx)
               	movb	$-0x1, 0x5(%rcx)
               	movb	%al, 0x6(%rcx)
               	movb	$0x0, 0x7(%rcx)
               	movb	$0x0, 0x8(%rcx)
               	movb	$-0x1, 0x9(%rcx)
               	movb	$0x0, 0xa(%rcx)
               	movb	$0x0, 0xb(%rcx)
               	movb	$0x0, 0xc(%rcx)
               	movb	$-0x1, 0xd(%rcx)
               	movb	$0x0, 0xe(%rcx)
               	xorl	%edx, %edx
               	movb	%dl, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x150(%rbp), %rsi
               	leaq	-0x140(%rbp), %rdi
               	leaq	-0x10(%rbp), %r8
               	movzbq	(%rsi,%rax), %rcx
               	movzbq	(%rdi,%rax), %r9
               	cmpl	%r9d, %ecx
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	movb	%cl, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x140(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movzbq	(%rdx,%rax), %rcx
               	movzbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x140(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movzbq	(%rdx,%rax), %rcx
               	movzbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x140(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setbe	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setbe	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movzbq	(%rdx,%rax), %rcx
               	movzbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jg	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x140(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	seta	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movzbq	(%rdx,%rax), %rcx
               	movzbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x140(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	movzbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	movzbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	movzbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	movzbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	movzbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	movzbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	movzbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	movzbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movzbq	(%rdx,%rax), %rcx
               	movzbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x120(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movsbq	(%rdx,%rax), %rcx
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x120(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movsbq	(%rdx,%rax), %rcx
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x120(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setl	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movsbq	(%rdx,%rax), %rcx
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x120(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setle	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movsbq	(%rdx,%rax), %rcx
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jg	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x120(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movsbq	(%rdx,%rax), %rcx
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0x120(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	movsbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setge	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movsbq	0x1(%rdx), %rdi
               	movsbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movsbq	0x2(%rdx), %rdi
               	movsbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movsbq	0x3(%rdx), %rdi
               	movsbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movsbq	0x4(%rdx), %rdi
               	movsbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movsbq	0x5(%rdx), %rdi
               	movsbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movsbq	0x6(%rdx), %rdi
               	movsbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movsbq	0x7(%rdx), %rdi
               	movsbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movsbq	0x8(%rdx), %rdi
               	movsbq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movsbq	0x9(%rdx), %rdi
               	movsbq	0x9(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movsbq	0xa(%rdx), %rdi
               	movsbq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movsbq	0xb(%rdx), %rdi
               	movsbq	0xb(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movsbq	0xc(%rdx), %rdi
               	movsbq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movsbq	0xd(%rdx), %rdi
               	movsbq	0xd(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movsbq	0xe(%rdx), %rdi
               	movsbq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movsbq	0xf(%rdx), %rdi
               	movsbq	0xf(%rsi), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
               	movsbq	(%rdx,%rax), %rcx
               	movsbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %ecx
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rdx
               	leaq	-0x100(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movw	%di, (%rcx)
               	movzwq	0x2(%rdx), %rdi
               	movzwq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x2(%rcx)
               	movzwq	0x4(%rdx), %rdi
               	movzwq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x4(%rcx)
               	movzwq	0x6(%rdx), %rdi
               	movzwq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x6(%rcx)
               	movzwq	0x8(%rdx), %rdi
               	movzwq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x8(%rcx)
               	movzwq	0xa(%rdx), %rdi
               	movzwq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xa(%rcx)
               	movzwq	0xc(%rdx), %rdi
               	movzwq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xc(%rcx)
               	movzwq	0xe(%rdx), %rdi
               	movzwq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
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
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rdx
               	leaq	-0x100(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movw	%di, (%rcx)
               	movzwq	0x2(%rdx), %rdi
               	movzwq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x2(%rcx)
               	movzwq	0x4(%rdx), %rdi
               	movzwq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x4(%rcx)
               	movzwq	0x6(%rdx), %rdi
               	movzwq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x6(%rcx)
               	movzwq	0x8(%rdx), %rdi
               	movzwq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x8(%rcx)
               	movzwq	0xa(%rdx), %rdi
               	movzwq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xa(%rcx)
               	movzwq	0xc(%rdx), %rdi
               	movzwq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xc(%rcx)
               	movzwq	0xe(%rdx), %rdi
               	movzwq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
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
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rdx
               	leaq	-0x100(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzwq	(%rdx), %rax
               	movzwq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setae	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movw	%di, (%rcx)
               	movzwq	0x2(%rdx), %rdi
               	movzwq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x2(%rcx)
               	movzwq	0x4(%rdx), %rdi
               	movzwq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x4(%rcx)
               	movzwq	0x6(%rdx), %rdi
               	movzwq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x6(%rcx)
               	movzwq	0x8(%rdx), %rdi
               	movzwq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x8(%rcx)
               	movzwq	0xa(%rdx), %rdi
               	movzwq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xa(%rcx)
               	movzwq	0xc(%rdx), %rdi
               	movzwq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xc(%rcx)
               	movzwq	0xe(%rdx), %rdi
               	movzwq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
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
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movw	%di, (%rcx)
               	movswq	0x2(%rdx), %rdi
               	movswq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x2(%rcx)
               	movswq	0x4(%rdx), %rdi
               	movswq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x4(%rcx)
               	movswq	0x6(%rdx), %rdi
               	movswq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x6(%rcx)
               	movswq	0x8(%rdx), %rdi
               	movswq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x8(%rcx)
               	movswq	0xa(%rdx), %rdi
               	movswq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xa(%rcx)
               	movswq	0xc(%rdx), %rdi
               	movswq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xc(%rcx)
               	movswq	0xe(%rdx), %rdi
               	movswq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
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
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setle	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movw	%di, (%rcx)
               	movswq	0x2(%rdx), %rdi
               	movswq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x2(%rcx)
               	movswq	0x4(%rdx), %rdi
               	movswq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x4(%rcx)
               	movswq	0x6(%rdx), %rdi
               	movswq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x6(%rcx)
               	movswq	0x8(%rdx), %rdi
               	movswq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x8(%rcx)
               	movswq	0xa(%rdx), %rdi
               	movswq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xa(%rcx)
               	movswq	0xc(%rdx), %rdi
               	movswq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xc(%rcx)
               	movswq	0xe(%rdx), %rdi
               	movswq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
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
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movswq	(%rdx), %rax
               	movswq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movw	%di, (%rcx)
               	movswq	0x2(%rdx), %rdi
               	movswq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x2(%rcx)
               	movswq	0x4(%rdx), %rdi
               	movswq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x4(%rcx)
               	movswq	0x6(%rdx), %rdi
               	movswq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x6(%rcx)
               	movswq	0x8(%rdx), %rdi
               	movswq	0x8(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0x8(%rcx)
               	movswq	0xa(%rdx), %rdi
               	movswq	0xa(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xa(%rcx)
               	movswq	0xc(%rdx), %rdi
               	movswq	0xc(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xc(%rcx)
               	movswq	0xe(%rdx), %rdi
               	movswq	0xe(%rsi), %r8
               	cmpl	%r8d, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movw	%di, 0xe(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x10(%rbp), %rdi
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
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xd0(%rbp), %rdx
               	leaq	-0xc0(%rbp), %rcx
               	movl	(%rdx), %eax
               	movl	(%rcx), %esi
               	cmpl	%esi, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movl	0x4(%rdx), %edi
               	movl	0x4(%rcx), %r8d
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0x8(%rdx), %r8d
               	movl	0x8(%rcx), %r9d
               	cmpl	%r9d, %r8d
               	setb	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	0xc(%rdx), %r9d
               	movl	0xc(%rcx), %ecx
               	cmpl	%ecx, %r9d
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xc0(%rbp), %r8
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movl	(%rdi), %edi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %edi
               	jae	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xd0(%rbp), %rdx
               	leaq	-0xc0(%rbp), %rcx
               	movl	(%rdx), %eax
               	movl	(%rcx), %esi
               	cmpl	%esi, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movl	0x4(%rdx), %edi
               	movl	0x4(%rcx), %r8d
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0x8(%rdx), %r8d
               	movl	0x8(%rcx), %r9d
               	cmpl	%r9d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	0xc(%rdx), %r9d
               	movl	0xc(%rcx), %ecx
               	cmpl	%ecx, %r9d
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xc0(%rbp), %r8
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movl	(%rdi), %edi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %edi
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rcx
               	movslq	(%rdx), %rax
               	movslq	(%rcx), %rsi
               	cmpl	%esi, %eax
               	setl	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movslq	0x4(%rdx), %rdi
               	movslq	0x4(%rcx), %r8
               	cmpl	%r8d, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movslq	0x8(%rdx), %r8
               	movslq	0x8(%rcx), %r9
               	cmpl	%r9d, %r8d
               	setl	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movslq	0xc(%rdx), %r9
               	movslq	0xc(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xa0(%rbp), %r8
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movslq	(%rdi), %rdi
               	addq	%r8, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %edi
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rcx
               	movslq	(%rdx), %rax
               	movslq	(%rcx), %rsi
               	cmpl	%esi, %eax
               	setge	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movslq	0x4(%rdx), %rdi
               	movslq	0x4(%rcx), %r8
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movslq	0x8(%rdx), %r8
               	movslq	0x8(%rcx), %r9
               	cmpl	%r9d, %r8d
               	setge	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movslq	0xc(%rdx), %r9
               	movslq	0xc(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xa0(%rbp), %r8
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movslq	(%rdi), %rdi
               	addq	%r8, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %edi
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rcx
               	movslq	(%rdx), %rax
               	movslq	(%rcx), %rsi
               	cmpl	%esi, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movslq	0x4(%rdx), %rdi
               	movslq	0x4(%rcx), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movslq	0x8(%rdx), %r8
               	movslq	0x8(%rcx), %r9
               	cmpl	%r9d, %r8d
               	setne	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movslq	0xc(%rdx), %r9
               	movslq	0xc(%rcx), %rcx
               	cmpl	%ecx, %r9d
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	%edi, 0x4(%rcx)
               	movl	%r8d, 0x8(%rcx)
               	movl	%r9d, 0xc(%rcx)
               	leaq	-0xa0(%rbp), %r8
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rsi
               	leaq	(%rdx,%rcx), %rdi
               	movslq	(%rdi), %rdi
               	addq	%r8, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %edi
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	negq	%r8
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %r9
               	cmpq	%r9, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %r9
               	jae	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x80(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	negq	%r8
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %r9
               	cmpq	%r9, %rcx
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %r9
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rsi
               	leaq	-0x60(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	setl	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	negq	%r8
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %r9
               	cmpq	%r9, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %r9
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rsi
               	leaq	-0x60(%rbp), %rdi
               	movq	(%rsi), %rax
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	negq	%r8
               	movq	0x8(%rsi), %rcx
               	movq	0x8(%rdi), %r9
               	cmpq	%r9, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %r9
               	movq	(%r9), %r9
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %r9
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	movzbq	(%rsi), %rdi
               	cmpl	%edi, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	movzbq	0x1(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	movzbq	0x2(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	movzbq	0x3(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	movzbq	0x4(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	movzbq	0x5(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	movzbq	0x6(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	movzbq	0x7(%rsi), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rcx), %r10
               	movq	%r10, (%rdi)
               	leaq	-0x8(%rbp), %rdi
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
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	movss	(%rax), %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	(%rdx), %xmm0
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movss	0x4(%rdx), %xmm0
               	movss	0x4(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movss	0x8(%rdx), %xmm0
               	movss	0x8(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movss	0xc(%rdx), %xmm0
               	movss	0xc(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
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
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x50(%rbp), %rsi
               	movss	(%rdx), %xmm0
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movss	0x4(%rdx), %xmm0
               	movss	0x4(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movss	0x8(%rdx), %xmm0
               	movss	0x8(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movss	0xc(%rdx), %xmm0
               	movss	0xc(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
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
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x50(%rbp), %rsi
               	movss	(%rdx), %xmm0
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movss	0x4(%rdx), %xmm0
               	movss	0x4(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movss	0x8(%rdx), %xmm0
               	movss	0x8(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movss	0xc(%rdx), %xmm0
               	movss	0xc(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x50(%rbp), %rsi
               	movss	(%rdx), %xmm0
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movss	0x4(%rdx), %xmm0
               	movss	0x4(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movss	0x8(%rdx), %xmm0
               	movss	0x8(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movss	0xc(%rdx), %xmm0
               	movss	0xc(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jb	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x50(%rbp), %rsi
               	movss	(%rdx), %xmm0
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movss	0x4(%rdx), %xmm0
               	movss	0x4(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movss	0x8(%rdx), %xmm0
               	movss	0x8(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movss	0xc(%rdx), %xmm0
               	movss	0xc(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x50(%rbp), %rsi
               	movss	(%rdx), %xmm0
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movss	0x4(%rdx), %xmm0
               	movss	0x4(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movss	0x8(%rdx), %xmm0
               	movss	0x8(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movss	0xc(%rdx), %xmm0
               	movss	0xc(%rsi), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jb	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rsi
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movss	0x4(%rsi), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movss	0x8(%rsi), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movss	0xc(%rsi), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, 0x8(%rdx)
               	movsd	(%rdx), %xmm0
               	movsd	(%rsi), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movsd	0x8(%rdx), %xmm0
               	movsd	0x8(%rsi), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	leaq	-0x40(%rbp), %rcx
               	movq	%rdi, (%rcx)
               	movq	%r8, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movsd	(%r8), %xmm0
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0x50(%rbp), %rdi
               	movsd	(%rsi), %xmm0
               	movsd	(%rdi), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	negq	%r8
               	movsd	0x8(%rsi), %xmm0
               	movsd	0x8(%rdi), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %r9
               	movsd	(%r9), %xmm0
               	addq	%rdi, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0x50(%rbp), %rdi
               	movsd	(%rsi), %xmm0
               	movsd	(%rdi), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	negq	%r8
               	movsd	0x8(%rsi), %xmm0
               	movsd	0x8(%rdi), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	leaq	-0x40(%rbp), %rcx
               	movq	%r8, (%rcx)
               	movq	%r9, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rsi,%rcx), %r9
               	movsd	(%r9), %xmm0
               	addq	%rdi, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	cmpl	$0x64, %eax
               	seta	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rdx,%rax), %rcx
               	cmpl	$0x64, %ecx
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	cmpl	$0x3, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rdx,%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	cmpl	$0xff, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rdx,%rax), %rcx
               	cmpl	$0xff, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %rdx
               	movq	$-0x5, %rdi
               	leaq	-0x40(%rbp), %rcx
               	movsbq	(%rdx), %rax
               	cmpl	%edi, %eax
               	setg	%r8b
               	movzbq	%r8b, %r8
               	xorl	%eax, %eax
               	negq	%r8
               	movb	%r8b, (%rcx)
               	movsbq	0x1(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x1(%rcx)
               	movsbq	0x2(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x2(%rcx)
               	movsbq	0x3(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x3(%rcx)
               	movsbq	0x4(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x4(%rcx)
               	movsbq	0x5(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x5(%rcx)
               	movsbq	0x6(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x6(%rcx)
               	movsbq	0x7(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x7(%rcx)
               	movsbq	0x8(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x8(%rcx)
               	movsbq	0x9(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0x9(%rcx)
               	movsbq	0xa(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0xa(%rcx)
               	movsbq	0xb(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0xb(%rcx)
               	movsbq	0xc(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0xc(%rcx)
               	movsbq	0xd(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0xd(%rcx)
               	movsbq	0xe(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, 0xe(%rcx)
               	movsbq	0xf(%rdx), %r8
               	cmpl	%edi, %r8d
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movsbq	(%rdx,%rax), %rcx
               	cmpl	$-0x5, %ecx
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	xorl	%eax, %eax
               	movslq	(%rsi), %rcx
               	testl	%ecx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	movslq	0x4(%rsi), %rcx
               	testl	%ecx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movslq	0x8(%rsi), %rcx
               	testl	%ecx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movslq	0xc(%rsi), %rcx
               	testl	%ecx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rsi
               	movq	(%rsi), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	negq	%rdi
               	movq	0x8(%rsi), %rcx
               	cmpq	$0x5, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	leaq	-0x40(%rbp), %rcx
               	movq	%rdi, (%rcx)
               	movq	%r8, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rdx), %rax
               	cmpl	$0x64, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, (%rcx)
               	movzbq	0x1(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x1(%rcx)
               	movzbq	0x2(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x2(%rcx)
               	movzbq	0x3(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x3(%rcx)
               	movzbq	0x4(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x4(%rcx)
               	movzbq	0x5(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x5(%rcx)
               	movzbq	0x6(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x6(%rcx)
               	movzbq	0x7(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x7(%rcx)
               	movzbq	0x8(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xb(%rcx)
               	movzbq	0xc(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xc(%rcx)
               	movzbq	0xd(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xd(%rcx)
               	movzbq	0xe(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xe(%rcx)
               	movzbq	0xf(%rdx), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0xf(%rcx)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rdx,%rax), %rcx
               	cmpl	$0x64, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0xb0(%rbp), %rsi
               	movslq	(%rsi), %rcx
               	testl	%ecx, %ecx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	movslq	0x4(%rsi), %rcx
               	testl	%ecx, %ecx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r8
               	negq	%r8
               	movslq	0x8(%rsi), %rcx
               	testl	%ecx, %ecx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %r9
               	negq	%r9
               	movslq	0xc(%rsi), %rcx
               	testl	%ecx, %ecx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	leaq	-0x40(%rbp), %rcx
               	movl	%edi, (%rcx)
               	movl	%r8d, 0x4(%rcx)
               	movl	%r9d, 0x8(%rcx)
               	movl	%ebx, 0xc(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0xffffffff, (%rax)     # imm = 0xFFFFFFFF
               	movl	$0x0, 0x4(%rax)
               	movl	$0xffffffff, 0x8(%rax)  # imm = 0xFFFFFFFF
               	movl	$0x0, 0xc(%rax)
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	movabsq	$0x500000001, %rdi      # imm = 0x500000001
               	andq	%rsi, %rdi
               	movabsq	$0x900000003, %r8       # imm = 0x900000003
               	andq	%rax, %r8
               	leaq	-0x40(%rbp), %rax
               	movl	$0x0, (%rax)
               	movl	$0xffffffff, 0x4(%rax)  # imm = 0xFFFFFFFF
               	leaq	0x8(%rax), %rsi
               	movl	$0x0, (%rsi)
               	movl	$0xffffffff, 0xc(%rax)  # imm = 0xFFFFFFFF
               	movq	(%rax), %rax
               	movabsq	$0x400000002, %rcx      # imm = 0x400000002
               	andq	%rax, %rcx
               	movq	(%rsi), %rax
               	movabsq	$0x800000006, %rdx      # imm = 0x800000006
               	andq	%rax, %rdx
               	leaq	-0x40(%rbp), %rax
               	orq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	movq	%r8, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	0x8(%rax), %esi
               	movl	0xc(%rax), %edi
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpl	$0x4, %edx
               	jne	<addr>
               	cmpl	$0x3, %esi
               	jne	<addr>
               	cmpl	$0x8, %edi
               	je	<addr>
               	movl	$0x33, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x31, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x30, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2f, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2e, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2d, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2c, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2b, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x29, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x28, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x27, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x26, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x25, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x24, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x23, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x22, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x21, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x20, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1f, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1e, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1d, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1c, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1b, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
