
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
               	subq	$0x150, %rsp            # imm = 0x150
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
               	leaq	-0x40(%rbp), %rdx
               	xorl	%eax, %eax
               	movb	$-0x1, -0x40(%rbp)
               	movb	$-0x1, -0x3f(%rbp)
               	movb	$-0x1, -0x3e(%rbp)
               	movb	$-0x1, -0x3d(%rbp)
               	movb	$-0x1, -0x3c(%rbp)
               	movb	$-0x1, -0x3b(%rbp)
               	movb	$-0x1, -0x3a(%rbp)
               	movb	$-0x1, -0x39(%rbp)
               	movb	$-0x1, -0x38(%rbp)
               	movb	$-0x1, -0x37(%rbp)
               	movb	$-0x1, -0x36(%rbp)
               	movb	$-0x1, -0x35(%rbp)
               	movb	$-0x1, -0x34(%rbp)
               	movb	$-0x1, -0x33(%rbp)
               	movb	$-0x1, -0x32(%rbp)
               	movb	$-0x1, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$-0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rsi
               	xorl	%eax, %eax
               	movb	%al, -0x40(%rbp)
               	movb	$-0x1, -0x3f(%rbp)
               	movb	%al, -0x3e(%rbp)
               	movb	$-0x1, -0x3d(%rbp)
               	movb	%al, -0x3c(%rbp)
               	movb	$-0x1, -0x3b(%rbp)
               	movb	%al, -0x3a(%rbp)
               	movb	$0x0, -0x39(%rbp)
               	movb	$0x0, -0x38(%rbp)
               	movb	$-0x1, -0x37(%rbp)
               	movb	$0x0, -0x36(%rbp)
               	movb	$0x0, -0x35(%rbp)
               	movb	$0x0, -0x34(%rbp)
               	movb	$-0x1, -0x33(%rbp)
               	movb	$0x0, -0x32(%rbp)
               	xorl	%edx, %edx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
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
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x140(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x140(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x140(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	setbe	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jg	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x140(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x150(%rbp), %rdi
               	leaq	-0x140(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	setae	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x120(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movsbq	(%rdi,%rax), %rcx
               	movsbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x120(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movsbq	(%rdi,%rax), %rcx
               	movsbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x120(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	setl	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movsbq	(%rdi,%rax), %rcx
               	movsbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x120(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	setle	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movsbq	(%rdi,%rax), %rcx
               	movsbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jg	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x120(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	setg	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movsbq	(%rdi,%rax), %rcx
               	movsbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x130(%rbp), %rdi
               	leaq	-0x120(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	setge	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x40(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x39(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x38(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x37(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x36(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x35(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x34(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x33(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x32(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movsbq	(%rdi,%rax), %rcx
               	movsbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x100(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movzwq	-0x110(%rbp), %rax
               	movzwq	-0x100(%rbp), %rdx
               	cmpl	%edx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x40(%rbp)
               	movzwq	-0x10e(%rbp), %rdx
               	movzwq	-0xfe(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3e(%rbp)
               	movzwq	-0x10c(%rbp), %rdx
               	movzwq	-0xfc(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3c(%rbp)
               	movzwq	-0x10a(%rbp), %rdx
               	movzwq	-0xfa(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3a(%rbp)
               	movzwq	-0x108(%rbp), %rdx
               	movzwq	-0xf8(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x38(%rbp)
               	movzwq	-0x106(%rbp), %rdx
               	movzwq	-0xf6(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x36(%rbp)
               	movzwq	-0x104(%rbp), %rdx
               	movzwq	-0xf4(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x34(%rbp)
               	movzwq	-0x102(%rbp), %rdx
               	movzwq	-0xf2(%rbp), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x32(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movzwq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdx)
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
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x100(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movzwq	-0x110(%rbp), %rax
               	movzwq	-0x100(%rbp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x40(%rbp)
               	movzwq	-0x10e(%rbp), %rdx
               	movzwq	-0xfe(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3e(%rbp)
               	movzwq	-0x10c(%rbp), %rdx
               	movzwq	-0xfc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3c(%rbp)
               	movzwq	-0x10a(%rbp), %rdx
               	movzwq	-0xfa(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3a(%rbp)
               	movzwq	-0x108(%rbp), %rdx
               	movzwq	-0xf8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x38(%rbp)
               	movzwq	-0x106(%rbp), %rdx
               	movzwq	-0xf6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x36(%rbp)
               	movzwq	-0x104(%rbp), %rdx
               	movzwq	-0xf4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x34(%rbp)
               	movzwq	-0x102(%rbp), %rdx
               	movzwq	-0xf2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x32(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movzwq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %esi
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdx)
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
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x100(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movzwq	-0x110(%rbp), %rax
               	movzwq	-0x100(%rbp), %rdx
               	cmpl	%edx, %eax
               	setae	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x40(%rbp)
               	movzwq	-0x10e(%rbp), %rdx
               	movzwq	-0xfe(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3e(%rbp)
               	movzwq	-0x10c(%rbp), %rdx
               	movzwq	-0xfc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3c(%rbp)
               	movzwq	-0x10a(%rbp), %rdx
               	movzwq	-0xfa(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3a(%rbp)
               	movzwq	-0x108(%rbp), %rdx
               	movzwq	-0xf8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x38(%rbp)
               	movzwq	-0x106(%rbp), %rdx
               	movzwq	-0xf6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x36(%rbp)
               	movzwq	-0x104(%rbp), %rdx
               	movzwq	-0xf4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x34(%rbp)
               	movzwq	-0x102(%rbp), %rdx
               	movzwq	-0xf2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x32(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movzwq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %esi
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdx)
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
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0xe0(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movswq	-0xf0(%rbp), %rax
               	movswq	-0xe0(%rbp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x40(%rbp)
               	movswq	-0xee(%rbp), %rdx
               	movswq	-0xde(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3e(%rbp)
               	movswq	-0xec(%rbp), %rdx
               	movswq	-0xdc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3c(%rbp)
               	movswq	-0xea(%rbp), %rdx
               	movswq	-0xda(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3a(%rbp)
               	movswq	-0xe8(%rbp), %rdx
               	movswq	-0xd8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x38(%rbp)
               	movswq	-0xe6(%rbp), %rdx
               	movswq	-0xd6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x36(%rbp)
               	movswq	-0xe4(%rbp), %rdx
               	movswq	-0xd4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x34(%rbp)
               	movswq	-0xe2(%rbp), %rdx
               	movswq	-0xd2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x32(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movswq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %esi
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdx)
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
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0xe0(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movswq	-0xf0(%rbp), %rax
               	movswq	-0xe0(%rbp), %rdx
               	cmpl	%edx, %eax
               	setle	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x40(%rbp)
               	movswq	-0xee(%rbp), %rdx
               	movswq	-0xde(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3e(%rbp)
               	movswq	-0xec(%rbp), %rdx
               	movswq	-0xdc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3c(%rbp)
               	movswq	-0xea(%rbp), %rdx
               	movswq	-0xda(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3a(%rbp)
               	movswq	-0xe8(%rbp), %rdx
               	movswq	-0xd8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x38(%rbp)
               	movswq	-0xe6(%rbp), %rdx
               	movswq	-0xd6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x36(%rbp)
               	movswq	-0xe4(%rbp), %rdx
               	movswq	-0xd4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x34(%rbp)
               	movswq	-0xe2(%rbp), %rdx
               	movswq	-0xd2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x32(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movswq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %esi
               	jg	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdx)
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
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0xe0(%rbp), %r8
               	leaq	-0x40(%rbp), %rcx
               	movswq	-0xf0(%rbp), %rax
               	movswq	-0xe0(%rbp), %rdx
               	cmpl	%edx, %eax
               	setg	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x40(%rbp)
               	movswq	-0xee(%rbp), %rdx
               	movswq	-0xde(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3e(%rbp)
               	movswq	-0xec(%rbp), %rdx
               	movswq	-0xdc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3c(%rbp)
               	movswq	-0xea(%rbp), %rdx
               	movswq	-0xda(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x3a(%rbp)
               	movswq	-0xe8(%rbp), %rdx
               	movswq	-0xd8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x38(%rbp)
               	movswq	-0xe6(%rbp), %rdx
               	movswq	-0xd6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x36(%rbp)
               	movswq	-0xe4(%rbp), %rdx
               	movswq	-0xd4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x34(%rbp)
               	movswq	-0xe2(%rbp), %rdx
               	movswq	-0xd2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x32(%rbp)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movswq	(%rsi), %rsi
               	addq	%r8, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %esi
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdx)
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
               	leaq	-0xd0(%rbp), %rdi
               	movl	-0xd0(%rbp), %eax
               	movl	-0xc0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	-0xcc(%rbp), %edx
               	movl	-0xbc(%rbp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xc8(%rbp), %esi
               	movl	-0xb8(%rbp), %r8d
               	cmpl	%r8d, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xc4(%rbp), %r8d
               	movl	-0xb4(%rbp), %r9d
               	cmpl	%r9d, %r8d
               	setb	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r8d, -0x34(%rbp)
               	leaq	-0xc0(%rbp), %r8
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %esi
               	jae	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0xd0(%rbp), %rdi
               	movl	-0xd0(%rbp), %eax
               	movl	-0xc0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	-0xcc(%rbp), %edx
               	movl	-0xbc(%rbp), %esi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xc8(%rbp), %esi
               	movl	-0xb8(%rbp), %r8d
               	cmpl	%r8d, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xc4(%rbp), %r8d
               	movl	-0xb4(%rbp), %r9d
               	cmpl	%r9d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r8d, -0x34(%rbp)
               	leaq	-0xc0(%rbp), %r8
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0xb0(%rbp), %rdi
               	movl	-0xb0(%rbp), %eax
               	movl	-0xa0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	-0xac(%rbp), %edx
               	movl	-0x9c(%rbp), %esi
               	cmpl	%esi, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xa8(%rbp), %esi
               	movl	-0x98(%rbp), %r8d
               	cmpl	%r8d, %esi
               	setl	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa4(%rbp), %r8d
               	movl	-0x94(%rbp), %r9d
               	cmpl	%r9d, %r8d
               	setl	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r8d, -0x34(%rbp)
               	leaq	-0xa0(%rbp), %r8
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %esi
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0xb0(%rbp), %rdi
               	movl	-0xb0(%rbp), %eax
               	movl	-0xa0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setge	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	-0xac(%rbp), %edx
               	movl	-0x9c(%rbp), %esi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xa8(%rbp), %esi
               	movl	-0x98(%rbp), %r8d
               	cmpl	%r8d, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa4(%rbp), %r8d
               	movl	-0x94(%rbp), %r9d
               	cmpl	%r9d, %r8d
               	setge	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r8d, -0x34(%rbp)
               	leaq	-0xa0(%rbp), %r8
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %esi
               	jl	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0xb0(%rbp), %rdi
               	movl	-0xb0(%rbp), %eax
               	movl	-0xa0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	-0xac(%rbp), %edx
               	movl	-0x9c(%rbp), %esi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xa8(%rbp), %esi
               	movl	-0x98(%rbp), %r8d
               	cmpl	%r8d, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa4(%rbp), %r8d
               	movl	-0x94(%rbp), %r9d
               	cmpl	%r9d, %r8d
               	setne	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r8d, -0x34(%rbp)
               	leaq	-0xa0(%rbp), %r8
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	cmpl	%ecx, %esi
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0x90(%rbp), %r8
               	leaq	-0x80(%rbp), %r9
               	movq	-0x90(%rbp), %rax
               	movq	-0x80(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movq	-0x88(%rbp), %rsi
               	movq	-0x78(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rcx, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jae	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rsi)
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
               	leaq	-0x90(%rbp), %r8
               	leaq	-0x80(%rbp), %r9
               	movq	-0x90(%rbp), %rax
               	movq	-0x80(%rbp), %rcx
               	cmpq	%rcx, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movq	-0x88(%rbp), %rsi
               	movq	-0x78(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rcx, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rsi)
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
               	leaq	-0x70(%rbp), %r8
               	leaq	-0x60(%rbp), %r9
               	movq	-0x70(%rbp), %rax
               	movq	-0x60(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setl	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movq	-0x68(%rbp), %rsi
               	movq	-0x58(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	setl	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rcx, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rsi)
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
               	leaq	-0x70(%rbp), %r8
               	leaq	-0x60(%rbp), %r9
               	movq	-0x70(%rbp), %rax
               	movq	-0x60(%rbp), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movq	-0x68(%rbp), %rsi
               	movq	-0x58(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rcx, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rsi)
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
               	leaq	-0x28(%rbp), %rdi
               	leaq	-0x20(%rbp), %r8
               	leaq	-0x8(%rbp), %rcx
               	movzbq	-0x28(%rbp), %rax
               	movzbq	-0x20(%rbp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x27(%rbp), %rdx
               	movzbq	-0x1f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x7(%rbp)
               	movzbq	-0x26(%rbp), %rdx
               	movzbq	-0x1e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x6(%rbp)
               	movzbq	-0x25(%rbp), %rdx
               	movzbq	-0x1d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x5(%rbp)
               	movzbq	-0x24(%rbp), %rdx
               	movzbq	-0x1c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4(%rbp)
               	movzbq	-0x23(%rbp), %rdx
               	movzbq	-0x1b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3(%rbp)
               	movzbq	-0x22(%rbp), %rdx
               	movzbq	-0x1a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x2(%rbp)
               	movzbq	-0x21(%rbp), %rdx
               	movzbq	-0x19(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1(%rbp)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0x58(%rbp)
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x50(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x4c(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x48(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r8
               	negq	%r8
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x44(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%edi, -0x3c(%rbp)
               	movl	%r8d, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
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
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %r8
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x50(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x4c(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x48(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x44(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%r9b
               	movzbq	%r9b, %r9
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movss	(%rsi), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %r8
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x50(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x4c(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x48(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x44(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setb	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movss	(%rsi), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %r8
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x50(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x4c(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x48(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x44(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setbe	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movss	(%rsi), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jb	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %r8
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x50(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x4c(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x48(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x44(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	seta	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movss	(%rsi), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %r8
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x50(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x4c(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x48(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x44(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setae	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%edx, -0x3c(%rbp)
               	movl	%esi, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movss	(%rsi), %xmm0
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jb	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
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
               	leaq	-0x60(%rbp), %rdi
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	movss	-0x60(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	-0x58(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movss	-0x54(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	seta	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%esi, -0x3c(%rbp)
               	movl	%r8d, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	addq	%rdi, %rcx
               	movss	(%rcx), %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jbe	<addr>
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
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movsd	-0x8(%rbp), %xmm0
               	movsd	%xmm0, -0x58(%rbp)
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x50(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movsd	-0x58(%rbp), %xmm0
               	movsd	-0x48(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movq	%rcx, -0x40(%rbp)
               	movq	%rdi, -0x38(%rbp)
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
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x50(%rbp), %r9
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x50(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movsd	-0x58(%rbp), %xmm0
               	movsd	-0x48(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movq	%rcx, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movsd	(%rdi), %xmm0
               	addq	%r9, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rsi)
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
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x50(%rbp), %r9
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x50(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movsd	-0x58(%rbp), %xmm0
               	movsd	-0x48(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	negq	%rsi
               	movq	%rcx, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movsd	(%rdi), %xmm0
               	addq	%r9, %rcx
               	movsd	(%rcx), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rsi)
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
               	leaq	-0x150(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	cmpl	$0x64, %eax
               	seta	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdi
               	cmpl	$0x64, %edi
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rsi,%rax), %rcx
               	cmpl	$0x64, %ecx
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x150(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	cmpl	$0x3, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdi
               	cmpl	$0x3, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rsi,%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x150(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	cmpl	$0xff, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdi
               	cmpl	$0xff, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rsi,%rax), %rcx
               	cmpl	$0xff, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0x130(%rbp), %rsi
               	movq	$-0x5, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movsbq	-0x130(%rbp), %rax
               	cmpl	%ecx, %eax
               	setg	%r8b
               	movzbq	%r8b, %r8
               	xorl	%eax, %eax
               	negq	%r8
               	movb	%r8b, -0x40(%rbp)
               	movsbq	-0x12f(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x3f(%rbp)
               	movsbq	-0x12e(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x3e(%rbp)
               	movsbq	-0x12d(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x3d(%rbp)
               	movsbq	-0x12c(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x3c(%rbp)
               	movsbq	-0x12b(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x3b(%rbp)
               	movsbq	-0x12a(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x3a(%rbp)
               	movsbq	-0x129(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x39(%rbp)
               	movsbq	-0x128(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x38(%rbp)
               	movsbq	-0x127(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x37(%rbp)
               	movsbq	-0x126(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x36(%rbp)
               	movsbq	-0x125(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x35(%rbp)
               	movsbq	-0x124(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x34(%rbp)
               	movsbq	-0x123(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x33(%rbp)
               	movsbq	-0x122(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movb	%r8b, -0x32(%rbp)
               	movsbq	-0x121(%rbp), %r8
               	cmpl	%ecx, %r8d
               	setg	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movb	%cl, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	movsbq	(%rsi,%rax), %rcx
               	cmpl	$-0x5, %ecx
               	jle	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0xb0(%rbp), %rdi
               	xorl	%eax, %eax
               	movl	-0xb0(%rbp), %ecx
               	testl	%ecx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movl	-0xac(%rbp), %esi
               	testl	%esi, %esi
               	setl	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa8(%rbp), %r8d
               	testl	%r8d, %r8d
               	setl	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	-0xa4(%rbp), %r9d
               	testl	%r9d, %r9d
               	setl	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%esi, -0x3c(%rbp)
               	movl	%r8d, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	addq	%rdi, %rcx
               	movl	(%rcx), %ecx
               	testl	%ecx, %ecx
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
               	leaq	-0x90(%rbp), %rdi
               	movq	-0x90(%rbp), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movq	-0x88(%rbp), %rsi
               	cmpq	$0x5, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rcx, -0x40(%rbp)
               	movq	%rsi, -0x38(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rsi)
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
               	leaq	-0x150(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	cmpl	$0x64, %eax
               	setb	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, -0x40(%rbp)
               	movzbq	-0x14f(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3f(%rbp)
               	movzbq	-0x14e(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3e(%rbp)
               	movzbq	-0x14d(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3d(%rbp)
               	movzbq	-0x14c(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3c(%rbp)
               	movzbq	-0x14b(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3b(%rbp)
               	movzbq	-0x14a(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x3a(%rbp)
               	movzbq	-0x149(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x39(%rbp)
               	movzbq	-0x148(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x38(%rbp)
               	movzbq	-0x147(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x37(%rbp)
               	movzbq	-0x146(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x36(%rbp)
               	movzbq	-0x145(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x35(%rbp)
               	movzbq	-0x144(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x34(%rbp)
               	movzbq	-0x143(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x33(%rbp)
               	movzbq	-0x142(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x32(%rbp)
               	movzbq	-0x141(%rbp), %rdi
               	cmpl	$0x64, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x31(%rbp)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rsi,%rax), %rcx
               	cmpl	$0x64, %ecx
               	jge	<addr>
               	movq	$-0x1, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx,%rax)
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
               	leaq	-0xb0(%rbp), %rdi
               	movl	-0xb0(%rbp), %ecx
               	testl	%ecx, %ecx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movl	-0xac(%rbp), %esi
               	testl	%esi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa8(%rbp), %r8d
               	testl	%r8d, %r8d
               	setge	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	-0xa4(%rbp), %r9d
               	testl	%r9d, %r9d
               	setge	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%ecx, -0x40(%rbp)
               	movl	%esi, -0x3c(%rbp)
               	movl	%r8d, -0x38(%rbp)
               	movl	%r9d, -0x34(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	addq	%rdi, %rcx
               	movl	(%rcx), %ecx
               	testl	%ecx, %ecx
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
               	movl	$0xffffffff, -0x40(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x3c(%rbp)
               	movl	$0xffffffff, -0x38(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x34(%rbp)
               	movq	-0x40(%rbp), %rdx
               	movq	-0x38(%rbp), %rsi
               	movabsq	$0x500000001, %rdi      # imm = 0x500000001
               	andq	%rdx, %rdi
               	movabsq	$0x900000003, %r11      # imm = 0x900000003
               	andq	%r11, %rsi
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x0, -0x40(%rbp)
               	movl	$0xffffffff, -0x3c(%rbp) # imm = 0xFFFFFFFF
               	addq	$0x8, %rdx
               	movl	$0x0, (%rdx)
               	movl	$0xffffffff, -0x34(%rbp) # imm = 0xFFFFFFFF
               	movq	-0x40(%rbp), %rax
               	movabsq	$0x400000002, %r11      # imm = 0x400000002
               	andq	%r11, %rax
               	movq	(%rdx), %rcx
               	movabsq	$0x800000006, %r11      # imm = 0x800000006
               	andq	%r11, %rcx
               	orq	%rdi, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rsi, %rax
               	orq	%rcx, %rax
               	movq	%rax, -0x38(%rbp)
               	movl	-0x40(%rbp), %eax
               	movl	-0x3c(%rbp), %ecx
               	movl	-0x38(%rbp), %edx
               	movl	-0x34(%rbp), %esi
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	cmpl	$0x3, %edx
               	jne	<addr>
               	cmpl	$0x8, %esi
               	je	<addr>
               	movl	$0x33, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x31, %eax
               	leave
               	retq
               	movl	$0x30, %eax
               	leave
               	retq
               	movl	$0x2f, %eax
               	leave
               	retq
               	movl	$0x2e, %eax
               	leave
               	retq
               	movl	$0x2d, %eax
               	leave
               	retq
               	movl	$0x2c, %eax
               	leave
               	retq
               	movl	$0x2b, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0x29, %eax
               	leave
               	retq
               	movl	$0x28, %eax
               	leave
               	retq
               	movl	$0x27, %eax
               	leave
               	retq
               	movl	$0x26, %eax
               	leave
               	retq
               	movl	$0x25, %eax
               	leave
               	retq
               	movl	$0x24, %eax
               	leave
               	retq
               	movl	$0x23, %eax
               	leave
               	retq
               	movl	$0x22, %eax
               	leave
               	retq
               	movl	$0x21, %eax
               	leave
               	retq
               	movl	$0x20, %eax
               	leave
               	retq
               	movl	$0x1f, %eax
               	leave
               	retq
               	movl	$0x1e, %eax
               	leave
               	retq
               	movl	$0x1d, %eax
               	leave
               	retq
               	movl	$0x1c, %eax
               	leave
               	retq
               	movl	$0x1b, %eax
               	leave
               	retq
               	movl	$0x1a, %eax
               	leave
               	retq
               	movl	$0x19, %eax
               	leave
               	retq
               	movl	$0x18, %eax
               	leave
               	retq
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	$0x16, %eax
               	leave
               	retq
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
